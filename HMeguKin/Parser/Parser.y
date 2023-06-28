{
module HMeguKin.Parser.Parser(parse) where

import Data.List.NonEmpty(NonEmpty((:|)),cons,reverse)
import Data.List qualified as List
import Prelude hiding(reverse)

import HMeguKin.Parser.Types(Token(..),Range) 
import HMeguKin.Parser.Types qualified as Types
import HMeguKin.Parser.SST hiding (LiteralUint)
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
  LayoutEnd {LayoutEnd $$}
  RightArrow {RightArrow $$}
  TokenOperator {TokenOperator _ _}
  Forall {Forall $$}
  Dot {Dot $$}
  Data {Data $$}
  Equal {Equal $$}
  At {At $$}

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

type_scheme :: {Type}
type_scheme :  type_expression_inner {$1}
  | Forall type_data_type_args Dot type_expression_inner {
  TypeForall (getRange ($2,$4)) $2 $4
  }

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

pattern_match_variable : meta_variable {
    VariablePattern (getRange $1) $1
  }

pattern_match_hole : Hole {HolePattern $1}

pattern_match_literal: Int { 
  let literal=(tokenLiteral2Literal $1) 
  in 
    LiteralPattern (getRange literal) literal
  }
 
pattern_match_atom: pattern_match_literal {$1}
  | pattern_match_variable {$1}
  | pattern_match_hole {$1}
  | LParen pattern_match RParen {$2}

pattern_match_application: Variable list1(pattern_match_atom) {
  let variable=(tokenVariable2Variable $1) 
  in
    ApplicationPattern (getRange(variable,$2)) variable $2 
  }
  | pattern_match_atom {$1}

pattern_match : pattern_match_application {$1}

pattern_match_function_args: list1(pattern_match) {$1}

-- __________________ TYPE ____________________________

type_record_item :: {(Range,Variable,Type)}
type_record_item : meta_variable Colon type_expression_inner {
    (getRange ($1,$3),$1,$3)
  }

type_record_inner :: {[(Range,Variable,Type)]}
type_record_inner : type_record_item  {[$1]}
  | type_record_inner Comma type_record_item {$3:$1}

type_record :: {Type}
type_record : braces(type_record_inner) {
  RecordType (getRange $1) (List.reverse $1)
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

data_type :: {DataType}
data_type : Data meta_variable list(meta_variable) data_type_constructor_plus {DataType (getRange ($1,$4)) $2 $3 $4}

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

expression_record_inner_plus :: {[(Range,Variable,Maybe Expression)]}
expression_record_inner_plus : expression_record_item {[$1]}
  | expression_record_inner Comma expression_record_item {$3:$1}

expression_record_inner :: {[(Range,Variable,Maybe Expression)]}
expression_record_inner : expression_record_inner_plus {List.reverse $1}

expression_record :: {Expression}
expression_record : braces(expression_record_inner) {
  let (range::Range) =  getRange ((\ (r,_,_)->r) <\$> $1)
  in
    RecordExpression range $1
  }
  | LBrace RBrace {RecordExpression (getRange ($1,$2)) [] }

expression_record_update_item::{(Range,Variable,Expression)}
expression_record_update_item : meta_variable Equal expression {
    (getRange ($1,$3),$1,$3)
  }

expression_record_update_inner :: {NonEmpty (Range,Variable,Expression)}
expression_record_update_inner : listSepBy1(expression_record_update_item,Comma) {$1}

expression_record_update :: {Expression}
expression_record_update :  braces(expression_record_update_inner) {RecordUpdate (getRange $1) $1}

expression_operator_parens :: {Expression}
expression_operator_parens: parens(meta_operator)
  {OperatorInParens (getRange $1) $1}

expression_annotation :: {Expression}
expression_annotation: expression {$1}
  | expression Colon type_scheme {AnnotationExpression (getRange ($1,$3)) $1 $3}

expression_atom :: {Expression}
expression_atom: expression_variable {$1}
  | expression_literal {$1}
  | expression_record {$1}
  | expression_record_update {$1}
  | expression_operator_parens {$1}
  -- expression_annotation can return a simple expression
  | parens(expression_annotation) {$1}

expression_accessor :: {Expression}
expression_accessor: expression Dot meta_variable {Accessor (getRange ($1,$3)) $1 $3}

expression_accessor_funtion :: {Expression}
expression_accessor_funtion : Hole Dot meta_variable {AccessorFunction (getRange ($1,$3)) $3}

expression_type_arg :: {Expression}
expression_type_arg : At type_atom {TypeArgumentExpression (getRange ($1,$2)) $2}

expression : expression_literal {$1}

{-

TODO: Add to the patterns both type anotations "Pattern:Type"
  and "as" pattern "name@Pattern"


expression_application: expression_selector (expression_selector | expression_type_arg)*

expression_operators: (expression_application expression_operator)* expression_application

expression_case_single : pattern_match RIGHT_ARROW expression
  | pattern_match RIGHT_ARROW  LAYOUT_START expression LAYOUT_END -> expression_case_single_layout

expression_case_cases : sep_by1{expression_case_single,LAYOUT_SEPARATOR}

expression_case: CASE expression OF expression_case_cases 
  | CASE LAYOUT_START expression LAYOUT_END OF expression_case_cases  -> expression_case_2
  | CASE expression OF LAYOUT_START expression_case_cases  LAYOUT_END -> expression_case_3
  | CASE LAYOUT_START expression LAYOUT_END OF LAYOUT_START expression_case_cases LAYOUT_END -> expression_case_4
  | expression_operators -> expression_case_operators

expression_lambda_arguments: pattern_match+

expression_lambda : LAMBDA expression_lambda_arguments RIGHT_ARROW expression
  | LAMBDA LAYOUT_START expression_lambda_arguments LAYOUT_END RIGHT_ARROW expression -> expression_lambda_2
  | LAMBDA expression_lambda_arguments RIGHT_ARROW LAYOUT_START expression LAYOUT_END -> expression_lambda_3
  | LAMBDA LAYOUT_START expression_lambda_arguments LAYOUT_END RIGHT_ARROW LAYOUT_START expression LAYOUT_END -> expression_lambda_4
  | expression_case -> expression_lambda_case

// TODO: Put more pattern_matches!
expression_let_binding: pattern_match EQUAL expression

expression_let_inside: sep_by1{expression_let_binding,LAYOUT_SEPARATOR}

expression_let: LET LAYOUT_START expression_let_inside LAYOUT_END IN LAYOUT_START expression LAYOUT_END 
  | LET LAYOUT_START expression_let_inside LAYOUT_END IN expression  -> expression_let_2
  // the use of expression_let_binding improves parser errors
  | LET expression_let_binding IN LAYOUT_START expression LAYOUT_END-> expression_let_3
  | LET expression_let_binding IN expression -> expression_let_4
  | expression_lambda -> expression_let_lambda

expression: expression_let

-}

{
parseError :: ([Token],[String]) -> a
parseError (_,pos) = error ("Parse error, expected:  " <> show pos)
}
