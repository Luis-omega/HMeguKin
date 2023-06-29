{
module HMeguKin.Parser.Parser(parse) where

import Data.List.NonEmpty(NonEmpty((:|)),cons,reverse)
import Data.List qualified as List
import Prelude hiding(reverse)

import HMeguKin.Parser.Types(Token(..),Range) 
import HMeguKin.Parser.Types qualified as Types
import HMeguKin.Parser.SST hiding (LiteralUint,Case,Let)
import HMeguKin.Parser.SST qualified as SST

import Debug.Trace(trace)
}

%name parse
%tokentype { Token }
%errorhandlertype explist
%error { parseError }

%token
  Variable {TokenVariable _ $$}
  Hole {Hole $$}
  Int {LiteralUint _ _}
  LParen {LeftParen $$}
  RParen {RightParen $$}
  LBrace {LeftBrace $$}
  RBrace {RightBrace $$}
  Colon {Colon $$}
  Comma {Comma $$}
  BackTick {BackTick $$}
  LayoutStart {LayoutStart $$}
  LayoutSeparator {LayoutSeparator $$}
  LayoutEnd {LayoutEnd $$}
  RightArrow {RightArrow $$}
  TokenOperator {TokenOperator _ _}
  Forall {Forall $$}
  Dot {Dot $$}
  Data {Data $$}
  Equal {Equal $$}
  At {At $$}
  Case {Case $$}
  Of {Of $$}
  Lambda {LambdaStart $$}
  Let {Let $$}
  In {In $$}

%%

sepBy1(p,sep): p  {$1 :| []}
 | sepBy1(p,sep) sep p {cons $3 $1}

listSepBy1(p,sep) : sepBy1(p,sep) {reverse $1}

parens(p) : LParen p RParen {$2}
braces(p) : LBrace p RBrace {$2}

plus(p): p {$1 :| []}
  | plus(p) p {cons $2 $1}

star(p) : {- empty -} {[]}
  | star(p) p {$2:$1}

list1(p) : plus(p) {reverse $1}

list(p): star(p) {List.reverse $1}

expression :: {Expression}
expression : expression_let {$1}


meta_variable :: {Variable}
meta_variable : Variable {
  tokenVariable2Variable $1
  }

meta_operator :: {Operator}
meta_operator : TokenOperator {
  case $1 of 
    TokenOperator _ op ->
      lexerOperator2Operator op
  }
  | BackTick Variable BackTick {
    let variable = tokenVariable2Variable $2
    in
      VariableAsOperator (getRange variable) variable
  }

-- __________________ PATTERN ____________________________

pattern_match_variable :: {Pattern}
pattern_match_variable : meta_variable {
    VariablePattern (getRange $1) $1
  }

pattern_match_hole :: {Pattern}
pattern_match_hole : Hole {HolePattern $1}

pattern_match_literal :: {Pattern}
pattern_match_literal: Int { 
  let literal=(tokenLiteral2Literal $1) 
  in 
    LiteralPattern (getRange literal) literal
  }

pattern_annotation :: {Pattern}
pattern_annotation : LParen pattern_match Colon type_scheme RParen {
  AnnotationPattern (getRange ($1,$5)) $2 $4
  }

 
pattern_match_atom :: {Pattern}
pattern_match_atom: pattern_match_literal {$1}
  | pattern_match_variable {$1}
  | pattern_match_hole {$1}
  | parens(pattern_match) {$1}
  | pattern_annotation {$1}

pattern_as :: {Pattern}
pattern_as : meta_variable At pattern_match_atom {AsPattern (getRange ($1,$3)) $1 $3}
  | pattern_match_atom {$1}

pattern_match_application :: {Pattern}
pattern_match_application: Variable list1(pattern_as) {
  let variable=(tokenVariable2Variable $1) 
  in
    ApplicationPattern (getRange(variable,$2)) variable $2 
  }
  | pattern_as {$1}

pattern_match :: {Pattern}
pattern_match : pattern_match_application {$1}

pattern_match_function_args :: {NonEmpty Pattern}
pattern_match_function_args: list1(pattern_match) {$1}

-- __________________ TYPE ____________________________

type_record_item :: {(Range,Variable,Type)}
type_record_item : meta_variable Colon type_expression_inner {
    (getRange ($1,$3),$1,$3)
  }

