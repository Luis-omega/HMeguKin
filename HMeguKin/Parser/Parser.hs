{-# OPTIONS_GHC -w #-}
module HMeguKin.Parser.Parser(parse) where

import Data.List.NonEmpty(NonEmpty((:|)),cons,reverse,toList,uncons,singleton)
import Data.List qualified as List
import Prelude hiding(reverse)

import HMeguKin.Parser.Types(Token(..),Range) 
import HMeguKin.Parser.Types qualified as Types
import HMeguKin.Parser.Monad(ParserMonad,monadicLexer)
import HMeguKin.Parser.SST hiding (LiteralUint,Case,Let)
import HMeguKin.Parser.SST qualified as SST
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.20.1.1

data HappyAbsSyn t69 t70 t71 t72 t73 t74 t75 t76 t77 t78 t79 t80 t81 t82 t83 t84 t85 t86 t87 t88 t89 t90 t91 t92 t93 t94 t95 t96 t97 t98 t99 t100 t101 t102 t103
	= HappyTerminal (Token)
	| HappyErrorToken Prelude.Int
	| HappyAbsSyn4 (ModuleStatement)
	| HappyAbsSyn5 (Variable)
	| HappyAbsSyn6 (Operator)
	| HappyAbsSyn7 (Pattern)
	| HappyAbsSyn15 ((Range,Variable,Type))
	| HappyAbsSyn16 (NonEmpty(Range,Variable,Type))
	| HappyAbsSyn17 (Type)
	| HappyAbsSyn21 (IntercalatedList Type Operator)
	| HappyAbsSyn25 (NonEmpty Variable)
	| HappyAbsSyn26 ([Type])
	| HappyAbsSyn27 (Constructor)
	| HappyAbsSyn28 (NonEmpty Constructor)
	| HappyAbsSyn30 (Expression)
	| HappyAbsSyn32 ((Range,Variable,Maybe Expression))
	| HappyAbsSyn33 (NonEmpty (Range,Variable,Maybe Expression))
	| HappyAbsSyn35 ((Range,Variable,Expression))
	| HappyAbsSyn36 (NonEmpty (Range,Variable,Expression))
	| HappyAbsSyn46 (IntercalatedList Expression Operator)
	| HappyAbsSyn48 (CaseCase)
	| HappyAbsSyn49 (NonEmpty CaseCase)
	| HappyAbsSyn51 (NonEmpty Pattern)
	| HappyAbsSyn53 (LetBinding)
	| HappyAbsSyn54 (NonEmpty LetBinding)
	| HappyAbsSyn59 (ImportItem)
	| HappyAbsSyn62 (NonEmpty ImportItem)
	| HappyAbsSyn63 (Import)
	| HappyAbsSyn66 (OperatorFixity)
	| HappyAbsSyn67 (OperatorKind)
	| HappyAbsSyn69 t69
	| HappyAbsSyn70 t70
	| HappyAbsSyn71 t71
	| HappyAbsSyn72 t72
	| HappyAbsSyn73 t73
	| HappyAbsSyn74 t74
	| HappyAbsSyn75 t75
	| HappyAbsSyn76 t76
	| HappyAbsSyn77 t77
	| HappyAbsSyn78 t78
	| HappyAbsSyn79 t79
	| HappyAbsSyn80 t80
	| HappyAbsSyn81 t81
	| HappyAbsSyn82 t82
	| HappyAbsSyn83 t83
	| HappyAbsSyn84 t84
	| HappyAbsSyn85 t85
	| HappyAbsSyn86 t86
	| HappyAbsSyn87 t87
	| HappyAbsSyn88 t88
	| HappyAbsSyn89 t89
	| HappyAbsSyn90 t90
	| HappyAbsSyn91 t91
	| HappyAbsSyn92 t92
	| HappyAbsSyn93 t93
	| HappyAbsSyn94 t94
	| HappyAbsSyn95 t95
	| HappyAbsSyn96 t96
	| HappyAbsSyn97 t97
	| HappyAbsSyn98 t98
	| HappyAbsSyn99 t99
	| HappyAbsSyn100 t100
	| HappyAbsSyn101 t101
	| HappyAbsSyn102 t102
	| HappyAbsSyn103 t103

happyExpList :: Happy_Data_Array.Array Prelude.Int Prelude.Int
happyExpList = Happy_Data_Array.listArray (0,1147) ([0,0,0,0,0,0,1920,256,513,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3840,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7680,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,8192,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3072,0,0,0,0,0,0,0,16384,0,0,0,0,0,0,0,9216,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1920,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,3840,0,0,0,0,0,0,0,0,8,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32809,0,0,0,0,0,0,0,30720,49153,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,36864,2050,0,0,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,4104,8194,0,0,0,0,0,0,16384,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,512,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,1,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,41,0,0,0,0,0,0,0,0,528,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,5,0,0,0,0,0,0,0,256,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,30720,16385,0,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,61440,33826,13,0,0,0,0,0,0,8320,0,0,0,0,0,0,0,0,164,0,0,0,0,0,0,0,57344,133,27,0,0,0,0,0,0,3840,0,0,0,0,0,0,0,0,8312,0,0,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,20992,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,120,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,1504,6912,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8196,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,30720,16385,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,4096,0,0,0,0,0,0,0,16384,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,656,0,0,0,0,0,0,0,32768,20,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,33794,2048,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,41984,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,82,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5248,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,20992,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3008,13824,0,0,0,0,0,0,0,94,432,0,0,0,0,0,0,0,256,0,0,0,0,0,0,0,1920,2,0,0,0,0,0,0,0,60,0,0,0,0,0,0,0,57344,5,27,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,17136,3456,0,0,0,0,0,0,32768,23,108,0,0,0,0,0,0,41984,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,94,432,0,0,0,0,0,0,61440,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,49152,3,0,0,0,0,0,0,0,0,16384,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7680,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,47,216,0,0,0,0,0,0,30720,49185,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,188,864,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3840,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7680,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","module_statement","meta_variable","meta_operator","pattern_match_variable","pattern_match_hole","pattern_match_literal","pattern_annotation","pattern_match_atom","pattern_as","pattern_match_application","pattern_match","type_record_item","type_record_inner","type_record","type_variable","type_atom","type_application","type_operators_plus","type_operators","type_expression_inner","type_scheme","type_data_type_args","type_expression_inner_sep_comma","data_type_constructor","data_type_constructor_plus","data_type","expression_literal","expression_variable","expression_record_item","expression_record_inner","expression_record","expression_record_update_item","expression_record_update_inner","expression_record_update","expression_operator_parens","expression_annotation","expression_type_arg","expression_atom","expression_accessor_field","expression_accessor_funtion","expression_accessor","expression_application","expression_operators_plus","expression_operators","expression_case_single","expression_case_cases","expression_case","expression_lambda_arguments","expression_lambda","expression_let_binding","expression_let_inside","expression_let","expression","import_constructor","import_constructors","import_type","import_operator","module_import_item","module_import_items","module_import","variable_declaration","pattern_declaration","fixity","precedence","operator_fixity","braces__expression_record_inner__","braces__expression_record_update_inner__","braces__type_record_inner__","list1__expression_accessor__","list1__meta_variable__","list1__pattern_as__","listSepBy1__data_type_constructor__Pipe__","listSepBy1__expression_case_single__LayoutSeparator__","listSepBy1__expression_let_binding__LayoutSeparator__","listSepBy1__expression_record_item__Comma__","listSepBy1__expression_record_update_item__Comma__","listSepBy1__import_constructor__Comma__","listSepBy1__meta_variable__Dot__","listSepBy1__module_import_item__Comma__","listSepBy1__pattern_match__Comma__","listSepBy1__type_record_item__Comma__","parens__expression_annotation__","parens__import_constructors__","parens__meta_operator__","parens__module_import_items__","parens__pattern_match__","parens__type_expression_inner__","plus__expression_accessor__","plus__meta_variable__","plus__pattern_as__","sepBy1__data_type_constructor__Pipe__","sepBy1__expression_case_single__LayoutSeparator__","sepBy1__expression_let_binding__LayoutSeparator__","sepBy1__expression_record_item__Comma__","sepBy1__expression_record_update_item__Comma__","sepBy1__import_constructor__Comma__","sepBy1__meta_variable__Dot__","sepBy1__module_import_item__Comma__","sepBy1__pattern_match__Comma__","sepBy1__type_record_item__Comma__","Variable","Hole","UInt","LParen","RParen","LBrace","RBrace","Colon","Comma","BackTick","LayoutStart","LayoutSeparator","LayoutEnd","RightArrow","TokenOperator","Forall","Dot","Data","Equal","At","Case","Of","Lambda","Let","In","OperatorKeyword","Type","Term","Left_","Right_","None","Pipe","As","Unqualified","Import","%eof"]
        bit_start = st Prelude.* 139
        bit_end = (st Prelude.+ 1) Prelude.* 139
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..138]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

action_0 (104) = happyShift action_19
action_0 (105) = happyShift action_20
action_0 (106) = happyShift action_21
action_0 (107) = happyShift action_22
action_0 (121) = happyShift action_3
action_0 (129) = happyShift action_23
action_0 (138) = happyShift action_24
action_0 (4) = happyGoto action_4
action_0 (5) = happyGoto action_5
action_0 (7) = happyGoto action_6
action_0 (8) = happyGoto action_7
action_0 (9) = happyGoto action_8
action_0 (10) = happyGoto action_9
action_0 (11) = happyGoto action_10
action_0 (12) = happyGoto action_11
action_0 (13) = happyGoto action_12
action_0 (14) = happyGoto action_13
action_0 (29) = happyGoto action_2
action_0 (63) = happyGoto action_14
action_0 (64) = happyGoto action_15
action_0 (65) = happyGoto action_16
action_0 (68) = happyGoto action_17
action_0 (89) = happyGoto action_18
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (121) = happyShift action_3
action_1 (29) = happyGoto action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyReduce_1

action_3 (104) = happyShift action_26
action_3 (5) = happyGoto action_36
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (139) = happyAccept
action_4 _ = happyFail (happyExpListPerState 4)

action_5 (111) = happyShift action_34
action_5 (123) = happyShift action_35
action_5 _ = happyReduce_9

action_6 _ = happyReduce_14

action_7 _ = happyReduce_15

action_8 _ = happyReduce_13

action_9 _ = happyReduce_17

action_10 _ = happyReduce_19

action_11 _ = happyReduce_21

action_12 _ = happyReduce_22

action_13 (122) = happyShift action_33
action_13 _ = happyFail (happyExpListPerState 13)

action_14 _ = happyReduce_5

action_15 _ = happyReduce_2

action_16 _ = happyReduce_3

action_17 _ = happyReduce_4

action_18 _ = happyReduce_16

action_19 (104) = happyShift action_26
action_19 (105) = happyShift action_20
action_19 (106) = happyShift action_21
action_19 (107) = happyShift action_22
action_19 (5) = happyGoto action_28
action_19 (7) = happyGoto action_6
action_19 (8) = happyGoto action_7
action_19 (9) = happyGoto action_8
action_19 (10) = happyGoto action_9
action_19 (11) = happyGoto action_10
action_19 (12) = happyGoto action_30
action_19 (74) = happyGoto action_31
action_19 (89) = happyGoto action_18
action_19 (93) = happyGoto action_32
action_19 _ = happyReduce_6

action_20 _ = happyReduce_10

action_21 _ = happyReduce_11

action_22 (104) = happyShift action_19
action_22 (105) = happyShift action_20
action_22 (106) = happyShift action_21
action_22 (107) = happyShift action_22
action_22 (5) = happyGoto action_28
action_22 (7) = happyGoto action_6
action_22 (8) = happyGoto action_7
action_22 (9) = happyGoto action_8
action_22 (10) = happyGoto action_9
action_22 (11) = happyGoto action_10
action_22 (12) = happyGoto action_11
action_22 (13) = happyGoto action_12
action_22 (14) = happyGoto action_29
action_22 (89) = happyGoto action_18
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (118) = happyShift action_27
action_23 _ = happyFail (happyExpListPerState 23)

action_24 (104) = happyShift action_26
action_24 (5) = happyGoto action_25
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (107) = happyShift action_52
action_25 (136) = happyShift action_53
action_25 (88) = happyGoto action_51
action_25 _ = happyReduce_107

action_26 _ = happyReduce_6

action_27 (130) = happyShift action_49
action_27 (131) = happyShift action_50
action_27 (66) = happyGoto action_48
action_27 _ = happyFail (happyExpListPerState 27)

action_28 (123) = happyShift action_35
action_28 _ = happyReduce_9

action_29 (108) = happyShift action_46
action_29 (111) = happyShift action_47
action_29 _ = happyFail (happyExpListPerState 29)

action_30 _ = happyReduce_142

action_31 _ = happyReduce_20

action_32 (104) = happyShift action_26
action_32 (105) = happyShift action_20
action_32 (106) = happyShift action_21
action_32 (107) = happyShift action_22
action_32 (5) = happyGoto action_28
action_32 (7) = happyGoto action_6
action_32 (8) = happyGoto action_7
action_32 (9) = happyGoto action_8
action_32 (10) = happyGoto action_9
action_32 (11) = happyGoto action_10
action_32 (12) = happyGoto action_45
action_32 (89) = happyGoto action_18
action_32 _ = happyReduce_121

action_33 (114) = happyShift action_44
action_33 _ = happyFail (happyExpListPerState 33)

action_34 (114) = happyShift action_43
action_34 _ = happyFail (happyExpListPerState 34)

action_35 (104) = happyShift action_26
action_35 (105) = happyShift action_20
action_35 (106) = happyShift action_21
action_35 (107) = happyShift action_22
action_35 (5) = happyGoto action_41
action_35 (7) = happyGoto action_6
action_35 (8) = happyGoto action_7
action_35 (9) = happyGoto action_8
action_35 (10) = happyGoto action_9
action_35 (11) = happyGoto action_42
action_35 (89) = happyGoto action_18
action_35 _ = happyFail (happyExpListPerState 35)

action_36 (104) = happyShift action_26
action_36 (122) = happyShift action_40
action_36 (5) = happyGoto action_37
action_36 (73) = happyGoto action_38
action_36 (92) = happyGoto action_39
action_36 _ = happyFail (happyExpListPerState 36)

action_37 _ = happyReduce_140

action_38 (122) = happyShift action_124
action_38 _ = happyFail (happyExpListPerState 38)

action_39 (104) = happyShift action_26
action_39 (5) = happyGoto action_123
action_39 _ = happyReduce_120

action_40 (104) = happyShift action_26
action_40 (5) = happyGoto action_118
action_40 (27) = happyGoto action_119
action_40 (28) = happyGoto action_120
action_40 (75) = happyGoto action_121
action_40 (94) = happyGoto action_122
action_40 _ = happyFail (happyExpListPerState 40)

action_41 _ = happyReduce_9

action_42 _ = happyReduce_18

action_43 (104) = happyShift action_26
action_43 (107) = happyShift action_82
action_43 (109) = happyShift action_83
action_43 (119) = happyShift action_84
action_43 (5) = happyGoto action_71
action_43 (17) = happyGoto action_72
action_43 (18) = happyGoto action_73
action_43 (19) = happyGoto action_74
action_43 (20) = happyGoto action_75
action_43 (21) = happyGoto action_76
action_43 (22) = happyGoto action_77
action_43 (23) = happyGoto action_78
action_43 (24) = happyGoto action_117
action_43 (71) = happyGoto action_80
action_43 (90) = happyGoto action_81
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (104) = happyShift action_26
action_44 (105) = happyShift action_109
action_44 (106) = happyShift action_110
action_44 (107) = happyShift action_111
action_44 (109) = happyShift action_112
action_44 (123) = happyShift action_113
action_44 (124) = happyShift action_114
action_44 (126) = happyShift action_115
action_44 (127) = happyShift action_116
action_44 (5) = happyGoto action_85
action_44 (30) = happyGoto action_86
action_44 (31) = happyGoto action_87
action_44 (34) = happyGoto action_88
action_44 (37) = happyGoto action_89
action_44 (38) = happyGoto action_90
action_44 (40) = happyGoto action_91
action_44 (41) = happyGoto action_92
action_44 (42) = happyGoto action_93
action_44 (43) = happyGoto action_94
action_44 (44) = happyGoto action_95
action_44 (45) = happyGoto action_96
action_44 (46) = happyGoto action_97
action_44 (47) = happyGoto action_98
action_44 (50) = happyGoto action_99
action_44 (52) = happyGoto action_100
action_44 (55) = happyGoto action_101
action_44 (56) = happyGoto action_102
action_44 (69) = happyGoto action_103
action_44 (70) = happyGoto action_104
action_44 (72) = happyGoto action_105
action_44 (85) = happyGoto action_106
action_44 (87) = happyGoto action_107
action_44 (91) = happyGoto action_108
action_44 _ = happyFail (happyExpListPerState 44)

action_45 _ = happyReduce_143

action_46 _ = happyReduce_136

action_47 (104) = happyShift action_26
action_47 (107) = happyShift action_82
action_47 (109) = happyShift action_83
action_47 (119) = happyShift action_84
action_47 (5) = happyGoto action_71
action_47 (17) = happyGoto action_72
action_47 (18) = happyGoto action_73
action_47 (19) = happyGoto action_74
action_47 (20) = happyGoto action_75
action_47 (21) = happyGoto action_76
action_47 (22) = happyGoto action_77
action_47 (23) = happyGoto action_78
action_47 (24) = happyGoto action_79
action_47 (71) = happyGoto action_80
action_47 (90) = happyGoto action_81
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (132) = happyShift action_68
action_48 (133) = happyShift action_69
action_48 (134) = happyShift action_70
action_48 (67) = happyGoto action_67
action_48 _ = happyFail (happyExpListPerState 48)

action_49 _ = happyReduce_110

action_50 _ = happyReduce_111

action_51 (136) = happyShift action_66
action_51 _ = happyFail (happyExpListPerState 51)

action_52 (104) = happyShift action_26
action_52 (113) = happyShift action_63
action_52 (118) = happyShift action_64
action_52 (130) = happyShift action_65
action_52 (5) = happyGoto action_55
action_52 (6) = happyGoto action_56
action_52 (59) = happyGoto action_57
action_52 (60) = happyGoto action_58
action_52 (61) = happyGoto action_59
action_52 (62) = happyGoto action_60
action_52 (82) = happyGoto action_61
action_52 (101) = happyGoto action_62
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (104) = happyShift action_26
action_53 (5) = happyGoto action_54
action_53 _ = happyFail (happyExpListPerState 53)

action_54 _ = happyReduce_105

action_55 (107) = happyShift action_177
action_55 (86) = happyGoto action_176
action_55 _ = happyReduce_98

action_56 _ = happyReduce_100

action_57 _ = happyReduce_102

action_58 _ = happyReduce_103

action_59 _ = happyReduce_158

action_60 (108) = happyShift action_175
action_60 _ = happyFail (happyExpListPerState 60)

action_61 _ = happyReduce_104

action_62 (112) = happyShift action_174
action_62 _ = happyReduce_129

action_63 (104) = happyShift action_173
action_63 _ = happyFail (happyExpListPerState 63)

action_64 _ = happyReduce_7

action_65 (113) = happyShift action_63
action_65 (118) = happyShift action_64
action_65 (6) = happyGoto action_172
action_65 _ = happyFail (happyExpListPerState 65)

action_66 (104) = happyShift action_26
action_66 (5) = happyGoto action_171
action_66 _ = happyFail (happyExpListPerState 66)

action_67 (106) = happyShift action_170
action_67 _ = happyFail (happyExpListPerState 67)

action_68 _ = happyReduce_112

action_69 _ = happyReduce_113

action_70 _ = happyReduce_114

action_71 _ = happyReduce_26

action_72 _ = happyReduce_29

action_73 _ = happyReduce_27

action_74 _ = happyReduce_30

action_75 (104) = happyShift action_26
action_75 (107) = happyShift action_82
action_75 (109) = happyShift action_83
action_75 (5) = happyGoto action_71
action_75 (17) = happyGoto action_72
action_75 (18) = happyGoto action_73
action_75 (19) = happyGoto action_169
action_75 (71) = happyGoto action_80
action_75 (90) = happyGoto action_81
action_75 _ = happyReduce_32

action_76 (113) = happyShift action_63
action_76 (118) = happyShift action_64
action_76 (6) = happyGoto action_168
action_76 _ = happyReduce_34

action_77 (117) = happyShift action_167
action_77 _ = happyReduce_35

action_78 _ = happyReduce_37

action_79 (108) = happyShift action_166
action_79 _ = happyFail (happyExpListPerState 79)

action_80 _ = happyReduce_25

action_81 _ = happyReduce_28

action_82 (104) = happyShift action_26
action_82 (107) = happyShift action_82
action_82 (109) = happyShift action_83
action_82 (5) = happyGoto action_71
action_82 (17) = happyGoto action_72
action_82 (18) = happyGoto action_73
action_82 (19) = happyGoto action_74
action_82 (20) = happyGoto action_75
action_82 (21) = happyGoto action_76
action_82 (22) = happyGoto action_77
action_82 (23) = happyGoto action_165
action_82 (71) = happyGoto action_80
action_82 (90) = happyGoto action_81
action_82 _ = happyFail (happyExpListPerState 82)

action_83 (104) = happyShift action_26
action_83 (5) = happyGoto action_160
action_83 (15) = happyGoto action_161
action_83 (16) = happyGoto action_162
action_83 (84) = happyGoto action_163
action_83 (103) = happyGoto action_164
action_83 _ = happyFail (happyExpListPerState 83)

action_84 (104) = happyShift action_26
action_84 (5) = happyGoto action_158
action_84 (25) = happyGoto action_159
action_84 _ = happyFail (happyExpListPerState 84)

action_85 _ = happyReduce_49

action_86 _ = happyReduce_63

action_87 _ = happyReduce_62

action_88 _ = happyReduce_64

action_89 _ = happyReduce_65

action_90 _ = happyReduce_66

action_91 _ = happyReduce_67

action_92 (120) = happyShift action_157
action_92 _ = happyReduce_73

action_93 _ = happyReduce_71

action_94 _ = happyReduce_72

action_95 _ = happyReduce_138

action_96 _ = happyReduce_75

action_97 (113) = happyShift action_63
action_97 (118) = happyShift action_64
action_97 (6) = happyGoto action_156
action_97 _ = happyReduce_77

action_98 _ = happyReduce_84

action_99 _ = happyReduce_87

action_100 _ = happyReduce_94

action_101 _ = happyReduce_95

action_102 (116) = happyShift action_155
action_102 _ = happyFail (happyExpListPerState 102)

action_103 _ = happyReduce_53

action_104 _ = happyReduce_57

action_105 _ = happyReduce_74

action_106 _ = happyReduce_68

action_107 _ = happyReduce_58

action_108 (104) = happyShift action_26
action_108 (105) = happyShift action_109
action_108 (106) = happyShift action_110
action_108 (107) = happyShift action_111
action_108 (109) = happyShift action_112
action_108 (123) = happyShift action_113
action_108 (5) = happyGoto action_85
action_108 (30) = happyGoto action_86
action_108 (31) = happyGoto action_87
action_108 (34) = happyGoto action_88
action_108 (37) = happyGoto action_89
action_108 (38) = happyGoto action_90
action_108 (40) = happyGoto action_91
action_108 (41) = happyGoto action_92
action_108 (42) = happyGoto action_93
action_108 (43) = happyGoto action_94
action_108 (44) = happyGoto action_154
action_108 (69) = happyGoto action_103
action_108 (70) = happyGoto action_104
action_108 (85) = happyGoto action_106
action_108 (87) = happyGoto action_107
action_108 _ = happyReduce_119

action_109 (120) = happyShift action_153
action_109 _ = happyFail (happyExpListPerState 109)

action_110 _ = happyReduce_48

action_111 (104) = happyShift action_26
action_111 (105) = happyShift action_109
action_111 (106) = happyShift action_110
action_111 (107) = happyShift action_111
action_111 (109) = happyShift action_112
action_111 (113) = happyShift action_63
action_111 (118) = happyShift action_64
action_111 (123) = happyShift action_113
action_111 (124) = happyShift action_114
action_111 (126) = happyShift action_115
action_111 (127) = happyShift action_116
action_111 (5) = happyGoto action_85
action_111 (6) = happyGoto action_150
action_111 (30) = happyGoto action_86
action_111 (31) = happyGoto action_87
action_111 (34) = happyGoto action_88
action_111 (37) = happyGoto action_89
action_111 (38) = happyGoto action_90
action_111 (39) = happyGoto action_151
action_111 (40) = happyGoto action_91
action_111 (41) = happyGoto action_92
action_111 (42) = happyGoto action_93
action_111 (43) = happyGoto action_94
action_111 (44) = happyGoto action_95
action_111 (45) = happyGoto action_96
action_111 (46) = happyGoto action_97
action_111 (47) = happyGoto action_98
action_111 (50) = happyGoto action_99
action_111 (52) = happyGoto action_100
action_111 (55) = happyGoto action_101
action_111 (56) = happyGoto action_152
action_111 (69) = happyGoto action_103
action_111 (70) = happyGoto action_104
action_111 (72) = happyGoto action_105
action_111 (85) = happyGoto action_106
action_111 (87) = happyGoto action_107
action_111 (91) = happyGoto action_108
action_111 _ = happyFail (happyExpListPerState 111)

action_112 (104) = happyShift action_26
action_112 (110) = happyShift action_149
action_112 (5) = happyGoto action_140
action_112 (32) = happyGoto action_141
action_112 (33) = happyGoto action_142
action_112 (35) = happyGoto action_143
action_112 (36) = happyGoto action_144
action_112 (78) = happyGoto action_145
action_112 (79) = happyGoto action_146
action_112 (97) = happyGoto action_147
action_112 (98) = happyGoto action_148
action_112 _ = happyFail (happyExpListPerState 112)

action_113 (104) = happyShift action_26
action_113 (107) = happyShift action_82
action_113 (109) = happyShift action_83
action_113 (5) = happyGoto action_71
action_113 (17) = happyGoto action_72
action_113 (18) = happyGoto action_73
action_113 (19) = happyGoto action_139
action_113 (71) = happyGoto action_80
action_113 (90) = happyGoto action_81
action_113 _ = happyFail (happyExpListPerState 113)

action_114 (104) = happyShift action_26
action_114 (105) = happyShift action_109
action_114 (106) = happyShift action_110
action_114 (107) = happyShift action_111
action_114 (109) = happyShift action_112
action_114 (114) = happyShift action_138
action_114 (123) = happyShift action_113
action_114 (124) = happyShift action_114
action_114 (126) = happyShift action_115
action_114 (127) = happyShift action_116
action_114 (5) = happyGoto action_85
action_114 (30) = happyGoto action_86
action_114 (31) = happyGoto action_87
action_114 (34) = happyGoto action_88
action_114 (37) = happyGoto action_89
action_114 (38) = happyGoto action_90
action_114 (40) = happyGoto action_91
action_114 (41) = happyGoto action_92
action_114 (42) = happyGoto action_93
action_114 (43) = happyGoto action_94
action_114 (44) = happyGoto action_95
action_114 (45) = happyGoto action_96
action_114 (46) = happyGoto action_97
action_114 (47) = happyGoto action_98
action_114 (50) = happyGoto action_99
action_114 (52) = happyGoto action_100
action_114 (55) = happyGoto action_101
action_114 (56) = happyGoto action_137
action_114 (69) = happyGoto action_103
action_114 (70) = happyGoto action_104
action_114 (72) = happyGoto action_105
action_114 (85) = happyGoto action_106
action_114 (87) = happyGoto action_107
action_114 (91) = happyGoto action_108
action_114 _ = happyFail (happyExpListPerState 114)

action_115 (104) = happyShift action_19
action_115 (105) = happyShift action_20
action_115 (106) = happyShift action_21
action_115 (107) = happyShift action_22
action_115 (5) = happyGoto action_28
action_115 (7) = happyGoto action_6
action_115 (8) = happyGoto action_7
action_115 (9) = happyGoto action_8
action_115 (10) = happyGoto action_9
action_115 (11) = happyGoto action_10
action_115 (12) = happyGoto action_11
action_115 (13) = happyGoto action_12
action_115 (14) = happyGoto action_133
action_115 (51) = happyGoto action_134
action_115 (83) = happyGoto action_135
action_115 (89) = happyGoto action_18
action_115 (102) = happyGoto action_136
action_115 _ = happyFail (happyExpListPerState 115)

action_116 (104) = happyShift action_19
action_116 (105) = happyShift action_20
action_116 (106) = happyShift action_21
action_116 (107) = happyShift action_22
action_116 (114) = happyShift action_132
action_116 (5) = happyGoto action_28
action_116 (7) = happyGoto action_6
action_116 (8) = happyGoto action_7
action_116 (9) = happyGoto action_8
action_116 (10) = happyGoto action_9
action_116 (11) = happyGoto action_10
action_116 (12) = happyGoto action_11
action_116 (13) = happyGoto action_12
action_116 (14) = happyGoto action_130
action_116 (53) = happyGoto action_131
action_116 (89) = happyGoto action_18
action_116 _ = happyFail (happyExpListPerState 116)

action_117 (116) = happyShift action_129
action_117 _ = happyFail (happyExpListPerState 117)

action_118 (104) = happyShift action_26
action_118 (107) = happyShift action_82
action_118 (109) = happyShift action_83
action_118 (5) = happyGoto action_71
action_118 (17) = happyGoto action_72
action_118 (18) = happyGoto action_73
action_118 (19) = happyGoto action_74
action_118 (20) = happyGoto action_75
action_118 (21) = happyGoto action_76
action_118 (22) = happyGoto action_77
action_118 (23) = happyGoto action_127
action_118 (26) = happyGoto action_128
action_118 (71) = happyGoto action_80
action_118 (90) = happyGoto action_81
action_118 _ = happyReduce_43

action_119 _ = happyReduce_144

action_120 _ = happyReduce_47

action_121 _ = happyReduce_45

action_122 (135) = happyShift action_126
action_122 _ = happyReduce_122

action_123 _ = happyReduce_141

action_124 (104) = happyShift action_26
action_124 (5) = happyGoto action_118
action_124 (27) = happyGoto action_119
action_124 (28) = happyGoto action_125
action_124 (75) = happyGoto action_121
action_124 (94) = happyGoto action_122
action_124 _ = happyFail (happyExpListPerState 124)

action_125 _ = happyReduce_46

action_126 (104) = happyShift action_26
action_126 (5) = happyGoto action_118
action_126 (27) = happyGoto action_218
action_126 _ = happyFail (happyExpListPerState 126)

action_127 _ = happyReduce_41

action_128 (112) = happyShift action_217
action_128 _ = happyReduce_44

action_129 _ = happyReduce_108

action_130 (122) = happyShift action_216
action_130 _ = happyFail (happyExpListPerState 130)

action_131 (128) = happyShift action_215
action_131 _ = happyFail (happyExpListPerState 131)

action_132 (104) = happyShift action_19
action_132 (105) = happyShift action_20
action_132 (106) = happyShift action_21
action_132 (107) = happyShift action_22
action_132 (5) = happyGoto action_28
action_132 (7) = happyGoto action_6
action_132 (8) = happyGoto action_7
action_132 (9) = happyGoto action_8
action_132 (10) = happyGoto action_9
action_132 (11) = happyGoto action_10
action_132 (12) = happyGoto action_11
action_132 (13) = happyGoto action_12
action_132 (14) = happyGoto action_130
action_132 (53) = happyGoto action_211
action_132 (54) = happyGoto action_212
action_132 (77) = happyGoto action_213
action_132 (89) = happyGoto action_18
action_132 (96) = happyGoto action_214
action_132 _ = happyFail (happyExpListPerState 132)

action_133 _ = happyReduce_160

action_134 (117) = happyShift action_210
action_134 _ = happyFail (happyExpListPerState 134)

action_135 _ = happyReduce_85

action_136 (112) = happyShift action_209
action_136 _ = happyReduce_130

action_137 (125) = happyShift action_208
action_137 _ = happyFail (happyExpListPerState 137)

action_138 (104) = happyShift action_26
action_138 (105) = happyShift action_109
action_138 (106) = happyShift action_110
action_138 (107) = happyShift action_111
action_138 (109) = happyShift action_112
action_138 (123) = happyShift action_113
action_138 (124) = happyShift action_114
action_138 (126) = happyShift action_115
action_138 (127) = happyShift action_116
action_138 (5) = happyGoto action_85
action_138 (30) = happyGoto action_86
action_138 (31) = happyGoto action_87
action_138 (34) = happyGoto action_88
action_138 (37) = happyGoto action_89
action_138 (38) = happyGoto action_90
action_138 (40) = happyGoto action_91
action_138 (41) = happyGoto action_92
action_138 (42) = happyGoto action_93
action_138 (43) = happyGoto action_94
action_138 (44) = happyGoto action_95
action_138 (45) = happyGoto action_96
action_138 (46) = happyGoto action_97
action_138 (47) = happyGoto action_98
action_138 (50) = happyGoto action_99
action_138 (52) = happyGoto action_100
action_138 (55) = happyGoto action_101
action_138 (56) = happyGoto action_207
action_138 (69) = happyGoto action_103
action_138 (70) = happyGoto action_104
action_138 (72) = happyGoto action_105
action_138 (85) = happyGoto action_106
action_138 (87) = happyGoto action_107
action_138 (91) = happyGoto action_108
action_138 _ = happyFail (happyExpListPerState 138)

action_139 _ = happyReduce_61

action_140 (111) = happyShift action_205
action_140 (122) = happyShift action_206
action_140 _ = happyReduce_51

action_141 _ = happyReduce_150

action_142 (110) = happyShift action_204
action_142 _ = happyFail (happyExpListPerState 142)

action_143 _ = happyReduce_152

action_144 (110) = happyShift action_203
action_144 _ = happyFail (happyExpListPerState 144)

action_145 _ = happyReduce_52

action_146 _ = happyReduce_56

action_147 (112) = happyShift action_202
action_147 _ = happyReduce_125

action_148 (112) = happyShift action_201
action_148 _ = happyReduce_126

action_149 _ = happyReduce_54

action_150 (108) = happyShift action_200
action_150 _ = happyFail (happyExpListPerState 150)

action_151 (108) = happyShift action_199
action_151 _ = happyFail (happyExpListPerState 151)

action_152 (111) = happyShift action_198
action_152 _ = happyReduce_59

action_153 (104) = happyShift action_26
action_153 (5) = happyGoto action_197
action_153 _ = happyFail (happyExpListPerState 153)

action_154 _ = happyReduce_139

action_155 _ = happyReduce_109

action_156 (104) = happyShift action_26
action_156 (105) = happyShift action_109
action_156 (106) = happyShift action_110
action_156 (107) = happyShift action_111
action_156 (109) = happyShift action_112
action_156 (123) = happyShift action_113
action_156 (5) = happyGoto action_85
action_156 (30) = happyGoto action_86
action_156 (31) = happyGoto action_87
action_156 (34) = happyGoto action_88
action_156 (37) = happyGoto action_89
action_156 (38) = happyGoto action_90
action_156 (40) = happyGoto action_91
action_156 (41) = happyGoto action_92
action_156 (42) = happyGoto action_93
action_156 (43) = happyGoto action_94
action_156 (44) = happyGoto action_95
action_156 (45) = happyGoto action_196
action_156 (69) = happyGoto action_103
action_156 (70) = happyGoto action_104
action_156 (72) = happyGoto action_105
action_156 (85) = happyGoto action_106
action_156 (87) = happyGoto action_107
action_156 (91) = happyGoto action_108
action_156 _ = happyFail (happyExpListPerState 156)

action_157 (104) = happyShift action_26
action_157 (5) = happyGoto action_193
action_157 (81) = happyGoto action_194
action_157 (100) = happyGoto action_195
action_157 _ = happyFail (happyExpListPerState 157)

action_158 _ = happyReduce_39

action_159 (104) = happyShift action_26
action_159 (120) = happyShift action_192
action_159 (5) = happyGoto action_191
action_159 _ = happyFail (happyExpListPerState 159)

action_160 (111) = happyShift action_190
action_160 _ = happyFail (happyExpListPerState 160)

action_161 _ = happyReduce_162

action_162 (110) = happyShift action_189
action_162 _ = happyFail (happyExpListPerState 162)

action_163 _ = happyReduce_24

action_164 (112) = happyShift action_188
action_164 _ = happyReduce_131

action_165 (108) = happyShift action_187
action_165 _ = happyFail (happyExpListPerState 165)

action_166 _ = happyReduce_12

action_167 (104) = happyShift action_26
action_167 (107) = happyShift action_82
action_167 (109) = happyShift action_83
action_167 (5) = happyGoto action_71
action_167 (17) = happyGoto action_72
action_167 (18) = happyGoto action_73
action_167 (19) = happyGoto action_74
action_167 (20) = happyGoto action_75
action_167 (21) = happyGoto action_76
action_167 (22) = happyGoto action_77
action_167 (23) = happyGoto action_186
action_167 (71) = happyGoto action_80
action_167 (90) = happyGoto action_81
action_167 _ = happyFail (happyExpListPerState 167)

action_168 (104) = happyShift action_26
action_168 (107) = happyShift action_82
action_168 (109) = happyShift action_83
action_168 (5) = happyGoto action_71
action_168 (17) = happyGoto action_72
action_168 (18) = happyGoto action_73
action_168 (19) = happyGoto action_74
action_168 (20) = happyGoto action_185
action_168 (71) = happyGoto action_80
action_168 (90) = happyGoto action_81
action_168 _ = happyFail (happyExpListPerState 168)

action_169 _ = happyReduce_31

action_170 _ = happyReduce_115

action_171 _ = happyReduce_106

action_172 _ = happyReduce_101

action_173 (113) = happyShift action_184
action_173 _ = happyFail (happyExpListPerState 173)

action_174 (104) = happyShift action_26
action_174 (113) = happyShift action_63
action_174 (118) = happyShift action_64
action_174 (130) = happyShift action_65
action_174 (5) = happyGoto action_55
action_174 (6) = happyGoto action_56
action_174 (59) = happyGoto action_57
action_174 (60) = happyGoto action_58
action_174 (61) = happyGoto action_183
action_174 _ = happyFail (happyExpListPerState 174)

action_175 _ = happyReduce_135

action_176 _ = happyReduce_99

action_177 (104) = happyShift action_26
action_177 (5) = happyGoto action_178
action_177 (57) = happyGoto action_179
action_177 (58) = happyGoto action_180
action_177 (80) = happyGoto action_181
action_177 (99) = happyGoto action_182
action_177 _ = happyFail (happyExpListPerState 177)

action_178 _ = happyReduce_96

action_179 _ = happyReduce_154

action_180 (108) = happyShift action_243
action_180 _ = happyFail (happyExpListPerState 180)

action_181 _ = happyReduce_97

action_182 (112) = happyShift action_242
action_182 _ = happyReduce_127

action_183 _ = happyReduce_159

action_184 _ = happyReduce_8

action_185 (104) = happyShift action_26
action_185 (107) = happyShift action_82
action_185 (109) = happyShift action_83
action_185 (5) = happyGoto action_71
action_185 (17) = happyGoto action_72
action_185 (18) = happyGoto action_73
action_185 (19) = happyGoto action_169
action_185 (71) = happyGoto action_80
action_185 (90) = happyGoto action_81
action_185 _ = happyReduce_33

action_186 _ = happyReduce_36

action_187 _ = happyReduce_137

action_188 (104) = happyShift action_26
action_188 (5) = happyGoto action_160
action_188 (15) = happyGoto action_241
action_188 _ = happyFail (happyExpListPerState 188)

action_189 _ = happyReduce_118

action_190 (104) = happyShift action_26
action_190 (107) = happyShift action_82
action_190 (109) = happyShift action_83
action_190 (5) = happyGoto action_71
action_190 (17) = happyGoto action_72
action_190 (18) = happyGoto action_73
action_190 (19) = happyGoto action_74
action_190 (20) = happyGoto action_75
action_190 (21) = happyGoto action_76
action_190 (22) = happyGoto action_77
action_190 (23) = happyGoto action_240
action_190 (71) = happyGoto action_80
action_190 (90) = happyGoto action_81
action_190 _ = happyFail (happyExpListPerState 190)

action_191 _ = happyReduce_40

action_192 (104) = happyShift action_26
action_192 (107) = happyShift action_82
action_192 (109) = happyShift action_83
action_192 (5) = happyGoto action_71
action_192 (17) = happyGoto action_72
action_192 (18) = happyGoto action_73
action_192 (19) = happyGoto action_74
action_192 (20) = happyGoto action_75
action_192 (21) = happyGoto action_76
action_192 (22) = happyGoto action_77
action_192 (23) = happyGoto action_239
action_192 (71) = happyGoto action_80
action_192 (90) = happyGoto action_81
action_192 _ = happyFail (happyExpListPerState 192)

action_193 _ = happyReduce_156

action_194 _ = happyReduce_69

action_195 (120) = happyShift action_238
action_195 _ = happyReduce_128

action_196 _ = happyReduce_76

action_197 _ = happyReduce_70

action_198 (104) = happyShift action_26
action_198 (107) = happyShift action_82
action_198 (109) = happyShift action_83
action_198 (119) = happyShift action_84
action_198 (5) = happyGoto action_71
action_198 (17) = happyGoto action_72
action_198 (18) = happyGoto action_73
action_198 (19) = happyGoto action_74
action_198 (20) = happyGoto action_75
action_198 (21) = happyGoto action_76
action_198 (22) = happyGoto action_77
action_198 (23) = happyGoto action_78
action_198 (24) = happyGoto action_237
action_198 (71) = happyGoto action_80
action_198 (90) = happyGoto action_81
action_198 _ = happyFail (happyExpListPerState 198)

action_199 _ = happyReduce_132

action_200 _ = happyReduce_134

action_201 (104) = happyShift action_26
action_201 (5) = happyGoto action_235
action_201 (35) = happyGoto action_236
action_201 _ = happyFail (happyExpListPerState 201)

action_202 (104) = happyShift action_26
action_202 (5) = happyGoto action_233
action_202 (32) = happyGoto action_234
action_202 _ = happyFail (happyExpListPerState 202)

action_203 _ = happyReduce_117

action_204 _ = happyReduce_116

action_205 (104) = happyShift action_26
action_205 (105) = happyShift action_109
action_205 (106) = happyShift action_110
action_205 (107) = happyShift action_111
action_205 (109) = happyShift action_112
action_205 (123) = happyShift action_113
action_205 (124) = happyShift action_114
action_205 (126) = happyShift action_115
action_205 (127) = happyShift action_116
action_205 (5) = happyGoto action_85
action_205 (30) = happyGoto action_86
action_205 (31) = happyGoto action_87
action_205 (34) = happyGoto action_88
action_205 (37) = happyGoto action_89
action_205 (38) = happyGoto action_90
action_205 (40) = happyGoto action_91
action_205 (41) = happyGoto action_92
action_205 (42) = happyGoto action_93
action_205 (43) = happyGoto action_94
action_205 (44) = happyGoto action_95
action_205 (45) = happyGoto action_96
action_205 (46) = happyGoto action_97
action_205 (47) = happyGoto action_98
action_205 (50) = happyGoto action_99
action_205 (52) = happyGoto action_100
action_205 (55) = happyGoto action_101
action_205 (56) = happyGoto action_232
action_205 (69) = happyGoto action_103
action_205 (70) = happyGoto action_104
action_205 (72) = happyGoto action_105
action_205 (85) = happyGoto action_106
action_205 (87) = happyGoto action_107
action_205 (91) = happyGoto action_108
action_205 _ = happyFail (happyExpListPerState 205)

action_206 (104) = happyShift action_26
action_206 (105) = happyShift action_109
action_206 (106) = happyShift action_110
action_206 (107) = happyShift action_111
action_206 (109) = happyShift action_112
action_206 (123) = happyShift action_113
action_206 (124) = happyShift action_114
action_206 (126) = happyShift action_115
action_206 (127) = happyShift action_116
action_206 (5) = happyGoto action_85
action_206 (30) = happyGoto action_86
action_206 (31) = happyGoto action_87
action_206 (34) = happyGoto action_88
action_206 (37) = happyGoto action_89
action_206 (38) = happyGoto action_90
action_206 (40) = happyGoto action_91
action_206 (41) = happyGoto action_92
action_206 (42) = happyGoto action_93
action_206 (43) = happyGoto action_94
action_206 (44) = happyGoto action_95
action_206 (45) = happyGoto action_96
action_206 (46) = happyGoto action_97
action_206 (47) = happyGoto action_98
action_206 (50) = happyGoto action_99
action_206 (52) = happyGoto action_100
action_206 (55) = happyGoto action_101
action_206 (56) = happyGoto action_231
action_206 (69) = happyGoto action_103
action_206 (70) = happyGoto action_104
action_206 (72) = happyGoto action_105
action_206 (85) = happyGoto action_106
action_206 (87) = happyGoto action_107
action_206 (91) = happyGoto action_108
action_206 _ = happyFail (happyExpListPerState 206)

action_207 (116) = happyShift action_230
action_207 _ = happyFail (happyExpListPerState 207)

action_208 (104) = happyShift action_19
action_208 (105) = happyShift action_20
action_208 (106) = happyShift action_21
action_208 (107) = happyShift action_22
action_208 (114) = happyShift action_229
action_208 (5) = happyGoto action_28
action_208 (7) = happyGoto action_6
action_208 (8) = happyGoto action_7
action_208 (9) = happyGoto action_8
action_208 (10) = happyGoto action_9
action_208 (11) = happyGoto action_10
action_208 (12) = happyGoto action_11
action_208 (13) = happyGoto action_12
action_208 (14) = happyGoto action_227
action_208 (48) = happyGoto action_228
action_208 (89) = happyGoto action_18
action_208 _ = happyFail (happyExpListPerState 208)

action_209 (104) = happyShift action_19
action_209 (105) = happyShift action_20
action_209 (106) = happyShift action_21
action_209 (107) = happyShift action_22
action_209 (5) = happyGoto action_28
action_209 (7) = happyGoto action_6
action_209 (8) = happyGoto action_7
action_209 (9) = happyGoto action_8
action_209 (10) = happyGoto action_9
action_209 (11) = happyGoto action_10
action_209 (12) = happyGoto action_11
action_209 (13) = happyGoto action_12
action_209 (14) = happyGoto action_226
action_209 (89) = happyGoto action_18
action_209 _ = happyFail (happyExpListPerState 209)

action_210 (104) = happyShift action_26
action_210 (105) = happyShift action_109
action_210 (106) = happyShift action_110
action_210 (107) = happyShift action_111
action_210 (109) = happyShift action_112
action_210 (123) = happyShift action_113
action_210 (124) = happyShift action_114
action_210 (126) = happyShift action_115
action_210 (127) = happyShift action_116
action_210 (5) = happyGoto action_85
action_210 (30) = happyGoto action_86
action_210 (31) = happyGoto action_87
action_210 (34) = happyGoto action_88
action_210 (37) = happyGoto action_89
action_210 (38) = happyGoto action_90
action_210 (40) = happyGoto action_91
action_210 (41) = happyGoto action_92
action_210 (42) = happyGoto action_93
action_210 (43) = happyGoto action_94
action_210 (44) = happyGoto action_95
action_210 (45) = happyGoto action_96
action_210 (46) = happyGoto action_97
action_210 (47) = happyGoto action_98
action_210 (50) = happyGoto action_99
action_210 (52) = happyGoto action_100
action_210 (55) = happyGoto action_101
action_210 (56) = happyGoto action_225
action_210 (69) = happyGoto action_103
action_210 (70) = happyGoto action_104
action_210 (72) = happyGoto action_105
action_210 (85) = happyGoto action_106
action_210 (87) = happyGoto action_107
action_210 (91) = happyGoto action_108
action_210 _ = happyFail (happyExpListPerState 210)

action_211 _ = happyReduce_148

action_212 (116) = happyShift action_224
action_212 _ = happyFail (happyExpListPerState 212)

action_213 _ = happyReduce_89

action_214 (115) = happyShift action_223
action_214 _ = happyReduce_124

action_215 (104) = happyShift action_26
action_215 (105) = happyShift action_109
action_215 (106) = happyShift action_110
action_215 (107) = happyShift action_111
action_215 (109) = happyShift action_112
action_215 (114) = happyShift action_222
action_215 (123) = happyShift action_113
action_215 (124) = happyShift action_114
action_215 (126) = happyShift action_115
action_215 (127) = happyShift action_116
action_215 (5) = happyGoto action_85
action_215 (30) = happyGoto action_86
action_215 (31) = happyGoto action_87
action_215 (34) = happyGoto action_88
action_215 (37) = happyGoto action_89
action_215 (38) = happyGoto action_90
action_215 (40) = happyGoto action_91
action_215 (41) = happyGoto action_92
action_215 (42) = happyGoto action_93
action_215 (43) = happyGoto action_94
action_215 (44) = happyGoto action_95
action_215 (45) = happyGoto action_96
action_215 (46) = happyGoto action_97
action_215 (47) = happyGoto action_98
action_215 (50) = happyGoto action_99
action_215 (52) = happyGoto action_100
action_215 (55) = happyGoto action_101
action_215 (56) = happyGoto action_221
action_215 (69) = happyGoto action_103
action_215 (70) = happyGoto action_104
action_215 (72) = happyGoto action_105
action_215 (85) = happyGoto action_106
action_215 (87) = happyGoto action_107
action_215 (91) = happyGoto action_108
action_215 _ = happyFail (happyExpListPerState 215)

action_216 (104) = happyShift action_26
action_216 (105) = happyShift action_109
action_216 (106) = happyShift action_110
action_216 (107) = happyShift action_111
action_216 (109) = happyShift action_112
action_216 (123) = happyShift action_113
action_216 (124) = happyShift action_114
action_216 (126) = happyShift action_115
action_216 (127) = happyShift action_116
action_216 (5) = happyGoto action_85
action_216 (30) = happyGoto action_86
action_216 (31) = happyGoto action_87
action_216 (34) = happyGoto action_88
action_216 (37) = happyGoto action_89
action_216 (38) = happyGoto action_90
action_216 (40) = happyGoto action_91
action_216 (41) = happyGoto action_92
action_216 (42) = happyGoto action_93
action_216 (43) = happyGoto action_94
action_216 (44) = happyGoto action_95
action_216 (45) = happyGoto action_96
action_216 (46) = happyGoto action_97
action_216 (47) = happyGoto action_98
action_216 (50) = happyGoto action_99
action_216 (52) = happyGoto action_100
action_216 (55) = happyGoto action_101
action_216 (56) = happyGoto action_220
action_216 (69) = happyGoto action_103
action_216 (70) = happyGoto action_104
action_216 (72) = happyGoto action_105
action_216 (85) = happyGoto action_106
action_216 (87) = happyGoto action_107
action_216 (91) = happyGoto action_108
action_216 _ = happyFail (happyExpListPerState 216)

action_217 (104) = happyShift action_26
action_217 (107) = happyShift action_82
action_217 (109) = happyShift action_83
action_217 (5) = happyGoto action_71
action_217 (17) = happyGoto action_72
action_217 (18) = happyGoto action_73
action_217 (19) = happyGoto action_74
action_217 (20) = happyGoto action_75
action_217 (21) = happyGoto action_76
action_217 (22) = happyGoto action_77
action_217 (23) = happyGoto action_219
action_217 (71) = happyGoto action_80
action_217 (90) = happyGoto action_81
action_217 _ = happyFail (happyExpListPerState 217)

action_218 _ = happyReduce_145

action_219 _ = happyReduce_42

action_220 _ = happyReduce_88

action_221 _ = happyReduce_93

action_222 (104) = happyShift action_26
action_222 (105) = happyShift action_109
action_222 (106) = happyShift action_110
action_222 (107) = happyShift action_111
action_222 (109) = happyShift action_112
action_222 (123) = happyShift action_113
action_222 (124) = happyShift action_114
action_222 (126) = happyShift action_115
action_222 (127) = happyShift action_116
action_222 (5) = happyGoto action_85
action_222 (30) = happyGoto action_86
action_222 (31) = happyGoto action_87
action_222 (34) = happyGoto action_88
action_222 (37) = happyGoto action_89
action_222 (38) = happyGoto action_90
action_222 (40) = happyGoto action_91
action_222 (41) = happyGoto action_92
action_222 (42) = happyGoto action_93
action_222 (43) = happyGoto action_94
action_222 (44) = happyGoto action_95
action_222 (45) = happyGoto action_96
action_222 (46) = happyGoto action_97
action_222 (47) = happyGoto action_98
action_222 (50) = happyGoto action_99
action_222 (52) = happyGoto action_100
action_222 (55) = happyGoto action_101
action_222 (56) = happyGoto action_254
action_222 (69) = happyGoto action_103
action_222 (70) = happyGoto action_104
action_222 (72) = happyGoto action_105
action_222 (85) = happyGoto action_106
action_222 (87) = happyGoto action_107
action_222 (91) = happyGoto action_108
action_222 _ = happyFail (happyExpListPerState 222)

action_223 (104) = happyShift action_19
action_223 (105) = happyShift action_20
action_223 (106) = happyShift action_21
action_223 (107) = happyShift action_22
action_223 (5) = happyGoto action_28
action_223 (7) = happyGoto action_6
action_223 (8) = happyGoto action_7
action_223 (9) = happyGoto action_8
action_223 (10) = happyGoto action_9
action_223 (11) = happyGoto action_10
action_223 (12) = happyGoto action_11
action_223 (13) = happyGoto action_12
action_223 (14) = happyGoto action_130
action_223 (53) = happyGoto action_253
action_223 (89) = happyGoto action_18
action_223 _ = happyFail (happyExpListPerState 223)

action_224 (128) = happyShift action_252
action_224 _ = happyFail (happyExpListPerState 224)

action_225 _ = happyReduce_86

action_226 _ = happyReduce_161

action_227 (117) = happyShift action_251
action_227 _ = happyFail (happyExpListPerState 227)

action_228 _ = happyReduce_80

action_229 (104) = happyShift action_19
action_229 (105) = happyShift action_20
action_229 (106) = happyShift action_21
action_229 (107) = happyShift action_22
action_229 (5) = happyGoto action_28
action_229 (7) = happyGoto action_6
action_229 (8) = happyGoto action_7
action_229 (9) = happyGoto action_8
action_229 (10) = happyGoto action_9
action_229 (11) = happyGoto action_10
action_229 (12) = happyGoto action_11
action_229 (13) = happyGoto action_12
action_229 (14) = happyGoto action_227
action_229 (48) = happyGoto action_247
action_229 (49) = happyGoto action_248
action_229 (76) = happyGoto action_249
action_229 (89) = happyGoto action_18
action_229 (95) = happyGoto action_250
action_229 _ = happyFail (happyExpListPerState 229)

action_230 (125) = happyShift action_246
action_230 _ = happyFail (happyExpListPerState 230)

action_231 _ = happyReduce_55

action_232 _ = happyReduce_50

action_233 (111) = happyShift action_205
action_233 _ = happyReduce_51

action_234 _ = happyReduce_151

action_235 (122) = happyShift action_206
action_235 _ = happyFail (happyExpListPerState 235)

action_236 _ = happyReduce_153

action_237 _ = happyReduce_60

action_238 (104) = happyShift action_26
action_238 (5) = happyGoto action_245
action_238 _ = happyFail (happyExpListPerState 238)

action_239 _ = happyReduce_38

action_240 _ = happyReduce_23

action_241 _ = happyReduce_163

action_242 (104) = happyShift action_26
action_242 (5) = happyGoto action_178
action_242 (57) = happyGoto action_244
action_242 _ = happyFail (happyExpListPerState 242)

action_243 _ = happyReduce_133

action_244 _ = happyReduce_155

action_245 _ = happyReduce_157

action_246 (104) = happyShift action_19
action_246 (105) = happyShift action_20
action_246 (106) = happyShift action_21
action_246 (107) = happyShift action_22
action_246 (114) = happyShift action_262
action_246 (5) = happyGoto action_28
action_246 (7) = happyGoto action_6
action_246 (8) = happyGoto action_7
action_246 (9) = happyGoto action_8
action_246 (10) = happyGoto action_9
action_246 (11) = happyGoto action_10
action_246 (12) = happyGoto action_11
action_246 (13) = happyGoto action_12
action_246 (14) = happyGoto action_227
action_246 (48) = happyGoto action_261
action_246 (89) = happyGoto action_18
action_246 _ = happyFail (happyExpListPerState 246)

action_247 _ = happyReduce_146

action_248 (116) = happyShift action_260
action_248 _ = happyFail (happyExpListPerState 248)

action_249 _ = happyReduce_79

action_250 (115) = happyShift action_259
action_250 _ = happyReduce_123

action_251 (104) = happyShift action_26
action_251 (105) = happyShift action_109
action_251 (106) = happyShift action_110
action_251 (107) = happyShift action_111
action_251 (109) = happyShift action_112
action_251 (123) = happyShift action_113
action_251 (124) = happyShift action_114
action_251 (126) = happyShift action_115
action_251 (127) = happyShift action_116
action_251 (5) = happyGoto action_85
action_251 (30) = happyGoto action_86
action_251 (31) = happyGoto action_87
action_251 (34) = happyGoto action_88
action_251 (37) = happyGoto action_89
action_251 (38) = happyGoto action_90
action_251 (40) = happyGoto action_91
action_251 (41) = happyGoto action_92
action_251 (42) = happyGoto action_93
action_251 (43) = happyGoto action_94
action_251 (44) = happyGoto action_95
action_251 (45) = happyGoto action_96
action_251 (46) = happyGoto action_97
action_251 (47) = happyGoto action_98
action_251 (50) = happyGoto action_99
action_251 (52) = happyGoto action_100
action_251 (55) = happyGoto action_101
action_251 (56) = happyGoto action_258
action_251 (69) = happyGoto action_103
action_251 (70) = happyGoto action_104
action_251 (72) = happyGoto action_105
action_251 (85) = happyGoto action_106
action_251 (87) = happyGoto action_107
action_251 (91) = happyGoto action_108
action_251 _ = happyFail (happyExpListPerState 251)

action_252 (104) = happyShift action_26
action_252 (105) = happyShift action_109
action_252 (106) = happyShift action_110
action_252 (107) = happyShift action_111
action_252 (109) = happyShift action_112
action_252 (114) = happyShift action_257
action_252 (123) = happyShift action_113
action_252 (124) = happyShift action_114
action_252 (126) = happyShift action_115
action_252 (127) = happyShift action_116
action_252 (5) = happyGoto action_85
action_252 (30) = happyGoto action_86
action_252 (31) = happyGoto action_87
action_252 (34) = happyGoto action_88
action_252 (37) = happyGoto action_89
action_252 (38) = happyGoto action_90
action_252 (40) = happyGoto action_91
action_252 (41) = happyGoto action_92
action_252 (42) = happyGoto action_93
action_252 (43) = happyGoto action_94
action_252 (44) = happyGoto action_95
action_252 (45) = happyGoto action_96
action_252 (46) = happyGoto action_97
action_252 (47) = happyGoto action_98
action_252 (50) = happyGoto action_99
action_252 (52) = happyGoto action_100
action_252 (55) = happyGoto action_101
action_252 (56) = happyGoto action_256
action_252 (69) = happyGoto action_103
action_252 (70) = happyGoto action_104
action_252 (72) = happyGoto action_105
action_252 (85) = happyGoto action_106
action_252 (87) = happyGoto action_107
action_252 (91) = happyGoto action_108
action_252 _ = happyFail (happyExpListPerState 252)

action_253 _ = happyReduce_149

action_254 (116) = happyShift action_255
action_254 _ = happyFail (happyExpListPerState 254)

action_255 _ = happyReduce_92

action_256 _ = happyReduce_91

action_257 (104) = happyShift action_26
action_257 (105) = happyShift action_109
action_257 (106) = happyShift action_110
action_257 (107) = happyShift action_111
action_257 (109) = happyShift action_112
action_257 (123) = happyShift action_113
action_257 (124) = happyShift action_114
action_257 (126) = happyShift action_115
action_257 (127) = happyShift action_116
action_257 (5) = happyGoto action_85
action_257 (30) = happyGoto action_86
action_257 (31) = happyGoto action_87
action_257 (34) = happyGoto action_88
action_257 (37) = happyGoto action_89
action_257 (38) = happyGoto action_90
action_257 (40) = happyGoto action_91
action_257 (41) = happyGoto action_92
action_257 (42) = happyGoto action_93
action_257 (43) = happyGoto action_94
action_257 (44) = happyGoto action_95
action_257 (45) = happyGoto action_96
action_257 (46) = happyGoto action_97
action_257 (47) = happyGoto action_98
action_257 (50) = happyGoto action_99
action_257 (52) = happyGoto action_100
action_257 (55) = happyGoto action_101
action_257 (56) = happyGoto action_265
action_257 (69) = happyGoto action_103
action_257 (70) = happyGoto action_104
action_257 (72) = happyGoto action_105
action_257 (85) = happyGoto action_106
action_257 (87) = happyGoto action_107
action_257 (91) = happyGoto action_108
action_257 _ = happyFail (happyExpListPerState 257)

action_258 _ = happyReduce_78

action_259 (104) = happyShift action_19
action_259 (105) = happyShift action_20
action_259 (106) = happyShift action_21
action_259 (107) = happyShift action_22
action_259 (5) = happyGoto action_28
action_259 (7) = happyGoto action_6
action_259 (8) = happyGoto action_7
action_259 (9) = happyGoto action_8
action_259 (10) = happyGoto action_9
action_259 (11) = happyGoto action_10
action_259 (12) = happyGoto action_11
action_259 (13) = happyGoto action_12
action_259 (14) = happyGoto action_227
action_259 (48) = happyGoto action_264
action_259 (89) = happyGoto action_18
action_259 _ = happyFail (happyExpListPerState 259)

action_260 _ = happyReduce_82

action_261 _ = happyReduce_81

action_262 (104) = happyShift action_19
action_262 (105) = happyShift action_20
action_262 (106) = happyShift action_21
action_262 (107) = happyShift action_22
action_262 (5) = happyGoto action_28
action_262 (7) = happyGoto action_6
action_262 (8) = happyGoto action_7
action_262 (9) = happyGoto action_8
action_262 (10) = happyGoto action_9
action_262 (11) = happyGoto action_10
action_262 (12) = happyGoto action_11
action_262 (13) = happyGoto action_12
action_262 (14) = happyGoto action_227
action_262 (48) = happyGoto action_247
action_262 (49) = happyGoto action_263
action_262 (76) = happyGoto action_249
action_262 (89) = happyGoto action_18
action_262 (95) = happyGoto action_250
action_262 _ = happyFail (happyExpListPerState 262)

action_263 (116) = happyShift action_267
action_263 _ = happyFail (happyExpListPerState 263)

action_264 _ = happyReduce_147

action_265 (116) = happyShift action_266
action_265 _ = happyFail (happyExpListPerState 265)

action_266 _ = happyReduce_90

action_267 _ = happyReduce_83

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_1  4 happyReduction_2
happyReduction_2 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_2 _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_1  4 happyReduction_3
happyReduction_3 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_1  4 happyReduction_4
happyReduction_4 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_4 _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_1  4 happyReduction_5
happyReduction_5 (HappyAbsSyn63  happy_var_1)
	 =  HappyAbsSyn4
		 (ModuleImport (getRange happy_var_1) happy_var_1
	)
happyReduction_5 _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_1  5 happyReduction_6
happyReduction_6 (HappyTerminal (TokenVariable _ happy_var_1))
	 =  HappyAbsSyn5
		 (tokenVariable2Variable happy_var_1
	)
happyReduction_6 _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_1  6 happyReduction_7
happyReduction_7 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn6
		 (case happy_var_1 of 
    TokenOperator _ op ->
      lexerOperator2Operator op
	)
happyReduction_7 _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_3  6 happyReduction_8
happyReduction_8 _
	(HappyTerminal (TokenVariable _ happy_var_2))
	_
	 =  HappyAbsSyn6
		 (let variable = tokenVariable2Variable happy_var_2
    in
      VariableAsOperator (getRange variable) variable
	)
happyReduction_8 _ _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_1  7 happyReduction_9
happyReduction_9 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn7
		 (VariablePattern (getRange happy_var_1) happy_var_1
	)
happyReduction_9 _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_1  8 happyReduction_10
happyReduction_10 (HappyTerminal (Hole happy_var_1))
	 =  HappyAbsSyn7
		 (HolePattern happy_var_1
	)
happyReduction_10 _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_1  9 happyReduction_11
happyReduction_11 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn7
		 (let literal=(tokenLiteral2Literal happy_var_1) 
  in 
    LiteralPattern (getRange literal) literal
	)
happyReduction_11 _  = notHappyAtAll 

happyReduce_12 = happyReduce 5 10 happyReduction_12
happyReduction_12 ((HappyTerminal (RightParen happy_var_5)) `HappyStk`
	(HappyAbsSyn17  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_2) `HappyStk`
	(HappyTerminal (LeftParen happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (AnnotationPattern (getRange (happy_var_1,happy_var_5)) happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_13 = happySpecReduce_1  11 happyReduction_13
happyReduction_13 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_13 _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_1  11 happyReduction_14
happyReduction_14 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_14 _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_1  11 happyReduction_15
happyReduction_15 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_15 _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_1  11 happyReduction_16
happyReduction_16 (HappyAbsSyn89  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_16 _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_1  11 happyReduction_17
happyReduction_17 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_17 _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_3  12 happyReduction_18
happyReduction_18 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn7
		 (AsPattern (getRange (happy_var_1,happy_var_3)) happy_var_1 happy_var_3
	)
happyReduction_18 _ _ _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_1  12 happyReduction_19
happyReduction_19 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_19 _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_2  13 happyReduction_20
happyReduction_20 (HappyAbsSyn74  happy_var_2)
	(HappyTerminal (TokenVariable _ happy_var_1))
	 =  HappyAbsSyn7
		 (let variable=(tokenVariable2Variable happy_var_1) 
  in
    ApplicationPattern (getRange(variable,happy_var_2)) variable happy_var_2
	)
happyReduction_20 _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_1  13 happyReduction_21
happyReduction_21 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_21 _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_1  14 happyReduction_22
happyReduction_22 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_22 _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_3  15 happyReduction_23
happyReduction_23 (HappyAbsSyn17  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn15
		 ((getRange (happy_var_1,happy_var_3),happy_var_1,happy_var_3)
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_1  16 happyReduction_24
happyReduction_24 (HappyAbsSyn84  happy_var_1)
	 =  HappyAbsSyn16
		 (happy_var_1
	)
happyReduction_24 _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_1  17 happyReduction_25
happyReduction_25 (HappyAbsSyn71  happy_var_1)
	 =  HappyAbsSyn17
		 (RecordType (getRange happy_var_1) (NonEmptyRecord (getRange happy_var_1) happy_var_1)
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_1  18 happyReduction_26
happyReduction_26 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn17
		 (VariableType (getRange happy_var_1) happy_var_1
	)
happyReduction_26 _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_1  19 happyReduction_27
happyReduction_27 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_27 _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_1  19 happyReduction_28
happyReduction_28 (HappyAbsSyn90  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_28 _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_1  19 happyReduction_29
happyReduction_29 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_29 _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_1  20 happyReduction_30
happyReduction_30 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_30 _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_2  20 happyReduction_31
happyReduction_31 (HappyAbsSyn17  happy_var_2)
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (ApplicationType (getRange (happy_var_2,happy_var_1)) happy_var_2 happy_var_1
	)
happyReduction_31 _ _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_1  21 happyReduction_32
happyReduction_32 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn21
		 (FirstItem happy_var_1
	)
happyReduction_32 _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_3  21 happyReduction_33
happyReduction_33 (HappyAbsSyn17  happy_var_3)
	(HappyAbsSyn6  happy_var_2)
	(HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn21
		 (IntercalatedCons happy_var_3 (IntercalatedCons happy_var_2 happy_var_1)
	)
happyReduction_33 _ _ _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_1  22 happyReduction_34
happyReduction_34 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn17
		 (case happy_var_1 of 
    FirstItem e -> e
    _ ->
      MeaninglessOperatorsType  (getRange happy_var_1) happy_var_1
	)
happyReduction_34 _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_1  23 happyReduction_35
happyReduction_35 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_35 _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_3  23 happyReduction_36
happyReduction_36 (HappyAbsSyn17  happy_var_3)
	_
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (TypeArrow (getRange (happy_var_1,happy_var_3)) happy_var_1 happy_var_3
	)
happyReduction_36 _ _ _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_1  24 happyReduction_37
happyReduction_37 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_37 _  = notHappyAtAll 

happyReduce_38 = happyReduce 4 24 happyReduction_38
happyReduction_38 ((HappyAbsSyn17  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn25  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn17
		 (TypeForall (getRange (happy_var_2,happy_var_4)) happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_39 = happySpecReduce_1  25 happyReduction_39
happyReduction_39 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn25
		 (happy_var_1 :| []
	)
happyReduction_39 _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_2  25 happyReduction_40
happyReduction_40 (HappyAbsSyn5  happy_var_2)
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (cons happy_var_2 happy_var_1
	)
happyReduction_40 _ _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_1  26 happyReduction_41
happyReduction_41 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn26
		 ([happy_var_1]
	)
happyReduction_41 _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_3  26 happyReduction_42
happyReduction_42 (HappyAbsSyn17  happy_var_3)
	_
	(HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn26
		 (happy_var_3:happy_var_1
	)
happyReduction_42 _ _ _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_1  27 happyReduction_43
happyReduction_43 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn27
		 (Constructor (getRange happy_var_1) happy_var_1 []
	)
happyReduction_43 _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_2  27 happyReduction_44
happyReduction_44 (HappyAbsSyn26  happy_var_2)
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn27
		 (Constructor (getRange happy_var_1) happy_var_1 happy_var_2
	)
happyReduction_44 _ _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_1  28 happyReduction_45
happyReduction_45 (HappyAbsSyn75  happy_var_1)
	 =  HappyAbsSyn28
		 (happy_var_1
	)
happyReduction_45 _  = notHappyAtAll 

happyReduce_46 = happyReduce 5 29 happyReduction_46
happyReduction_46 ((HappyAbsSyn28  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn73  happy_var_3) `HappyStk`
	(HappyAbsSyn5  happy_var_2) `HappyStk`
	(HappyTerminal (Data happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (ModuleDataType (getRange (happy_var_1,happy_var_5)) happy_var_2 (toList happy_var_3) happy_var_5
	) `HappyStk` happyRest

happyReduce_47 = happyReduce 4 29 happyReduction_47
happyReduction_47 ((HappyAbsSyn28  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_2) `HappyStk`
	(HappyTerminal (Data happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (ModuleDataType (getRange (happy_var_1,happy_var_4)) happy_var_2 [] happy_var_4
	) `HappyStk` happyRest

happyReduce_48 = happySpecReduce_1  30 happyReduction_48
happyReduction_48 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn30
		 (let literal=(tokenLiteral2Literal happy_var_1) 
  in 
    LiteralExpression (getRange literal) literal
	)
happyReduction_48 _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_1  31 happyReduction_49
happyReduction_49 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn30
		 (VariableExpression (getRange happy_var_1) happy_var_1
	)
happyReduction_49 _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_3  32 happyReduction_50
happyReduction_50 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn32
		 (((getRange (happy_var_1,happy_var_3)),happy_var_1,Just happy_var_3)
	)
happyReduction_50 _ _ _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_1  32 happyReduction_51
happyReduction_51 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn32
		 (((getRange happy_var_1),happy_var_1,Nothing)
	)
happyReduction_51 _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_1  33 happyReduction_52
happyReduction_52 (HappyAbsSyn78  happy_var_1)
	 =  HappyAbsSyn33
		 (happy_var_1
	)
happyReduction_52 _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_1  34 happyReduction_53
happyReduction_53 (HappyAbsSyn69  happy_var_1)
	 =  HappyAbsSyn30
		 (let range = getRange $ (\ (x,_,_) -> x ) <$> happy_var_1 
    in
    RecordExpression range (NonEmptyRecord range happy_var_1)
	)
happyReduction_53 _  = notHappyAtAll 

happyReduce_54 = happySpecReduce_2  34 happyReduction_54
happyReduction_54 (HappyTerminal (RightBrace happy_var_2))
	(HappyTerminal (LeftBrace happy_var_1))
	 =  HappyAbsSyn30
		 (RecordExpression (getRange (happy_var_1,happy_var_2)) (EmptyRecord (getRange (happy_var_1,happy_var_2)))
	)
happyReduction_54 _ _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_3  35 happyReduction_55
happyReduction_55 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn35
		 ((getRange (happy_var_1,happy_var_3),happy_var_1,happy_var_3)
	)
happyReduction_55 _ _ _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_1  36 happyReduction_56
happyReduction_56 (HappyAbsSyn79  happy_var_1)
	 =  HappyAbsSyn36
		 (happy_var_1
	)
happyReduction_56 _  = notHappyAtAll 

happyReduce_57 = happySpecReduce_1  37 happyReduction_57
happyReduction_57 (HappyAbsSyn70  happy_var_1)
	 =  HappyAbsSyn30
		 (RecordUpdate (getRange happy_var_1) (NonEmptyRecord (getRange happy_var_1) happy_var_1)
	)
happyReduction_57 _  = notHappyAtAll 

happyReduce_58 = happySpecReduce_1  38 happyReduction_58
happyReduction_58 (HappyAbsSyn87  happy_var_1)
	 =  HappyAbsSyn30
		 (OperatorInParens (getRange happy_var_1) happy_var_1
	)
happyReduction_58 _  = notHappyAtAll 

happyReduce_59 = happySpecReduce_1  39 happyReduction_59
happyReduction_59 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_59 _  = notHappyAtAll 

happyReduce_60 = happySpecReduce_3  39 happyReduction_60
happyReduction_60 (HappyAbsSyn17  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (AnnotationExpression (getRange (happy_var_1,happy_var_3)) happy_var_1 happy_var_3
	)
happyReduction_60 _ _ _  = notHappyAtAll 

happyReduce_61 = happySpecReduce_2  40 happyReduction_61
happyReduction_61 (HappyAbsSyn17  happy_var_2)
	(HappyTerminal (At happy_var_1))
	 =  HappyAbsSyn30
		 (TypeArgumentExpression (getRange (happy_var_1,happy_var_2)) happy_var_2
	)
happyReduction_61 _ _  = notHappyAtAll 

happyReduce_62 = happySpecReduce_1  41 happyReduction_62
happyReduction_62 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_62 _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_1  41 happyReduction_63
happyReduction_63 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_63 _  = notHappyAtAll 

happyReduce_64 = happySpecReduce_1  41 happyReduction_64
happyReduction_64 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_64 _  = notHappyAtAll 

happyReduce_65 = happySpecReduce_1  41 happyReduction_65
happyReduction_65 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_65 _  = notHappyAtAll 

happyReduce_66 = happySpecReduce_1  41 happyReduction_66
happyReduction_66 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_66 _  = notHappyAtAll 

happyReduce_67 = happySpecReduce_1  41 happyReduction_67
happyReduction_67 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_67 _  = notHappyAtAll 

happyReduce_68 = happySpecReduce_1  41 happyReduction_68
happyReduction_68 (HappyAbsSyn85  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_68 _  = notHappyAtAll 

happyReduce_69 = happySpecReduce_3  42 happyReduction_69
happyReduction_69 (HappyAbsSyn81  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (makeAccessor happy_var_1 (toList happy_var_3)
	)
happyReduction_69 _ _ _  = notHappyAtAll 

happyReduce_70 = happySpecReduce_3  43 happyReduction_70
happyReduction_70 (HappyAbsSyn5  happy_var_3)
	_
	(HappyTerminal (Hole happy_var_1))
	 =  HappyAbsSyn30
		 (AccessorFunction (getRange (happy_var_1,happy_var_3)) happy_var_3
	)
happyReduction_70 _ _ _  = notHappyAtAll 

happyReduce_71 = happySpecReduce_1  44 happyReduction_71
happyReduction_71 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_71 _  = notHappyAtAll 

happyReduce_72 = happySpecReduce_1  44 happyReduction_72
happyReduction_72 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_72 _  = notHappyAtAll 

happyReduce_73 = happySpecReduce_1  44 happyReduction_73
happyReduction_73 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_73 _  = notHappyAtAll 

happyReduce_74 = happySpecReduce_1  45 happyReduction_74
happyReduction_74 (HappyAbsSyn72  happy_var_1)
	 =  HappyAbsSyn30
		 (case uncons happy_var_1 of 
    (f , Nothing) -> f
    (f ,Just args) ->
      ApplicationExpression (getRange happy_var_1) f args
	)
happyReduction_74 _  = notHappyAtAll 

happyReduce_75 = happySpecReduce_1  46 happyReduction_75
happyReduction_75 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn46
		 (FirstItem happy_var_1
	)
happyReduction_75 _  = notHappyAtAll 

happyReduce_76 = happySpecReduce_3  46 happyReduction_76
happyReduction_76 (HappyAbsSyn30  happy_var_3)
	(HappyAbsSyn6  happy_var_2)
	(HappyAbsSyn46  happy_var_1)
	 =  HappyAbsSyn46
		 (IntercalatedCons happy_var_3 (IntercalatedCons happy_var_2 happy_var_1)
	)
happyReduction_76 _ _ _  = notHappyAtAll 

happyReduce_77 = happySpecReduce_1  47 happyReduction_77
happyReduction_77 (HappyAbsSyn46  happy_var_1)
	 =  HappyAbsSyn30
		 (case happy_var_1 of 
    FirstItem e -> e
    _ ->
      MeaninglessOperatorsExpression  (getRange happy_var_1) happy_var_1
	)
happyReduction_77 _  = notHappyAtAll 

happyReduce_78 = happySpecReduce_3  48 happyReduction_78
happyReduction_78 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn48
		 (CaseCase (getRange (happy_var_1,happy_var_3)) happy_var_1 happy_var_3
	)
happyReduction_78 _ _ _  = notHappyAtAll 

happyReduce_79 = happySpecReduce_1  49 happyReduction_79
happyReduction_79 (HappyAbsSyn76  happy_var_1)
	 =  HappyAbsSyn49
		 (happy_var_1
	)
happyReduction_79 _  = notHappyAtAll 

happyReduce_80 = happyReduce 4 50 happyReduction_80
happyReduction_80 ((HappyAbsSyn48  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_2) `HappyStk`
	(HappyTerminal (Case happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (SST.Case (getRange (happy_var_1,happy_var_4)) happy_var_2 (singleton happy_var_4)
	) `HappyStk` happyRest

happyReduce_81 = happyReduce 6 50 happyReduction_81
happyReduction_81 ((HappyAbsSyn48  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Case happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (SST.Case (getRange (happy_var_1,happy_var_6)) happy_var_3 (singleton happy_var_6)
	) `HappyStk` happyRest

happyReduce_82 = happyReduce 6 50 happyReduction_82
happyReduction_82 (_ `HappyStk`
	(HappyAbsSyn49  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_2) `HappyStk`
	(HappyTerminal (Case happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (SST.Case (getRange (happy_var_1,happy_var_5)) happy_var_2 happy_var_5
	) `HappyStk` happyRest

happyReduce_83 = happyReduce 8 50 happyReduction_83
happyReduction_83 (_ `HappyStk`
	(HappyAbsSyn49  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Case happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (SST.Case (getRange (happy_var_1,happy_var_7)) happy_var_3 happy_var_7
	) `HappyStk` happyRest

happyReduce_84 = happySpecReduce_1  50 happyReduction_84
happyReduction_84 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_84 _  = notHappyAtAll 

happyReduce_85 = happySpecReduce_1  51 happyReduction_85
happyReduction_85 (HappyAbsSyn83  happy_var_1)
	 =  HappyAbsSyn51
		 (happy_var_1
	)
happyReduction_85 _  = notHappyAtAll 

happyReduce_86 = happyReduce 4 52 happyReduction_86
happyReduction_86 ((HappyAbsSyn30  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn51  happy_var_2) `HappyStk`
	(HappyTerminal (LambdaStart happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (Lambda (getRange (happy_var_1,happy_var_4)) happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_87 = happySpecReduce_1  52 happyReduction_87
happyReduction_87 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_87 _  = notHappyAtAll 

happyReduce_88 = happySpecReduce_3  53 happyReduction_88
happyReduction_88 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn53
		 (LetBinding (getRange (happy_var_1,happy_var_3)) happy_var_1 happy_var_3
	)
happyReduction_88 _ _ _  = notHappyAtAll 

happyReduce_89 = happySpecReduce_1  54 happyReduction_89
happyReduction_89 (HappyAbsSyn77  happy_var_1)
	 =  HappyAbsSyn54
		 (happy_var_1
	)
happyReduction_89 _  = notHappyAtAll 

happyReduce_90 = happyReduce 8 55 happyReduction_90
happyReduction_90 (_ `HappyStk`
	(HappyAbsSyn30  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn54  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Let happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (SST.Let (getRange (happy_var_1,happy_var_7)) happy_var_3 happy_var_7
	) `HappyStk` happyRest

happyReduce_91 = happyReduce 6 55 happyReduction_91
happyReduction_91 ((HappyAbsSyn30  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn54  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Let happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (SST.Let (getRange (happy_var_1,happy_var_6)) happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_92 = happyReduce 6 55 happyReduction_92
happyReduction_92 (_ `HappyStk`
	(HappyAbsSyn30  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn53  happy_var_2) `HappyStk`
	(HappyTerminal (Let happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (SST.Let (getRange (happy_var_1,happy_var_5)) (happy_var_2 :|[]) happy_var_5
	) `HappyStk` happyRest

happyReduce_93 = happyReduce 4 55 happyReduction_93
happyReduction_93 ((HappyAbsSyn30  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn53  happy_var_2) `HappyStk`
	(HappyTerminal (Let happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (SST.Let (getRange (happy_var_1,happy_var_4)) (happy_var_2 :| []) happy_var_4
	) `HappyStk` happyRest

happyReduce_94 = happySpecReduce_1  55 happyReduction_94
happyReduction_94 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_94 _  = notHappyAtAll 

happyReduce_95 = happySpecReduce_1  56 happyReduction_95
happyReduction_95 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_95 _  = notHappyAtAll 

happyReduce_96 = happySpecReduce_1  57 happyReduction_96
happyReduction_96 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_96 _  = notHappyAtAll 

happyReduce_97 = happySpecReduce_1  58 happyReduction_97
happyReduction_97 (HappyAbsSyn80  happy_var_1)
	 =  HappyAbsSyn25
		 (happy_var_1
	)
happyReduction_97 _  = notHappyAtAll 

happyReduce_98 = happySpecReduce_1  59 happyReduction_98
happyReduction_98 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn59
		 (ImportTypeOrVar (getRange happy_var_1) happy_var_1 []
	)
happyReduction_98 _  = notHappyAtAll 

happyReduce_99 = happySpecReduce_2  59 happyReduction_99
happyReduction_99 (HappyAbsSyn86  happy_var_2)
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn59
		 (ImportTypeOrVar (getRange (happy_var_1,happy_var_2)) happy_var_1 (toList happy_var_2)
	)
happyReduction_99 _ _  = notHappyAtAll 

happyReduce_100 = happySpecReduce_1  60 happyReduction_100
happyReduction_100 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn59
		 (ImportTermOperator (getRange happy_var_1) happy_var_1
	)
happyReduction_100 _  = notHappyAtAll 

happyReduce_101 = happySpecReduce_2  60 happyReduction_101
happyReduction_101 (HappyAbsSyn6  happy_var_2)
	(HappyTerminal (Type happy_var_1))
	 =  HappyAbsSyn59
		 (ImportTypeOperator (getRange (happy_var_1,happy_var_2)) happy_var_2
	)
happyReduction_101 _ _  = notHappyAtAll 

happyReduce_102 = happySpecReduce_1  61 happyReduction_102
happyReduction_102 (HappyAbsSyn59  happy_var_1)
	 =  HappyAbsSyn59
		 (happy_var_1
	)
happyReduction_102 _  = notHappyAtAll 

happyReduce_103 = happySpecReduce_1  61 happyReduction_103
happyReduction_103 (HappyAbsSyn59  happy_var_1)
	 =  HappyAbsSyn59
		 (happy_var_1
	)
happyReduction_103 _  = notHappyAtAll 

happyReduce_104 = happySpecReduce_1  62 happyReduction_104
happyReduction_104 (HappyAbsSyn82  happy_var_1)
	 =  HappyAbsSyn62
		 (happy_var_1
	)
happyReduction_104 _  = notHappyAtAll 

happyReduce_105 = happyReduce 4 63 happyReduction_105
happyReduction_105 ((HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn63
		 (ImportAs (getRange (happy_var_2,happy_var_4)) happy_var_2 [] happy_var_4
	) `HappyStk` happyRest

happyReduce_106 = happyReduce 5 63 happyReduction_106
happyReduction_106 ((HappyAbsSyn5  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn88  happy_var_3) `HappyStk`
	(HappyAbsSyn5  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn63
		 (ImportAs (getRange (happy_var_2,happy_var_5)) happy_var_2 (toList happy_var_3) happy_var_5
	) `HappyStk` happyRest

happyReduce_107 = happySpecReduce_2  63 happyReduction_107
happyReduction_107 (HappyAbsSyn5  happy_var_2)
	_
	 =  HappyAbsSyn63
		 (ImportSimple (getRange happy_var_2) happy_var_2 []
	)
happyReduction_107 _ _  = notHappyAtAll 

happyReduce_108 = happyReduce 5 64 happyReduction_108
happyReduction_108 (_ `HappyStk`
	(HappyAbsSyn17  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (ModuleVariableDeclaration (getRange (happy_var_1,happy_var_4)) happy_var_1 happy_var_4
	) `HappyStk` happyRest

happyReduce_109 = happyReduce 5 65 happyReduction_109
happyReduction_109 (_ `HappyStk`
	(HappyAbsSyn30  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (ModulePatternDefinition (getRange (happy_var_1,happy_var_4)) happy_var_1 happy_var_4
	) `HappyStk` happyRest

happyReduce_110 = happySpecReduce_1  66 happyReduction_110
happyReduction_110 (HappyTerminal (Type happy_var_1))
	 =  HappyAbsSyn66
		 (IsTypeOperator (getRange happy_var_1)
	)
happyReduction_110 _  = notHappyAtAll 

happyReduce_111 = happySpecReduce_1  66 happyReduction_111
happyReduction_111 (HappyTerminal (Term happy_var_1))
	 =  HappyAbsSyn66
		 (IsTypeOperator(getRange happy_var_1)
	)
happyReduction_111 _  = notHappyAtAll 

happyReduce_112 = happySpecReduce_1  67 happyReduction_112
happyReduction_112 (HappyTerminal (Left_ happy_var_1))
	 =  HappyAbsSyn67
		 (LeftOperator(getRange happy_var_1)
	)
happyReduction_112 _  = notHappyAtAll 

happyReduce_113 = happySpecReduce_1  67 happyReduction_113
happyReduction_113 (HappyTerminal (Right_ happy_var_1))
	 =  HappyAbsSyn67
		 (RightOperator(getRange happy_var_1)
	)
happyReduction_113 _  = notHappyAtAll 

happyReduce_114 = happySpecReduce_1  67 happyReduction_114
happyReduction_114 (HappyTerminal (None happy_var_1))
	 =  HappyAbsSyn67
		 (NoneOperator(getRange happy_var_1)
	)
happyReduction_114 _  = notHappyAtAll 

happyReduce_115 = happyReduce 5 68 happyReduction_115
happyReduction_115 ((HappyTerminal happy_var_5) `HappyStk`
	(HappyAbsSyn67  happy_var_4) `HappyStk`
	(HappyAbsSyn66  happy_var_3) `HappyStk`
	(HappyTerminal happy_var_2) `HappyStk`
	(HappyTerminal (OperatorKeyword happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (case happy_var_5 of 
    Types.LiteralUint r v -> 
      case happy_var_2 of 
        TokenOperator _ op ->
          let op' = lexerOperator2Operator op
          in
            ModuleOperatorFixity (getRange (happy_var_1,r)) op' happy_var_3 happy_var_4 (read v)
    _ -> error "This can't happend"
	) `HappyStk` happyRest

happyReduce_116 = happySpecReduce_3  69 happyReduction_116
happyReduction_116 _
	(HappyAbsSyn33  happy_var_2)
	_
	 =  HappyAbsSyn69
		 (happy_var_2
	)
happyReduction_116 _ _ _  = notHappyAtAll 

happyReduce_117 = happySpecReduce_3  70 happyReduction_117
happyReduction_117 _
	(HappyAbsSyn36  happy_var_2)
	_
	 =  HappyAbsSyn70
		 (happy_var_2
	)
happyReduction_117 _ _ _  = notHappyAtAll 

happyReduce_118 = happySpecReduce_3  71 happyReduction_118
happyReduction_118 _
	(HappyAbsSyn16  happy_var_2)
	_
	 =  HappyAbsSyn71
		 (happy_var_2
	)
happyReduction_118 _ _ _  = notHappyAtAll 

happyReduce_119 = happySpecReduce_1  72 happyReduction_119
happyReduction_119 (HappyAbsSyn91  happy_var_1)
	 =  HappyAbsSyn72
		 (reverse happy_var_1
	)
happyReduction_119 _  = notHappyAtAll 

happyReduce_120 = happySpecReduce_1  73 happyReduction_120
happyReduction_120 (HappyAbsSyn92  happy_var_1)
	 =  HappyAbsSyn73
		 (reverse happy_var_1
	)
happyReduction_120 _  = notHappyAtAll 

happyReduce_121 = happySpecReduce_1  74 happyReduction_121
happyReduction_121 (HappyAbsSyn93  happy_var_1)
	 =  HappyAbsSyn74
		 (reverse happy_var_1
	)
happyReduction_121 _  = notHappyAtAll 

happyReduce_122 = happySpecReduce_1  75 happyReduction_122
happyReduction_122 (HappyAbsSyn94  happy_var_1)
	 =  HappyAbsSyn75
		 (reverse happy_var_1
	)
happyReduction_122 _  = notHappyAtAll 

happyReduce_123 = happySpecReduce_1  76 happyReduction_123
happyReduction_123 (HappyAbsSyn95  happy_var_1)
	 =  HappyAbsSyn76
		 (reverse happy_var_1
	)
happyReduction_123 _  = notHappyAtAll 

happyReduce_124 = happySpecReduce_1  77 happyReduction_124
happyReduction_124 (HappyAbsSyn96  happy_var_1)
	 =  HappyAbsSyn77
		 (reverse happy_var_1
	)
happyReduction_124 _  = notHappyAtAll 

happyReduce_125 = happySpecReduce_1  78 happyReduction_125
happyReduction_125 (HappyAbsSyn97  happy_var_1)
	 =  HappyAbsSyn78
		 (reverse happy_var_1
	)
happyReduction_125 _  = notHappyAtAll 

happyReduce_126 = happySpecReduce_1  79 happyReduction_126
happyReduction_126 (HappyAbsSyn98  happy_var_1)
	 =  HappyAbsSyn79
		 (reverse happy_var_1
	)
happyReduction_126 _  = notHappyAtAll 

happyReduce_127 = happySpecReduce_1  80 happyReduction_127
happyReduction_127 (HappyAbsSyn99  happy_var_1)
	 =  HappyAbsSyn80
		 (reverse happy_var_1
	)
happyReduction_127 _  = notHappyAtAll 

happyReduce_128 = happySpecReduce_1  81 happyReduction_128
happyReduction_128 (HappyAbsSyn100  happy_var_1)
	 =  HappyAbsSyn81
		 (reverse happy_var_1
	)
happyReduction_128 _  = notHappyAtAll 

happyReduce_129 = happySpecReduce_1  82 happyReduction_129
happyReduction_129 (HappyAbsSyn101  happy_var_1)
	 =  HappyAbsSyn82
		 (reverse happy_var_1
	)
happyReduction_129 _  = notHappyAtAll 

happyReduce_130 = happySpecReduce_1  83 happyReduction_130
happyReduction_130 (HappyAbsSyn102  happy_var_1)
	 =  HappyAbsSyn83
		 (reverse happy_var_1
	)
happyReduction_130 _  = notHappyAtAll 

happyReduce_131 = happySpecReduce_1  84 happyReduction_131
happyReduction_131 (HappyAbsSyn103  happy_var_1)
	 =  HappyAbsSyn84
		 (reverse happy_var_1
	)
happyReduction_131 _  = notHappyAtAll 

happyReduce_132 = happySpecReduce_3  85 happyReduction_132
happyReduction_132 _
	(HappyAbsSyn30  happy_var_2)
	_
	 =  HappyAbsSyn85
		 (happy_var_2
	)
happyReduction_132 _ _ _  = notHappyAtAll 

happyReduce_133 = happySpecReduce_3  86 happyReduction_133
happyReduction_133 _
	(HappyAbsSyn25  happy_var_2)
	_
	 =  HappyAbsSyn86
		 (happy_var_2
	)
happyReduction_133 _ _ _  = notHappyAtAll 

happyReduce_134 = happySpecReduce_3  87 happyReduction_134
happyReduction_134 _
	(HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn87
		 (happy_var_2
	)
happyReduction_134 _ _ _  = notHappyAtAll 

happyReduce_135 = happySpecReduce_3  88 happyReduction_135
happyReduction_135 _
	(HappyAbsSyn62  happy_var_2)
	_
	 =  HappyAbsSyn88
		 (happy_var_2
	)
happyReduction_135 _ _ _  = notHappyAtAll 

happyReduce_136 = happySpecReduce_3  89 happyReduction_136
happyReduction_136 _
	(HappyAbsSyn7  happy_var_2)
	_
	 =  HappyAbsSyn89
		 (happy_var_2
	)
happyReduction_136 _ _ _  = notHappyAtAll 

happyReduce_137 = happySpecReduce_3  90 happyReduction_137
happyReduction_137 _
	(HappyAbsSyn17  happy_var_2)
	_
	 =  HappyAbsSyn90
		 (happy_var_2
	)
happyReduction_137 _ _ _  = notHappyAtAll 

happyReduce_138 = happySpecReduce_1  91 happyReduction_138
happyReduction_138 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn91
		 (happy_var_1 :| []
	)
happyReduction_138 _  = notHappyAtAll 

happyReduce_139 = happySpecReduce_2  91 happyReduction_139
happyReduction_139 (HappyAbsSyn30  happy_var_2)
	(HappyAbsSyn91  happy_var_1)
	 =  HappyAbsSyn91
		 (cons happy_var_2 happy_var_1
	)
happyReduction_139 _ _  = notHappyAtAll 

happyReduce_140 = happySpecReduce_1  92 happyReduction_140
happyReduction_140 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn92
		 (happy_var_1 :| []
	)
happyReduction_140 _  = notHappyAtAll 

happyReduce_141 = happySpecReduce_2  92 happyReduction_141
happyReduction_141 (HappyAbsSyn5  happy_var_2)
	(HappyAbsSyn92  happy_var_1)
	 =  HappyAbsSyn92
		 (cons happy_var_2 happy_var_1
	)
happyReduction_141 _ _  = notHappyAtAll 

happyReduce_142 = happySpecReduce_1  93 happyReduction_142
happyReduction_142 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn93
		 (happy_var_1 :| []
	)
happyReduction_142 _  = notHappyAtAll 

happyReduce_143 = happySpecReduce_2  93 happyReduction_143
happyReduction_143 (HappyAbsSyn7  happy_var_2)
	(HappyAbsSyn93  happy_var_1)
	 =  HappyAbsSyn93
		 (cons happy_var_2 happy_var_1
	)
happyReduction_143 _ _  = notHappyAtAll 

happyReduce_144 = happySpecReduce_1  94 happyReduction_144
happyReduction_144 (HappyAbsSyn27  happy_var_1)
	 =  HappyAbsSyn94
		 (happy_var_1 :| []
	)
happyReduction_144 _  = notHappyAtAll 

happyReduce_145 = happySpecReduce_3  94 happyReduction_145
happyReduction_145 (HappyAbsSyn27  happy_var_3)
	_
	(HappyAbsSyn94  happy_var_1)
	 =  HappyAbsSyn94
		 (cons happy_var_3 happy_var_1
	)
happyReduction_145 _ _ _  = notHappyAtAll 

happyReduce_146 = happySpecReduce_1  95 happyReduction_146
happyReduction_146 (HappyAbsSyn48  happy_var_1)
	 =  HappyAbsSyn95
		 (happy_var_1 :| []
	)
happyReduction_146 _  = notHappyAtAll 

happyReduce_147 = happySpecReduce_3  95 happyReduction_147
happyReduction_147 (HappyAbsSyn48  happy_var_3)
	_
	(HappyAbsSyn95  happy_var_1)
	 =  HappyAbsSyn95
		 (cons happy_var_3 happy_var_1
	)
happyReduction_147 _ _ _  = notHappyAtAll 

happyReduce_148 = happySpecReduce_1  96 happyReduction_148
happyReduction_148 (HappyAbsSyn53  happy_var_1)
	 =  HappyAbsSyn96
		 (happy_var_1 :| []
	)
happyReduction_148 _  = notHappyAtAll 

happyReduce_149 = happySpecReduce_3  96 happyReduction_149
happyReduction_149 (HappyAbsSyn53  happy_var_3)
	_
	(HappyAbsSyn96  happy_var_1)
	 =  HappyAbsSyn96
		 (cons happy_var_3 happy_var_1
	)
happyReduction_149 _ _ _  = notHappyAtAll 

happyReduce_150 = happySpecReduce_1  97 happyReduction_150
happyReduction_150 (HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn97
		 (happy_var_1 :| []
	)
happyReduction_150 _  = notHappyAtAll 

happyReduce_151 = happySpecReduce_3  97 happyReduction_151
happyReduction_151 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn97  happy_var_1)
	 =  HappyAbsSyn97
		 (cons happy_var_3 happy_var_1
	)
happyReduction_151 _ _ _  = notHappyAtAll 

happyReduce_152 = happySpecReduce_1  98 happyReduction_152
happyReduction_152 (HappyAbsSyn35  happy_var_1)
	 =  HappyAbsSyn98
		 (happy_var_1 :| []
	)
happyReduction_152 _  = notHappyAtAll 

happyReduce_153 = happySpecReduce_3  98 happyReduction_153
happyReduction_153 (HappyAbsSyn35  happy_var_3)
	_
	(HappyAbsSyn98  happy_var_1)
	 =  HappyAbsSyn98
		 (cons happy_var_3 happy_var_1
	)
happyReduction_153 _ _ _  = notHappyAtAll 

happyReduce_154 = happySpecReduce_1  99 happyReduction_154
happyReduction_154 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn99
		 (happy_var_1 :| []
	)
happyReduction_154 _  = notHappyAtAll 

happyReduce_155 = happySpecReduce_3  99 happyReduction_155
happyReduction_155 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn99  happy_var_1)
	 =  HappyAbsSyn99
		 (cons happy_var_3 happy_var_1
	)
happyReduction_155 _ _ _  = notHappyAtAll 

happyReduce_156 = happySpecReduce_1  100 happyReduction_156
happyReduction_156 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn100
		 (happy_var_1 :| []
	)
happyReduction_156 _  = notHappyAtAll 

happyReduce_157 = happySpecReduce_3  100 happyReduction_157
happyReduction_157 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn100  happy_var_1)
	 =  HappyAbsSyn100
		 (cons happy_var_3 happy_var_1
	)
happyReduction_157 _ _ _  = notHappyAtAll 

happyReduce_158 = happySpecReduce_1  101 happyReduction_158
happyReduction_158 (HappyAbsSyn59  happy_var_1)
	 =  HappyAbsSyn101
		 (happy_var_1 :| []
	)
happyReduction_158 _  = notHappyAtAll 

happyReduce_159 = happySpecReduce_3  101 happyReduction_159
happyReduction_159 (HappyAbsSyn59  happy_var_3)
	_
	(HappyAbsSyn101  happy_var_1)
	 =  HappyAbsSyn101
		 (cons happy_var_3 happy_var_1
	)
happyReduction_159 _ _ _  = notHappyAtAll 

happyReduce_160 = happySpecReduce_1  102 happyReduction_160
happyReduction_160 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn102
		 (happy_var_1 :| []
	)
happyReduction_160 _  = notHappyAtAll 

happyReduce_161 = happySpecReduce_3  102 happyReduction_161
happyReduction_161 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn102  happy_var_1)
	 =  HappyAbsSyn102
		 (cons happy_var_3 happy_var_1
	)
happyReduction_161 _ _ _  = notHappyAtAll 

happyReduce_162 = happySpecReduce_1  103 happyReduction_162
happyReduction_162 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn103
		 (happy_var_1 :| []
	)
happyReduction_162 _  = notHappyAtAll 

happyReduce_163 = happySpecReduce_3  103 happyReduction_163
happyReduction_163 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn103  happy_var_1)
	 =  HappyAbsSyn103
		 (cons happy_var_3 happy_var_1
	)
happyReduction_163 _ _ _  = notHappyAtAll 

happyNewToken action sts stk
	= monadicLexer(\tk -> 
	let cont i = action i i tk (HappyState action) sts stk in
	case tk of {
	EOF -> action 139 139 tk (HappyState action) sts stk;
	TokenVariable _ happy_dollar_dollar -> cont 104;
	Hole happy_dollar_dollar -> cont 105;
	LiteralUint _ _ -> cont 106;
	LeftParen happy_dollar_dollar -> cont 107;
	RightParen happy_dollar_dollar -> cont 108;
	LeftBrace happy_dollar_dollar -> cont 109;
	RightBrace happy_dollar_dollar -> cont 110;
	Colon happy_dollar_dollar -> cont 111;
	Comma happy_dollar_dollar -> cont 112;
	BackTick happy_dollar_dollar -> cont 113;
	LayoutStart happy_dollar_dollar -> cont 114;
	LayoutSeparator happy_dollar_dollar -> cont 115;
	LayoutEnd happy_dollar_dollar -> cont 116;
	RightArrow happy_dollar_dollar -> cont 117;
	TokenOperator _ _ -> cont 118;
	Forall happy_dollar_dollar -> cont 119;
	Dot happy_dollar_dollar -> cont 120;
	Data happy_dollar_dollar -> cont 121;
	Equal happy_dollar_dollar -> cont 122;
	At happy_dollar_dollar -> cont 123;
	Case happy_dollar_dollar -> cont 124;
	Of happy_dollar_dollar -> cont 125;
	LambdaStart happy_dollar_dollar -> cont 126;
	Let happy_dollar_dollar -> cont 127;
	In happy_dollar_dollar -> cont 128;
	OperatorKeyword happy_dollar_dollar -> cont 129;
	Type happy_dollar_dollar -> cont 130;
	Term happy_dollar_dollar -> cont 131;
	Left_ happy_dollar_dollar -> cont 132;
	Right_ happy_dollar_dollar -> cont 133;
	None happy_dollar_dollar -> cont 134;
	Pipe happy_dollar_dollar -> cont 135;
	As happy_dollar_dollar -> cont 136;
	Unqualified happy_dollar_dollar -> cont 137;
	Import happy_dollar_dollar -> cont 138;
	_ -> happyError' (tk, [])
	})

happyError_ explist 139 tk = happyError' (tk, explist)
happyError_ explist _ tk = happyError' (tk, explist)

happyThen :: () => ParserMonad a -> (a -> ParserMonad b) -> ParserMonad b
happyThen = (Prelude.>>=)
happyReturn :: () => a -> ParserMonad a
happyReturn = (Prelude.return)
happyThen1 :: () => ParserMonad a -> (a -> ParserMonad b) -> ParserMonad b
happyThen1 = happyThen
happyReturn1 :: () => a -> ParserMonad a
happyReturn1 = happyReturn
happyError' :: () => ((Token), [Prelude.String]) -> ParserMonad a
happyError' tk = parseError tk
parse = happySomeParser where
 happySomeParser = happyThen (happyParse action_0) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


-- parseError :: ([Token],[String]) -> a
parseError (tok,pos) = error ("Parse error, expected:  " <> show pos)
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- $Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp $










































data Happy_IntList = HappyCons Prelude.Int Happy_IntList








































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is ERROR_TOK, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action









































indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x Prelude.< y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `Prelude.div` 16)) (bit `Prelude.mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Prelude.Int ->                    -- token number
         Prelude.Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k Prelude.- ((1) :: Prelude.Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Prelude.Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n Prelude.- ((1) :: Prelude.Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n Prelude.- ((1)::Prelude.Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery (ERROR_TOK is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  ERROR_TOK tk old_st CONS(HAPPYSTATE(action),sts) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        DO_ACTION(action,ERROR_TOK,tk,sts,(saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ((HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = Prelude.error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `Prelude.seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
