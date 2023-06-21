{
module HMeguKin.Parser.Parser(parse) where

import Data.List.NonEmpty(NonEmpty((:|)),cons)

import HMeguKin.Parser.Types(Token(..)) 
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
  Colon {Colon $$}
  


%%

pattern_match_variable : Variable {
  let variable=(tokenVariable2Variable $1) 
  in 
    VariablePattern (getRange variable) variable
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


type_record_item : Variable COLON type_expression_inner {}
  -- this enforces commas to be at the begining of the line, 
  -- it's a happy accident :)
  | VARIABLE_IDENTIFIER COLON LAYOUT_START type_expression_inner LAYOUT_END -> type_record_item_layout

{-


type_record_inner : sep_by1{type_record_item,COMMA}

type_record : braces{type_record_inner}

// Shall we allow `a `Either` b` to be `Either a b`?
type_operator : PREFIXED_OPERATOR | OPERATOR 

type_variable : VARIABLE_IDENTIFIER

type_concrete_type :CAPITALIZED_IDENTIFIER | PREFIXED_CAPITALIZED

type_atom : type_variable | type_concrete_type | parens{type_expression_inner} | type_record

type_application : type_atom+

type_operators : (type_application type_operator)* type_application


// made RIGHT_ARROW not to gen a layout here
type_expression_inner: sep_by1{type_operators,RIGHT_ARROW}

// This forces prenex form at syntax level
type_scheme :  type_expression_inner
  | FORALL type_data_type_args DOT type_expression_inner -> type_scheme_forall_no_layout
  | FORALL LAYOUT_START type_data_type_args_layout LAYOUT_END DOT type_expression_inner -> type_scheme_forall_layout


type_data_type_args : type_variable+

type_data_type_args_layout : (type_variable [LAYOUT_SEPARATOR])* type_variable


-}


{
parseError :: [Token] -> a
parseError _ = error "Parse error"
}
