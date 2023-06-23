{
module HMeguKin.Parser.Parser(parse) where

import Data.List.NonEmpty(NonEmpty((:|)),cons)

import HMeguKin.Parser.Types(Token(..),Range) 
import HMeguKin.Parser.Types qualified as Types
import HMeguKin.Parser.SST hiding (LiteralUint)
}

%name parse
%tokentype { Token }
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
  Operator {TokenOperator _ _}
  RightArrow {RightArrow $$}
  TokenOperator {TokenOperator _ _}
  Forall {Forall $$}
  Dot {Dot $$}
  Data {Data $$}

%%

meta_variable :: {Variable}
meta_variable : Variable {
  tokenVariable2Variable $1
  }

meta_variable_plus :: {NonEmpty Variable}
meta_variable_plus : meta_variable {$1 :| []}
  | meta_variable_plus meta_variable {cons $2 $1}

meta_variable_star :: {[Variable]}
meta_variable_star : meta_variable {[$1]}
  | meta_variable_star meta_variable {$2:$1}

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

pattern_match_atom_plus : pattern_match_atom_plus pattern_match_atom {cons $2 $1}
  | pattern_match_atom {$1 :| []}

pattern_match_application: Variable pattern_match_atom_plus {
  let variable=(tokenVariable2Variable $1) 
  in
    ApplicationPattern (getRange(variable,$2)) variable $2 
  }
  | pattern_match_atom {$1}

pattern_match : pattern_match_application {$1}

pattern_match_function_args_plus: pattern_match_function_args_plus pattern_match_atom {cons $2 $1}
  | pattern_match_atom {$1 :| []}

pattern_match_function_args: pattern_match_function_args_plus {$1}

type_record_item :: {(Range,Variable,Type)}
type_record_item : meta_variable Colon type_expression_inner {
    (getRange ($1,$3),$1,$3)
  }

type_record_inner :: {[(Range,Variable,Type)]}
type_record_inner : type_record_item  {[$1]}
  | type_record_inner Comma type_record_item {$3:$1}

type_record :: {Type}
type_record : RBrace type_record_inner LBrace {
  RecordType (getRange $2) $2
  }

type_operator :: {Operator}
type_operator : TokenOperator {
  case $1 of 
    TokenOperator _ op ->
      lexerOperator2Operator op
  }
  | BackTick Variable BackTick {
    let variable = tokenVariable2Variable $2
    in
      VariableAsOperator (getRange variable) variable
  }

type_variable :: {Type}
type_variable : meta_variable {
  VariableType (getRange $1) $1
              }

type_atom :: {Type}
type_atom : type_variable {$1}
  | LParen type_expression_inner RParen {$2}
  | type_record {$1}

type_application :: {Type}
type_application : type_atom {$1}
  | type_application type_atom  {
  ApplicationType (getRange ($2,$1)) $2 $1
  }

type_operators_plus :: {IntercalatedList Type Operator}
type_operators_plus :  type_application {FirstItem $1}
  | type_operators_plus type_operator type_application {IntercalatedCons $3 (IntercalatedCons $2 $1)}

type_operators :: {Type}
type_operators : type_operators_plus {
  MeaninglessOperatorApplications (getRange $1) $1
  }

type_expression_inner :: {Type}
type_expression_inner: type_operators {$1}
  | type_operators RightArrow type_expression_inner {TypeArrow (getRange ($1,$3)) $1 $3
  }

type_data_type_args :: {NonEmpty Variable}
type_data_type_args : meta_variable {$1 :| []}
  | type_data_type_args meta_variable {cons $2 $1}

type_scheme :: {Type}
type_scheme :  type_expression_inner {$1}
  | Forall type_data_type_args Dot type_expression_inner {
  TypeForall (getRange ($2,$4)) $2 $4
  }


type_expression_inner_sep_comma :: {[Type]}
type_expression_inner_sep_comma : type_expression_inner  {[$1]}
  | type_expression_inner_sep_comma Comma type_expression_inner {
    $3:$1
  }

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
data_type : Data meta_variable meta_variable_star data_type_constructor_plus {DataType (getRange ($1,$4)) $2 $3 $4}

{-

-}

{
parseError :: [Token] -> a
parseError _ = error "Parse error"
}