type_record_inner :: {NonEmpty(Range,Variable,Type)}
type_record_inner : listSepBy1(type_record_item,Comma)  {$1}

type_record :: {Type}
type_record : braces(type_record_inner) {
  RecordType (getRange $1) (NonEmptyRecord (getRange $1) $1)
  }


type_variable :: {Type}
type_variable : meta_variable {
  VariableType (getRange $1) $1
              }

type_atom :: {Type}
type_atom : type_variable {$1}
  | parens(type_expression_inner){$1}
  | type_record {$1}

type_application :: {Type}
type_application : type_atom {$1}
  | type_application type_atom  {
  ApplicationType (getRange ($2,$1)) $2 $1
  }

type_operators_plus :: {IntercalatedList Type Operator}
type_operators_plus :  type_application {FirstItem $1}
  | type_operators_plus meta_operator type_application {IntercalatedCons $3 (IntercalatedCons $2 $1)}

type_operators :: {Type}
type_operators : type_operators_plus {
  MeaninglessOperatorsType (getRange $1) $1
  }

type_expression_inner :: {Type}
type_expression_inner: type_operators {$1}
  | type_operators RightArrow type_expression_inner {TypeArrow (getRange ($1,$3)) $1 $3
  }

type_scheme :: {Type}
type_scheme :  type_expression_inner {$1}
  | Forall type_data_type_args Dot type_expression_inner {
  TypeForall (getRange ($2,$4)) $2 $4
  }

type_data_type_args :: {NonEmpty Variable}
type_data_type_args : meta_variable {$1 :| []}
  | type_data_type_args meta_variable {cons $2 $1}

type_expression_inner_sep_comma :: {[Type]}
type_expression_inner_sep_comma : type_expression_inner  {[$1]}
  | type_expression_inner_sep_comma Comma type_expression_inner {
    $3:$1
  }


-- __________________ DATA ____________________________

data_type_constructor :: {Constructor}
data_type_constructor : meta_variable {
    Constructor (getRange $1) $1 [] 
  }
  | meta_variable type_expression_inner_sep_comma {
    Constructor (getRange $1) $1 $2 
  }

data_type_constructor_plus :: {NonEmpty Constructor}
data_type_constructor_plus : data_type_constructor {$1:|[]}
  | data_type_constructor_plus Comma data_type_constructor {
    cons $3 $1
  }

data_type :: {ModuleStatement}
data_type : Data meta_variable list(meta_variable) data_type_constructor_plus {ModuleDataType (getRange ($1,$4)) $2 $3 $4}

-- __________________ EXPRESSION ____________________________

expression_literal :: {Expression}
expression_literal: Int { 
  let literal=(tokenLiteral2Literal $1) 
  in 
    LiteralExpression (getRange literal) literal
  }

expression_variable :: {Expression}
expression_variable : meta_variable {VariableExpression (getRange $1) $1}

expression_record_item :: {(Range,Variable,Maybe Expression)}
expression_record_item : meta_variable Colon expression {
  ((getRange ($1,$3)),$1,Just $3)          
  }
  | meta_variable {((getRange $1),$1,Nothing)}

expression_record_inner :: {NonEmpty (Range,Variable,Maybe Expression)}
expression_record_inner : listSepBy1(expression_record_item,Comma) {$1}

expression_record :: {Expression}
expression_record : braces(expression_record_inner) {
    let range = getRange \$ (\ (x,_,_) -> x ) <\$> $1 
    in
    RecordExpression range (NonEmptyRecord range $1)
  }
  | LBrace RBrace {RecordExpression (getRange ($1,$2)) (EmptyRecord (getRange ($1,$2))) }

expression_record_update_item::{(Range,Variable,Expression)}
expression_record_update_item : meta_variable Equal expression {
    (getRange ($1,$3),$1,$3)
  }

expression_record_update_inner :: {NonEmpty (Range,Variable,Expression)}
expression_record_update_inner : listSepBy1(expression_record_update_item,Comma) {$1}

expression_record_update :: {Expression}
expression_record_update :  braces(expression_record_update_inner) {RecordUpdate (getRange $1) (NonEmptyRecord (getRange $1) $1)}

expression_operator_parens :: {Expression}
expression_operator_parens: parens(meta_operator)
  {OperatorInParens (getRange $1) $1}

expression_annotation :: {Expression}
expression_annotation: expression {$1}
  | expression Colon type_scheme {AnnotationExpression (getRange ($1,$3)) $1 $3}

expression_type_arg :: {Expression}
expression_type_arg : At type_atom {TypeArgumentExpression (getRange ($1,$2)) $2}

expression_accessor_field :: {Expression}
expression_accessor_field: expression Dot meta_variable {Accessor (getRange ($1,$3)) $1 $3}

expression_accessor_funtion :: {Expression}
expression_accessor_funtion : Hole Dot meta_variable {AccessorFunction (getRange ($1,$3)) $3}

expression_accessor :: {Expression}
expression_accessor : expression_accessor_field {$1}
  | expression_accessor_funtion {$1}

expression_atom :: {Expression}
expression_atom: expression_variable {$1}
  | expression_literal {$1}
  | expression_record {$1}
  | expression_record_update {$1}
  | expression_operator_parens {$1}
  | expression_type_arg {$1}
  -- expression_annotation can return a simple expression
  | parens(expression_annotation) {$1}

expression_application :: {Expression}
expression_application: expression_atom list1(expression_atom){
  ApplicationExpression (getRange ($1,$2)) $1 $2
}
  | expression_atom {$1}

expression_operators_plus :: {IntercalatedList Expression Operator}
expression_operators_plus :  expression_application {FirstItem $1}
  | expression_operators_plus meta_operator expression_application {IntercalatedCons $3 (IntercalatedCons $2 $1)}

expression_operators :: {Expression}
expression_operators : expression_operators_plus {
  MeaninglessOperatorsExpression (trace (show $1) (getRange $1)) $1
  }

expression_case_single :: {CaseCase}
expression_case_single : pattern_match RightArrow expression {
  CaseCase (getRange ($1,$3)) $1 $3
  }
  | pattern_match RightArrow  LayoutStart expression LayoutEnd{
  CaseCase (getRange ($1,$4)) $1 $4
}

expression_case_cases :: {NonEmpty CaseCase}
expression_case_cases : listSepBy1(expression_case_single,LayoutSeparator) {$1}

expression_case :: {Expression}
expression_case: Case expression Of expression_case_cases {SST.Case (getRange ($1,$4)) $2 $4}
  | Case LayoutStart expression LayoutEnd Of expression_case_cases  {SST.Case (getRange ($1,$6)) $3 $6}
  | Case expression Of LayoutStart expression_case_cases  LayoutEnd {SST.Case (getRange ($1,$5)) $2 $5}
  | Case LayoutStart expression LayoutEnd Of LayoutStart expression_case_cases LayoutEnd {SST.Case (getRange ($1,$7)) $3 $7}
  | expression_operators {$1}

expression_lambda_arguments :: {NonEmpty Pattern}
expression_lambda_arguments: listSepBy1(pattern_match,Comma) {$1}

expression_lambda :: {Expression}
expression_lambda : Lambda expression_lambda_arguments RightArrow expression 
  {Lambda (getRange ($1,$4)) $2 $4}
  | expression_case {$1}

expression_let_binding :: {LetBinding}
expression_let_binding: listSepBy1(pattern_match,Comma) Equal expression {
  LetBinding (getRange ($1,$3)) $1 $3
  }

expression_let_inside :: {NonEmpty LetBinding}
expression_let_inside: listSepBy1(expression_let_binding,LayoutSeparator) {$1}

expression_let :: {Expression}
expression_let: Let LayoutStart expression_let_inside LayoutEnd In LayoutStart expression LayoutEnd 
  {
    SST.Let (getRange ($1,$7)) $3 $7
  }
  | Let LayoutStart expression_let_inside LayoutEnd In expression
  {
    SST.Let (getRange ($1,$6)) $3 $6
  }
  | Let expression_let_binding In LayoutStart expression LayoutEnd
  {
    SST.Let (getRange ($1,$5)) ($2 :|[]) $5
  }
  | Let expression_let_binding In expression
  {
    SST.Let (getRange ($1,$4)) ($2 :| []) $4
  }
  | expression_lambda {$1}


{-
-}

{
parseError :: ([Token],[String]) -> a
parseError (_,pos) = error ("Parse error, expected:  " <> show pos)
}
