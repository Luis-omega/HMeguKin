{-# OPTIONS_GHC -w #-}
module HMeguKin.Parser.Parser(parse) where

import Data.List.NonEmpty(NonEmpty((:|)),cons,reverse,toList,uncons,singleton)
import Data.List qualified as List
import Prelude hiding(reverse)

import HMeguKin.Parser.Types(Token(..),Range) 
import HMeguKin.Parser.Types qualified as Types
import HMeguKin.Parser.SST hiding (LiteralUint,Case,Let)
import HMeguKin.Parser.SST qualified as SST
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.20.1.1

data HappyAbsSyn t62 t63 t64 t65 t66 t67 t68 t69 t70 t71 t72 t73 t74 t75 t76 t77 t78 t79 t80 t81 t82 t83 t84 t85 t86 t87 t88 t89 t90
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
	| HappyAbsSyn59 (OperatorFixity)
	| HappyAbsSyn60 (OperatorKind)
	| HappyAbsSyn62 t62
	| HappyAbsSyn63 t63
	| HappyAbsSyn64 t64
	| HappyAbsSyn65 t65
	| HappyAbsSyn66 t66
	| HappyAbsSyn67 t67
	| HappyAbsSyn68 t68
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

happyExpList :: Happy_Data_Array.Array Prelude.Int Prelude.Int
happyExpList = Happy_Data_Array.listArray (0,1214) ([0,0,0,0,0,15360,2048,8,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,256,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,15,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,30,0,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,0,6,0,0,0,0,0,0,32,0,0,0,0,0,0,18,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,49152,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,0,0,0,0,0,0,0,512,0,0,0,0,0,0,15360,0,0,0,0,0,0,0,32,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,64,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,164,2,0,0,0,0,0,57344,5,27,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,8202,0,0,0,0,0,0,0,0,224,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,164,0,0,0,0,0,0,0,2112,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,20,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,57344,5,1,0,0,0,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,0,49152,4235,54,0,0,0,0,0,33280,0,0,0,0,0,0,0,656,0,0,0,0,0,0,32768,535,108,0,0,0,0,0,15360,0,0,0,0,0,0,0,33248,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,18432,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,4,0,0,0,0,0,480,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,512,0,0,0,0,0,0,0,0,2,0,0,0,0,0,6016,27648,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32784,0,0,0,0,0,0,0,0,0,0,0,0,0,0,512,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,256,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,376,64,0,0,0,0,0,16384,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,16,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,0,0,36864,2,0,0,0,0,0,0,5248,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10496,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,512,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,20,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1312,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,164,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,16384,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,23,108,0,0,0,0,0,48128,24576,3,0,0,0,0,0,0,2,0,0,0,0,0,0,1039,0,0,0,0,0,0,30720,0,0,0,0,0,0,0,3008,13824,0,0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,57344,133,27,0,0,0,0,0,12032,55296,0,0,0,0,0,0,328,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,48128,24576,3,0,0,0,0,0,480,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1920,0,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,61440,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,376,1728,0,0,0,0,0,49152,267,54,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1504,6912,0,0,0,0,0,0,0,0,0,0,0,0,0,30720,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,61440,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,512,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","module_statement","meta_variable","meta_operator","pattern_match_variable","pattern_match_hole","pattern_match_literal","pattern_annotation","pattern_match_atom","pattern_as","pattern_match_application","pattern_match","type_record_item","type_record_inner","type_record","type_variable","type_atom","type_application","type_operators_plus","type_operators","type_expression_inner","type_scheme","type_data_type_args","type_expression_inner_sep_comma","data_type_constructor","data_type_constructor_plus","data_type","expression_literal","expression_variable","expression_record_item","expression_record_inner","expression_record","expression_record_update_item","expression_record_update_inner","expression_record_update","expression_operator_parens","expression_annotation","expression_type_arg","expression_atom","expression_accessor_field","expression_accessor_funtion","expression_accessor","expression_application","expression_operators_plus","expression_operators","expression_case_single","expression_case_cases","expression_case","expression_lambda_arguments","expression_lambda","expression_let_binding","expression_let_inside","expression_let","expression","variable_declaration","pattern_declaration","fixity","precedence","operator_fixity","braces__expression_record_inner__","braces__expression_record_update_inner__","braces__type_record_inner__","list1__expression_accessor__","list1__meta_variable__","list1__pattern_as__","listSepBy1__data_type_constructor__Pipe__","listSepBy1__expression_case_single__LayoutSeparator__","listSepBy1__expression_let_binding__LayoutSeparator__","listSepBy1__expression_record_item__Comma__","listSepBy1__expression_record_update_item__Comma__","listSepBy1__meta_variable__Dot__","listSepBy1__pattern_match__Comma__","listSepBy1__type_record_item__Comma__","parens__expression_annotation__","parens__meta_operator__","parens__pattern_match__","parens__type_expression_inner__","plus__expression_accessor__","plus__meta_variable__","plus__pattern_as__","sepBy1__data_type_constructor__Pipe__","sepBy1__expression_case_single__LayoutSeparator__","sepBy1__expression_let_binding__LayoutSeparator__","sepBy1__expression_record_item__Comma__","sepBy1__expression_record_update_item__Comma__","sepBy1__meta_variable__Dot__","sepBy1__pattern_match__Comma__","sepBy1__type_record_item__Comma__","Variable","Hole","UInt","LParen","RParen","LBrace","RBrace","Colon","Comma","BackTick","LayoutStart","LayoutSeparator","LayoutEnd","RightArrow","TokenOperator","Forall","Dot","Data","Equal","At","Case","Of","Lambda","Let","In","OperatorKeyword","Type","Term","Left_","Right_","None","Pipe","%eof"]
        bit_start = st Prelude.* 123
        bit_end = (st Prelude.+ 1) Prelude.* 123
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..122]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

action_0 (91) = happyShift action_18
action_0 (92) = happyShift action_19
action_0 (93) = happyShift action_20
action_0 (94) = happyShift action_21
action_0 (108) = happyShift action_3
action_0 (116) = happyShift action_22
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
action_0 (57) = happyGoto action_14
action_0 (58) = happyGoto action_15
action_0 (61) = happyGoto action_16
action_0 (78) = happyGoto action_17
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (108) = happyShift action_3
action_1 (29) = happyGoto action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyReduce_1

action_3 (91) = happyShift action_29
action_3 (5) = happyGoto action_33
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (123) = happyAccept
action_4 _ = happyFail (happyExpListPerState 4)

action_5 (98) = happyShift action_31
action_5 (110) = happyShift action_32
action_5 _ = happyReduce_8

action_6 _ = happyReduce_13

action_7 _ = happyReduce_14

action_8 _ = happyReduce_12

action_9 _ = happyReduce_16

action_10 _ = happyReduce_18

action_11 _ = happyReduce_20

action_12 _ = happyReduce_21

action_13 (109) = happyShift action_30
action_13 _ = happyFail (happyExpListPerState 13)

action_14 _ = happyReduce_2

action_15 _ = happyReduce_3

action_16 _ = happyReduce_4

action_17 _ = happyReduce_15

action_18 (91) = happyShift action_29
action_18 (92) = happyShift action_19
action_18 (93) = happyShift action_20
action_18 (94) = happyShift action_21
action_18 (5) = happyGoto action_24
action_18 (7) = happyGoto action_6
action_18 (8) = happyGoto action_7
action_18 (9) = happyGoto action_8
action_18 (10) = happyGoto action_9
action_18 (11) = happyGoto action_10
action_18 (12) = happyGoto action_26
action_18 (67) = happyGoto action_27
action_18 (78) = happyGoto action_17
action_18 (82) = happyGoto action_28
action_18 _ = happyReduce_5

action_19 _ = happyReduce_9

action_20 _ = happyReduce_10

action_21 (91) = happyShift action_18
action_21 (92) = happyShift action_19
action_21 (93) = happyShift action_20
action_21 (94) = happyShift action_21
action_21 (5) = happyGoto action_24
action_21 (7) = happyGoto action_6
action_21 (8) = happyGoto action_7
action_21 (9) = happyGoto action_8
action_21 (10) = happyGoto action_9
action_21 (11) = happyGoto action_10
action_21 (12) = happyGoto action_11
action_21 (13) = happyGoto action_12
action_21 (14) = happyGoto action_25
action_21 (78) = happyGoto action_17
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (105) = happyShift action_23
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (117) = happyShift action_46
action_23 (118) = happyShift action_47
action_23 (59) = happyGoto action_45
action_23 _ = happyFail (happyExpListPerState 23)

action_24 (110) = happyShift action_32
action_24 _ = happyReduce_8

action_25 (95) = happyShift action_43
action_25 (98) = happyShift action_44
action_25 _ = happyFail (happyExpListPerState 25)

action_26 _ = happyReduce_125

action_27 _ = happyReduce_19

action_28 (91) = happyShift action_29
action_28 (92) = happyShift action_19
action_28 (93) = happyShift action_20
action_28 (94) = happyShift action_21
action_28 (5) = happyGoto action_24
action_28 (7) = happyGoto action_6
action_28 (8) = happyGoto action_7
action_28 (9) = happyGoto action_8
action_28 (10) = happyGoto action_9
action_28 (11) = happyGoto action_10
action_28 (12) = happyGoto action_42
action_28 (78) = happyGoto action_17
action_28 _ = happyReduce_108

action_29 _ = happyReduce_5

action_30 (101) = happyShift action_41
action_30 _ = happyFail (happyExpListPerState 30)

action_31 (101) = happyShift action_40
action_31 _ = happyFail (happyExpListPerState 31)

action_32 (91) = happyShift action_29
action_32 (92) = happyShift action_19
action_32 (93) = happyShift action_20
action_32 (94) = happyShift action_21
action_32 (5) = happyGoto action_38
action_32 (7) = happyGoto action_6
action_32 (8) = happyGoto action_7
action_32 (9) = happyGoto action_8
action_32 (10) = happyGoto action_9
action_32 (11) = happyGoto action_39
action_32 (78) = happyGoto action_17
action_32 _ = happyFail (happyExpListPerState 32)

action_33 (91) = happyShift action_29
action_33 (109) = happyShift action_37
action_33 (5) = happyGoto action_34
action_33 (66) = happyGoto action_35
action_33 (81) = happyGoto action_36
action_33 _ = happyFail (happyExpListPerState 33)

action_34 _ = happyReduce_123

action_35 (109) = happyShift action_105
action_35 _ = happyFail (happyExpListPerState 35)

action_36 (91) = happyShift action_29
action_36 (5) = happyGoto action_104
action_36 _ = happyReduce_107

action_37 (91) = happyShift action_29
action_37 (5) = happyGoto action_99
action_37 (27) = happyGoto action_100
action_37 (28) = happyGoto action_101
action_37 (68) = happyGoto action_102
action_37 (83) = happyGoto action_103
action_37 _ = happyFail (happyExpListPerState 37)

action_38 _ = happyReduce_8

action_39 _ = happyReduce_17

action_40 (91) = happyShift action_29
action_40 (94) = happyShift action_63
action_40 (96) = happyShift action_64
action_40 (106) = happyShift action_65
action_40 (5) = happyGoto action_52
action_40 (17) = happyGoto action_53
action_40 (18) = happyGoto action_54
action_40 (19) = happyGoto action_55
action_40 (20) = happyGoto action_56
action_40 (21) = happyGoto action_57
action_40 (22) = happyGoto action_58
action_40 (23) = happyGoto action_59
action_40 (24) = happyGoto action_98
action_40 (64) = happyGoto action_61
action_40 (79) = happyGoto action_62
action_40 _ = happyFail (happyExpListPerState 40)

action_41 (91) = happyShift action_29
action_41 (92) = happyShift action_90
action_41 (93) = happyShift action_91
action_41 (94) = happyShift action_92
action_41 (96) = happyShift action_93
action_41 (110) = happyShift action_94
action_41 (111) = happyShift action_95
action_41 (113) = happyShift action_96
action_41 (114) = happyShift action_97
action_41 (5) = happyGoto action_66
action_41 (30) = happyGoto action_67
action_41 (31) = happyGoto action_68
action_41 (34) = happyGoto action_69
action_41 (37) = happyGoto action_70
action_41 (38) = happyGoto action_71
action_41 (40) = happyGoto action_72
action_41 (41) = happyGoto action_73
action_41 (42) = happyGoto action_74
action_41 (43) = happyGoto action_75
action_41 (44) = happyGoto action_76
action_41 (45) = happyGoto action_77
action_41 (46) = happyGoto action_78
action_41 (47) = happyGoto action_79
action_41 (50) = happyGoto action_80
action_41 (52) = happyGoto action_81
action_41 (55) = happyGoto action_82
action_41 (56) = happyGoto action_83
action_41 (62) = happyGoto action_84
action_41 (63) = happyGoto action_85
action_41 (65) = happyGoto action_86
action_41 (76) = happyGoto action_87
action_41 (77) = happyGoto action_88
action_41 (80) = happyGoto action_89
action_41 _ = happyFail (happyExpListPerState 41)

action_42 _ = happyReduce_126

action_43 _ = happyReduce_119

action_44 (91) = happyShift action_29
action_44 (94) = happyShift action_63
action_44 (96) = happyShift action_64
action_44 (106) = happyShift action_65
action_44 (5) = happyGoto action_52
action_44 (17) = happyGoto action_53
action_44 (18) = happyGoto action_54
action_44 (19) = happyGoto action_55
action_44 (20) = happyGoto action_56
action_44 (21) = happyGoto action_57
action_44 (22) = happyGoto action_58
action_44 (23) = happyGoto action_59
action_44 (24) = happyGoto action_60
action_44 (64) = happyGoto action_61
action_44 (79) = happyGoto action_62
action_44 _ = happyFail (happyExpListPerState 44)

action_45 (119) = happyShift action_49
action_45 (120) = happyShift action_50
action_45 (121) = happyShift action_51
action_45 (60) = happyGoto action_48
action_45 _ = happyFail (happyExpListPerState 45)

action_46 _ = happyReduce_97

action_47 _ = happyReduce_98

action_48 (93) = happyShift action_153
action_48 _ = happyFail (happyExpListPerState 48)

action_49 _ = happyReduce_99

action_50 _ = happyReduce_100

action_51 _ = happyReduce_101

action_52 _ = happyReduce_25

action_53 _ = happyReduce_28

action_54 _ = happyReduce_26

action_55 _ = happyReduce_29

action_56 (91) = happyShift action_29
action_56 (94) = happyShift action_63
action_56 (96) = happyShift action_64
action_56 (5) = happyGoto action_52
action_56 (17) = happyGoto action_53
action_56 (18) = happyGoto action_54
action_56 (19) = happyGoto action_152
action_56 (64) = happyGoto action_61
action_56 (79) = happyGoto action_62
action_56 _ = happyReduce_31

action_57 (100) = happyShift action_134
action_57 (105) = happyShift action_135
action_57 (6) = happyGoto action_151
action_57 _ = happyReduce_33

action_58 (104) = happyShift action_150
action_58 _ = happyReduce_34

action_59 _ = happyReduce_36

action_60 (95) = happyShift action_149
action_60 _ = happyFail (happyExpListPerState 60)

action_61 _ = happyReduce_24

action_62 _ = happyReduce_27

action_63 (91) = happyShift action_29
action_63 (94) = happyShift action_63
action_63 (96) = happyShift action_64
action_63 (5) = happyGoto action_52
action_63 (17) = happyGoto action_53
action_63 (18) = happyGoto action_54
action_63 (19) = happyGoto action_55
action_63 (20) = happyGoto action_56
action_63 (21) = happyGoto action_57
action_63 (22) = happyGoto action_58
action_63 (23) = happyGoto action_148
action_63 (64) = happyGoto action_61
action_63 (79) = happyGoto action_62
action_63 _ = happyFail (happyExpListPerState 63)

action_64 (91) = happyShift action_29
action_64 (5) = happyGoto action_143
action_64 (15) = happyGoto action_144
action_64 (16) = happyGoto action_145
action_64 (75) = happyGoto action_146
action_64 (90) = happyGoto action_147
action_64 _ = happyFail (happyExpListPerState 64)

action_65 (91) = happyShift action_29
action_65 (5) = happyGoto action_141
action_65 (25) = happyGoto action_142
action_65 _ = happyFail (happyExpListPerState 65)

action_66 _ = happyReduce_48

action_67 _ = happyReduce_62

action_68 _ = happyReduce_61

action_69 _ = happyReduce_63

action_70 _ = happyReduce_64

action_71 _ = happyReduce_65

action_72 _ = happyReduce_66

action_73 (107) = happyShift action_140
action_73 _ = happyReduce_72

action_74 _ = happyReduce_70

action_75 _ = happyReduce_71

action_76 _ = happyReduce_121

action_77 _ = happyReduce_74

action_78 (100) = happyShift action_134
action_78 (105) = happyShift action_135
action_78 (6) = happyGoto action_139
action_78 _ = happyReduce_76

action_79 _ = happyReduce_83

action_80 _ = happyReduce_86

action_81 _ = happyReduce_93

action_82 _ = happyReduce_94

action_83 (103) = happyShift action_138
action_83 _ = happyFail (happyExpListPerState 83)

action_84 _ = happyReduce_52

action_85 _ = happyReduce_56

action_86 _ = happyReduce_73

action_87 _ = happyReduce_67

action_88 _ = happyReduce_57

action_89 (91) = happyShift action_29
action_89 (92) = happyShift action_90
action_89 (93) = happyShift action_91
action_89 (94) = happyShift action_92
action_89 (96) = happyShift action_93
action_89 (110) = happyShift action_94
action_89 (5) = happyGoto action_66
action_89 (30) = happyGoto action_67
action_89 (31) = happyGoto action_68
action_89 (34) = happyGoto action_69
action_89 (37) = happyGoto action_70
action_89 (38) = happyGoto action_71
action_89 (40) = happyGoto action_72
action_89 (41) = happyGoto action_73
action_89 (42) = happyGoto action_74
action_89 (43) = happyGoto action_75
action_89 (44) = happyGoto action_137
action_89 (62) = happyGoto action_84
action_89 (63) = happyGoto action_85
action_89 (76) = happyGoto action_87
action_89 (77) = happyGoto action_88
action_89 _ = happyReduce_106

action_90 (107) = happyShift action_136
action_90 _ = happyFail (happyExpListPerState 90)

action_91 _ = happyReduce_47

action_92 (91) = happyShift action_29
action_92 (92) = happyShift action_90
action_92 (93) = happyShift action_91
action_92 (94) = happyShift action_92
action_92 (96) = happyShift action_93
action_92 (100) = happyShift action_134
action_92 (105) = happyShift action_135
action_92 (110) = happyShift action_94
action_92 (111) = happyShift action_95
action_92 (113) = happyShift action_96
action_92 (114) = happyShift action_97
action_92 (5) = happyGoto action_66
action_92 (6) = happyGoto action_131
action_92 (30) = happyGoto action_67
action_92 (31) = happyGoto action_68
action_92 (34) = happyGoto action_69
action_92 (37) = happyGoto action_70
action_92 (38) = happyGoto action_71
action_92 (39) = happyGoto action_132
action_92 (40) = happyGoto action_72
action_92 (41) = happyGoto action_73
action_92 (42) = happyGoto action_74
action_92 (43) = happyGoto action_75
action_92 (44) = happyGoto action_76
action_92 (45) = happyGoto action_77
action_92 (46) = happyGoto action_78
action_92 (47) = happyGoto action_79
action_92 (50) = happyGoto action_80
action_92 (52) = happyGoto action_81
action_92 (55) = happyGoto action_82
action_92 (56) = happyGoto action_133
action_92 (62) = happyGoto action_84
action_92 (63) = happyGoto action_85
action_92 (65) = happyGoto action_86
action_92 (76) = happyGoto action_87
action_92 (77) = happyGoto action_88
action_92 (80) = happyGoto action_89
action_92 _ = happyFail (happyExpListPerState 92)

action_93 (91) = happyShift action_29
action_93 (97) = happyShift action_130
action_93 (5) = happyGoto action_121
action_93 (32) = happyGoto action_122
action_93 (33) = happyGoto action_123
action_93 (35) = happyGoto action_124
action_93 (36) = happyGoto action_125
action_93 (71) = happyGoto action_126
action_93 (72) = happyGoto action_127
action_93 (86) = happyGoto action_128
action_93 (87) = happyGoto action_129
action_93 _ = happyFail (happyExpListPerState 93)

action_94 (91) = happyShift action_29
action_94 (94) = happyShift action_63
action_94 (96) = happyShift action_64
action_94 (5) = happyGoto action_52
action_94 (17) = happyGoto action_53
action_94 (18) = happyGoto action_54
action_94 (19) = happyGoto action_120
action_94 (64) = happyGoto action_61
action_94 (79) = happyGoto action_62
action_94 _ = happyFail (happyExpListPerState 94)

action_95 (91) = happyShift action_29
action_95 (92) = happyShift action_90
action_95 (93) = happyShift action_91
action_95 (94) = happyShift action_92
action_95 (96) = happyShift action_93
action_95 (101) = happyShift action_119
action_95 (110) = happyShift action_94
action_95 (111) = happyShift action_95
action_95 (113) = happyShift action_96
action_95 (114) = happyShift action_97
action_95 (5) = happyGoto action_66
action_95 (30) = happyGoto action_67
action_95 (31) = happyGoto action_68
action_95 (34) = happyGoto action_69
action_95 (37) = happyGoto action_70
action_95 (38) = happyGoto action_71
action_95 (40) = happyGoto action_72
action_95 (41) = happyGoto action_73
action_95 (42) = happyGoto action_74
action_95 (43) = happyGoto action_75
action_95 (44) = happyGoto action_76
action_95 (45) = happyGoto action_77
action_95 (46) = happyGoto action_78
action_95 (47) = happyGoto action_79
action_95 (50) = happyGoto action_80
action_95 (52) = happyGoto action_81
action_95 (55) = happyGoto action_82
action_95 (56) = happyGoto action_118
action_95 (62) = happyGoto action_84
action_95 (63) = happyGoto action_85
action_95 (65) = happyGoto action_86
action_95 (76) = happyGoto action_87
action_95 (77) = happyGoto action_88
action_95 (80) = happyGoto action_89
action_95 _ = happyFail (happyExpListPerState 95)

action_96 (91) = happyShift action_18
action_96 (92) = happyShift action_19
action_96 (93) = happyShift action_20
action_96 (94) = happyShift action_21
action_96 (5) = happyGoto action_24
action_96 (7) = happyGoto action_6
action_96 (8) = happyGoto action_7
action_96 (9) = happyGoto action_8
action_96 (10) = happyGoto action_9
action_96 (11) = happyGoto action_10
action_96 (12) = happyGoto action_11
action_96 (13) = happyGoto action_12
action_96 (14) = happyGoto action_114
action_96 (51) = happyGoto action_115
action_96 (74) = happyGoto action_116
action_96 (78) = happyGoto action_17
action_96 (89) = happyGoto action_117
action_96 _ = happyFail (happyExpListPerState 96)

action_97 (91) = happyShift action_18
action_97 (92) = happyShift action_19
action_97 (93) = happyShift action_20
action_97 (94) = happyShift action_21
action_97 (101) = happyShift action_113
action_97 (5) = happyGoto action_24
action_97 (7) = happyGoto action_6
action_97 (8) = happyGoto action_7
action_97 (9) = happyGoto action_8
action_97 (10) = happyGoto action_9
action_97 (11) = happyGoto action_10
action_97 (12) = happyGoto action_11
action_97 (13) = happyGoto action_12
action_97 (14) = happyGoto action_111
action_97 (53) = happyGoto action_112
action_97 (78) = happyGoto action_17
action_97 _ = happyFail (happyExpListPerState 97)

action_98 (103) = happyShift action_110
action_98 _ = happyFail (happyExpListPerState 98)

action_99 (91) = happyShift action_29
action_99 (94) = happyShift action_63
action_99 (96) = happyShift action_64
action_99 (5) = happyGoto action_52
action_99 (17) = happyGoto action_53
action_99 (18) = happyGoto action_54
action_99 (19) = happyGoto action_55
action_99 (20) = happyGoto action_56
action_99 (21) = happyGoto action_57
action_99 (22) = happyGoto action_58
action_99 (23) = happyGoto action_108
action_99 (26) = happyGoto action_109
action_99 (64) = happyGoto action_61
action_99 (79) = happyGoto action_62
action_99 _ = happyReduce_42

action_100 _ = happyReduce_127

action_101 _ = happyReduce_46

action_102 _ = happyReduce_44

action_103 (122) = happyShift action_107
action_103 _ = happyReduce_109

action_104 _ = happyReduce_124

action_105 (91) = happyShift action_29
action_105 (5) = happyGoto action_99
action_105 (27) = happyGoto action_100
action_105 (28) = happyGoto action_106
action_105 (68) = happyGoto action_102
action_105 (83) = happyGoto action_103
action_105 _ = happyFail (happyExpListPerState 105)

action_106 _ = happyReduce_45

action_107 (91) = happyShift action_29
action_107 (5) = happyGoto action_99
action_107 (27) = happyGoto action_188
action_107 _ = happyFail (happyExpListPerState 107)

action_108 _ = happyReduce_40

action_109 (99) = happyShift action_187
action_109 _ = happyReduce_43

action_110 _ = happyReduce_95

action_111 (109) = happyShift action_186
action_111 _ = happyFail (happyExpListPerState 111)

action_112 (115) = happyShift action_185
action_112 _ = happyFail (happyExpListPerState 112)

action_113 (91) = happyShift action_18
action_113 (92) = happyShift action_19
action_113 (93) = happyShift action_20
action_113 (94) = happyShift action_21
action_113 (5) = happyGoto action_24
action_113 (7) = happyGoto action_6
action_113 (8) = happyGoto action_7
action_113 (9) = happyGoto action_8
action_113 (10) = happyGoto action_9
action_113 (11) = happyGoto action_10
action_113 (12) = happyGoto action_11
action_113 (13) = happyGoto action_12
action_113 (14) = happyGoto action_111
action_113 (53) = happyGoto action_181
action_113 (54) = happyGoto action_182
action_113 (70) = happyGoto action_183
action_113 (78) = happyGoto action_17
action_113 (85) = happyGoto action_184
action_113 _ = happyFail (happyExpListPerState 113)

action_114 _ = happyReduce_139

action_115 (104) = happyShift action_180
action_115 _ = happyFail (happyExpListPerState 115)

action_116 _ = happyReduce_84

action_117 (99) = happyShift action_179
action_117 _ = happyReduce_115

action_118 (112) = happyShift action_178
action_118 _ = happyFail (happyExpListPerState 118)

action_119 (91) = happyShift action_29
action_119 (92) = happyShift action_90
action_119 (93) = happyShift action_91
action_119 (94) = happyShift action_92
action_119 (96) = happyShift action_93
action_119 (110) = happyShift action_94
action_119 (111) = happyShift action_95
action_119 (113) = happyShift action_96
action_119 (114) = happyShift action_97
action_119 (5) = happyGoto action_66
action_119 (30) = happyGoto action_67
action_119 (31) = happyGoto action_68
action_119 (34) = happyGoto action_69
action_119 (37) = happyGoto action_70
action_119 (38) = happyGoto action_71
action_119 (40) = happyGoto action_72
action_119 (41) = happyGoto action_73
action_119 (42) = happyGoto action_74
action_119 (43) = happyGoto action_75
action_119 (44) = happyGoto action_76
action_119 (45) = happyGoto action_77
action_119 (46) = happyGoto action_78
action_119 (47) = happyGoto action_79
action_119 (50) = happyGoto action_80
action_119 (52) = happyGoto action_81
action_119 (55) = happyGoto action_82
action_119 (56) = happyGoto action_177
action_119 (62) = happyGoto action_84
action_119 (63) = happyGoto action_85
action_119 (65) = happyGoto action_86
action_119 (76) = happyGoto action_87
action_119 (77) = happyGoto action_88
action_119 (80) = happyGoto action_89
action_119 _ = happyFail (happyExpListPerState 119)

action_120 _ = happyReduce_60

action_121 (98) = happyShift action_175
action_121 (109) = happyShift action_176
action_121 _ = happyReduce_50

action_122 _ = happyReduce_133

action_123 (97) = happyShift action_174
action_123 _ = happyFail (happyExpListPerState 123)

action_124 _ = happyReduce_135

action_125 (97) = happyShift action_173
action_125 _ = happyFail (happyExpListPerState 125)

action_126 _ = happyReduce_51

action_127 _ = happyReduce_55

action_128 (99) = happyShift action_172
action_128 _ = happyReduce_112

action_129 (99) = happyShift action_171
action_129 _ = happyReduce_113

action_130 _ = happyReduce_53

action_131 (95) = happyShift action_170
action_131 _ = happyFail (happyExpListPerState 131)

action_132 (95) = happyShift action_169
action_132 _ = happyFail (happyExpListPerState 132)

action_133 (98) = happyShift action_168
action_133 _ = happyReduce_58

action_134 (91) = happyShift action_167
action_134 _ = happyFail (happyExpListPerState 134)

action_135 _ = happyReduce_6

action_136 (91) = happyShift action_29
action_136 (5) = happyGoto action_166
action_136 _ = happyFail (happyExpListPerState 136)

action_137 _ = happyReduce_122

action_138 _ = happyReduce_96

action_139 (91) = happyShift action_29
action_139 (92) = happyShift action_90
action_139 (93) = happyShift action_91
action_139 (94) = happyShift action_92
action_139 (96) = happyShift action_93
action_139 (110) = happyShift action_94
action_139 (5) = happyGoto action_66
action_139 (30) = happyGoto action_67
action_139 (31) = happyGoto action_68
action_139 (34) = happyGoto action_69
action_139 (37) = happyGoto action_70
action_139 (38) = happyGoto action_71
action_139 (40) = happyGoto action_72
action_139 (41) = happyGoto action_73
action_139 (42) = happyGoto action_74
action_139 (43) = happyGoto action_75
action_139 (44) = happyGoto action_76
action_139 (45) = happyGoto action_165
action_139 (62) = happyGoto action_84
action_139 (63) = happyGoto action_85
action_139 (65) = happyGoto action_86
action_139 (76) = happyGoto action_87
action_139 (77) = happyGoto action_88
action_139 (80) = happyGoto action_89
action_139 _ = happyFail (happyExpListPerState 139)

action_140 (91) = happyShift action_29
action_140 (5) = happyGoto action_162
action_140 (73) = happyGoto action_163
action_140 (88) = happyGoto action_164
action_140 _ = happyFail (happyExpListPerState 140)

action_141 _ = happyReduce_38

action_142 (91) = happyShift action_29
action_142 (107) = happyShift action_161
action_142 (5) = happyGoto action_160
action_142 _ = happyFail (happyExpListPerState 142)

action_143 (98) = happyShift action_159
action_143 _ = happyFail (happyExpListPerState 143)

action_144 _ = happyReduce_141

action_145 (97) = happyShift action_158
action_145 _ = happyFail (happyExpListPerState 145)

action_146 _ = happyReduce_23

action_147 (99) = happyShift action_157
action_147 _ = happyReduce_116

action_148 (95) = happyShift action_156
action_148 _ = happyFail (happyExpListPerState 148)

action_149 _ = happyReduce_11

action_150 (91) = happyShift action_29
action_150 (94) = happyShift action_63
action_150 (96) = happyShift action_64
action_150 (5) = happyGoto action_52
action_150 (17) = happyGoto action_53
action_150 (18) = happyGoto action_54
action_150 (19) = happyGoto action_55
action_150 (20) = happyGoto action_56
action_150 (21) = happyGoto action_57
action_150 (22) = happyGoto action_58
action_150 (23) = happyGoto action_155
action_150 (64) = happyGoto action_61
action_150 (79) = happyGoto action_62
action_150 _ = happyFail (happyExpListPerState 150)

action_151 (91) = happyShift action_29
action_151 (94) = happyShift action_63
action_151 (96) = happyShift action_64
action_151 (5) = happyGoto action_52
action_151 (17) = happyGoto action_53
action_151 (18) = happyGoto action_54
action_151 (19) = happyGoto action_55
action_151 (20) = happyGoto action_154
action_151 (64) = happyGoto action_61
action_151 (79) = happyGoto action_62
action_151 _ = happyFail (happyExpListPerState 151)

action_152 _ = happyReduce_30

action_153 _ = happyReduce_102

action_154 (91) = happyShift action_29
action_154 (94) = happyShift action_63
action_154 (96) = happyShift action_64
action_154 (5) = happyGoto action_52
action_154 (17) = happyGoto action_53
action_154 (18) = happyGoto action_54
action_154 (19) = happyGoto action_152
action_154 (64) = happyGoto action_61
action_154 (79) = happyGoto action_62
action_154 _ = happyReduce_32

action_155 _ = happyReduce_35

action_156 _ = happyReduce_120

action_157 (91) = happyShift action_29
action_157 (5) = happyGoto action_143
action_157 (15) = happyGoto action_212
action_157 _ = happyFail (happyExpListPerState 157)

action_158 _ = happyReduce_105

action_159 (91) = happyShift action_29
action_159 (94) = happyShift action_63
action_159 (96) = happyShift action_64
action_159 (5) = happyGoto action_52
action_159 (17) = happyGoto action_53
action_159 (18) = happyGoto action_54
action_159 (19) = happyGoto action_55
action_159 (20) = happyGoto action_56
action_159 (21) = happyGoto action_57
action_159 (22) = happyGoto action_58
action_159 (23) = happyGoto action_211
action_159 (64) = happyGoto action_61
action_159 (79) = happyGoto action_62
action_159 _ = happyFail (happyExpListPerState 159)

action_160 _ = happyReduce_39

action_161 (91) = happyShift action_29
action_161 (94) = happyShift action_63
action_161 (96) = happyShift action_64
action_161 (5) = happyGoto action_52
action_161 (17) = happyGoto action_53
action_161 (18) = happyGoto action_54
action_161 (19) = happyGoto action_55
action_161 (20) = happyGoto action_56
action_161 (21) = happyGoto action_57
action_161 (22) = happyGoto action_58
action_161 (23) = happyGoto action_210
action_161 (64) = happyGoto action_61
action_161 (79) = happyGoto action_62
action_161 _ = happyFail (happyExpListPerState 161)

action_162 _ = happyReduce_137

action_163 _ = happyReduce_68

action_164 (107) = happyShift action_209
action_164 _ = happyReduce_114

action_165 _ = happyReduce_75

action_166 _ = happyReduce_69

action_167 (100) = happyShift action_208
action_167 _ = happyFail (happyExpListPerState 167)

action_168 (91) = happyShift action_29
action_168 (94) = happyShift action_63
action_168 (96) = happyShift action_64
action_168 (106) = happyShift action_65
action_168 (5) = happyGoto action_52
action_168 (17) = happyGoto action_53
action_168 (18) = happyGoto action_54
action_168 (19) = happyGoto action_55
action_168 (20) = happyGoto action_56
action_168 (21) = happyGoto action_57
action_168 (22) = happyGoto action_58
action_168 (23) = happyGoto action_59
action_168 (24) = happyGoto action_207
action_168 (64) = happyGoto action_61
action_168 (79) = happyGoto action_62
action_168 _ = happyFail (happyExpListPerState 168)

action_169 _ = happyReduce_117

action_170 _ = happyReduce_118

action_171 (91) = happyShift action_29
action_171 (5) = happyGoto action_205
action_171 (35) = happyGoto action_206
action_171 _ = happyFail (happyExpListPerState 171)

action_172 (91) = happyShift action_29
action_172 (5) = happyGoto action_203
action_172 (32) = happyGoto action_204
action_172 _ = happyFail (happyExpListPerState 172)

action_173 _ = happyReduce_104

action_174 _ = happyReduce_103

action_175 (91) = happyShift action_29
action_175 (92) = happyShift action_90
action_175 (93) = happyShift action_91
action_175 (94) = happyShift action_92
action_175 (96) = happyShift action_93
action_175 (110) = happyShift action_94
action_175 (111) = happyShift action_95
action_175 (113) = happyShift action_96
action_175 (114) = happyShift action_97
action_175 (5) = happyGoto action_66
action_175 (30) = happyGoto action_67
action_175 (31) = happyGoto action_68
action_175 (34) = happyGoto action_69
action_175 (37) = happyGoto action_70
action_175 (38) = happyGoto action_71
action_175 (40) = happyGoto action_72
action_175 (41) = happyGoto action_73
action_175 (42) = happyGoto action_74
action_175 (43) = happyGoto action_75
action_175 (44) = happyGoto action_76
action_175 (45) = happyGoto action_77
action_175 (46) = happyGoto action_78
action_175 (47) = happyGoto action_79
action_175 (50) = happyGoto action_80
action_175 (52) = happyGoto action_81
action_175 (55) = happyGoto action_82
action_175 (56) = happyGoto action_202
action_175 (62) = happyGoto action_84
action_175 (63) = happyGoto action_85
action_175 (65) = happyGoto action_86
action_175 (76) = happyGoto action_87
action_175 (77) = happyGoto action_88
action_175 (80) = happyGoto action_89
action_175 _ = happyFail (happyExpListPerState 175)

action_176 (91) = happyShift action_29
action_176 (92) = happyShift action_90
action_176 (93) = happyShift action_91
action_176 (94) = happyShift action_92
action_176 (96) = happyShift action_93
action_176 (110) = happyShift action_94
action_176 (111) = happyShift action_95
action_176 (113) = happyShift action_96
action_176 (114) = happyShift action_97
action_176 (5) = happyGoto action_66
action_176 (30) = happyGoto action_67
action_176 (31) = happyGoto action_68
action_176 (34) = happyGoto action_69
action_176 (37) = happyGoto action_70
action_176 (38) = happyGoto action_71
action_176 (40) = happyGoto action_72
action_176 (41) = happyGoto action_73
action_176 (42) = happyGoto action_74
action_176 (43) = happyGoto action_75
action_176 (44) = happyGoto action_76
action_176 (45) = happyGoto action_77
action_176 (46) = happyGoto action_78
action_176 (47) = happyGoto action_79
action_176 (50) = happyGoto action_80
action_176 (52) = happyGoto action_81
action_176 (55) = happyGoto action_82
action_176 (56) = happyGoto action_201
action_176 (62) = happyGoto action_84
action_176 (63) = happyGoto action_85
action_176 (65) = happyGoto action_86
action_176 (76) = happyGoto action_87
action_176 (77) = happyGoto action_88
action_176 (80) = happyGoto action_89
action_176 _ = happyFail (happyExpListPerState 176)

action_177 (103) = happyShift action_200
action_177 _ = happyFail (happyExpListPerState 177)

action_178 (91) = happyShift action_18
action_178 (92) = happyShift action_19
action_178 (93) = happyShift action_20
action_178 (94) = happyShift action_21
action_178 (101) = happyShift action_199
action_178 (5) = happyGoto action_24
action_178 (7) = happyGoto action_6
action_178 (8) = happyGoto action_7
action_178 (9) = happyGoto action_8
action_178 (10) = happyGoto action_9
action_178 (11) = happyGoto action_10
action_178 (12) = happyGoto action_11
action_178 (13) = happyGoto action_12
action_178 (14) = happyGoto action_197
action_178 (48) = happyGoto action_198
action_178 (78) = happyGoto action_17
action_178 _ = happyFail (happyExpListPerState 178)

action_179 (91) = happyShift action_18
action_179 (92) = happyShift action_19
action_179 (93) = happyShift action_20
action_179 (94) = happyShift action_21
action_179 (5) = happyGoto action_24
action_179 (7) = happyGoto action_6
action_179 (8) = happyGoto action_7
action_179 (9) = happyGoto action_8
action_179 (10) = happyGoto action_9
action_179 (11) = happyGoto action_10
action_179 (12) = happyGoto action_11
action_179 (13) = happyGoto action_12
action_179 (14) = happyGoto action_196
action_179 (78) = happyGoto action_17
action_179 _ = happyFail (happyExpListPerState 179)

action_180 (91) = happyShift action_29
action_180 (92) = happyShift action_90
action_180 (93) = happyShift action_91
action_180 (94) = happyShift action_92
action_180 (96) = happyShift action_93
action_180 (110) = happyShift action_94
action_180 (111) = happyShift action_95
action_180 (113) = happyShift action_96
action_180 (114) = happyShift action_97
action_180 (5) = happyGoto action_66
action_180 (30) = happyGoto action_67
action_180 (31) = happyGoto action_68
action_180 (34) = happyGoto action_69
action_180 (37) = happyGoto action_70
action_180 (38) = happyGoto action_71
action_180 (40) = happyGoto action_72
action_180 (41) = happyGoto action_73
action_180 (42) = happyGoto action_74
action_180 (43) = happyGoto action_75
action_180 (44) = happyGoto action_76
action_180 (45) = happyGoto action_77
action_180 (46) = happyGoto action_78
action_180 (47) = happyGoto action_79
action_180 (50) = happyGoto action_80
action_180 (52) = happyGoto action_81
action_180 (55) = happyGoto action_82
action_180 (56) = happyGoto action_195
action_180 (62) = happyGoto action_84
action_180 (63) = happyGoto action_85
action_180 (65) = happyGoto action_86
action_180 (76) = happyGoto action_87
action_180 (77) = happyGoto action_88
action_180 (80) = happyGoto action_89
action_180 _ = happyFail (happyExpListPerState 180)

action_181 _ = happyReduce_131

action_182 (103) = happyShift action_194
action_182 _ = happyFail (happyExpListPerState 182)

action_183 _ = happyReduce_88

action_184 (102) = happyShift action_193
action_184 _ = happyReduce_111

action_185 (91) = happyShift action_29
action_185 (92) = happyShift action_90
action_185 (93) = happyShift action_91
action_185 (94) = happyShift action_92
action_185 (96) = happyShift action_93
action_185 (101) = happyShift action_192
action_185 (110) = happyShift action_94
action_185 (111) = happyShift action_95
action_185 (113) = happyShift action_96
action_185 (114) = happyShift action_97
action_185 (5) = happyGoto action_66
action_185 (30) = happyGoto action_67
action_185 (31) = happyGoto action_68
action_185 (34) = happyGoto action_69
action_185 (37) = happyGoto action_70
action_185 (38) = happyGoto action_71
action_185 (40) = happyGoto action_72
action_185 (41) = happyGoto action_73
action_185 (42) = happyGoto action_74
action_185 (43) = happyGoto action_75
action_185 (44) = happyGoto action_76
action_185 (45) = happyGoto action_77
action_185 (46) = happyGoto action_78
action_185 (47) = happyGoto action_79
action_185 (50) = happyGoto action_80
action_185 (52) = happyGoto action_81
action_185 (55) = happyGoto action_82
action_185 (56) = happyGoto action_191
action_185 (62) = happyGoto action_84
action_185 (63) = happyGoto action_85
action_185 (65) = happyGoto action_86
action_185 (76) = happyGoto action_87
action_185 (77) = happyGoto action_88
action_185 (80) = happyGoto action_89
action_185 _ = happyFail (happyExpListPerState 185)

action_186 (91) = happyShift action_29
action_186 (92) = happyShift action_90
action_186 (93) = happyShift action_91
action_186 (94) = happyShift action_92
action_186 (96) = happyShift action_93
action_186 (110) = happyShift action_94
action_186 (111) = happyShift action_95
action_186 (113) = happyShift action_96
action_186 (114) = happyShift action_97
action_186 (5) = happyGoto action_66
action_186 (30) = happyGoto action_67
action_186 (31) = happyGoto action_68
action_186 (34) = happyGoto action_69
action_186 (37) = happyGoto action_70
action_186 (38) = happyGoto action_71
action_186 (40) = happyGoto action_72
action_186 (41) = happyGoto action_73
action_186 (42) = happyGoto action_74
action_186 (43) = happyGoto action_75
action_186 (44) = happyGoto action_76
action_186 (45) = happyGoto action_77
action_186 (46) = happyGoto action_78
action_186 (47) = happyGoto action_79
action_186 (50) = happyGoto action_80
action_186 (52) = happyGoto action_81
action_186 (55) = happyGoto action_82
action_186 (56) = happyGoto action_190
action_186 (62) = happyGoto action_84
action_186 (63) = happyGoto action_85
action_186 (65) = happyGoto action_86
action_186 (76) = happyGoto action_87
action_186 (77) = happyGoto action_88
action_186 (80) = happyGoto action_89
action_186 _ = happyFail (happyExpListPerState 186)

action_187 (91) = happyShift action_29
action_187 (94) = happyShift action_63
action_187 (96) = happyShift action_64
action_187 (5) = happyGoto action_52
action_187 (17) = happyGoto action_53
action_187 (18) = happyGoto action_54
action_187 (19) = happyGoto action_55
action_187 (20) = happyGoto action_56
action_187 (21) = happyGoto action_57
action_187 (22) = happyGoto action_58
action_187 (23) = happyGoto action_189
action_187 (64) = happyGoto action_61
action_187 (79) = happyGoto action_62
action_187 _ = happyFail (happyExpListPerState 187)

action_188 _ = happyReduce_128

action_189 _ = happyReduce_41

action_190 _ = happyReduce_87

action_191 _ = happyReduce_92

action_192 (91) = happyShift action_29
action_192 (92) = happyShift action_90
action_192 (93) = happyShift action_91
action_192 (94) = happyShift action_92
action_192 (96) = happyShift action_93
action_192 (110) = happyShift action_94
action_192 (111) = happyShift action_95
action_192 (113) = happyShift action_96
action_192 (114) = happyShift action_97
action_192 (5) = happyGoto action_66
action_192 (30) = happyGoto action_67
action_192 (31) = happyGoto action_68
action_192 (34) = happyGoto action_69
action_192 (37) = happyGoto action_70
action_192 (38) = happyGoto action_71
action_192 (40) = happyGoto action_72
action_192 (41) = happyGoto action_73
action_192 (42) = happyGoto action_74
action_192 (43) = happyGoto action_75
action_192 (44) = happyGoto action_76
action_192 (45) = happyGoto action_77
action_192 (46) = happyGoto action_78
action_192 (47) = happyGoto action_79
action_192 (50) = happyGoto action_80
action_192 (52) = happyGoto action_81
action_192 (55) = happyGoto action_82
action_192 (56) = happyGoto action_222
action_192 (62) = happyGoto action_84
action_192 (63) = happyGoto action_85
action_192 (65) = happyGoto action_86
action_192 (76) = happyGoto action_87
action_192 (77) = happyGoto action_88
action_192 (80) = happyGoto action_89
action_192 _ = happyFail (happyExpListPerState 192)

action_193 (91) = happyShift action_18
action_193 (92) = happyShift action_19
action_193 (93) = happyShift action_20
action_193 (94) = happyShift action_21
action_193 (5) = happyGoto action_24
action_193 (7) = happyGoto action_6
action_193 (8) = happyGoto action_7
action_193 (9) = happyGoto action_8
action_193 (10) = happyGoto action_9
action_193 (11) = happyGoto action_10
action_193 (12) = happyGoto action_11
action_193 (13) = happyGoto action_12
action_193 (14) = happyGoto action_111
action_193 (53) = happyGoto action_221
action_193 (78) = happyGoto action_17
action_193 _ = happyFail (happyExpListPerState 193)

action_194 (115) = happyShift action_220
action_194 _ = happyFail (happyExpListPerState 194)

action_195 _ = happyReduce_85

action_196 _ = happyReduce_140

action_197 (104) = happyShift action_219
action_197 _ = happyFail (happyExpListPerState 197)

action_198 _ = happyReduce_79

action_199 (91) = happyShift action_18
action_199 (92) = happyShift action_19
action_199 (93) = happyShift action_20
action_199 (94) = happyShift action_21
action_199 (5) = happyGoto action_24
action_199 (7) = happyGoto action_6
action_199 (8) = happyGoto action_7
action_199 (9) = happyGoto action_8
action_199 (10) = happyGoto action_9
action_199 (11) = happyGoto action_10
action_199 (12) = happyGoto action_11
action_199 (13) = happyGoto action_12
action_199 (14) = happyGoto action_197
action_199 (48) = happyGoto action_215
action_199 (49) = happyGoto action_216
action_199 (69) = happyGoto action_217
action_199 (78) = happyGoto action_17
action_199 (84) = happyGoto action_218
action_199 _ = happyFail (happyExpListPerState 199)

action_200 (112) = happyShift action_214
action_200 _ = happyFail (happyExpListPerState 200)

action_201 _ = happyReduce_54

action_202 _ = happyReduce_49

action_203 (98) = happyShift action_175
action_203 _ = happyReduce_50

action_204 _ = happyReduce_134

action_205 (109) = happyShift action_176
action_205 _ = happyFail (happyExpListPerState 205)

action_206 _ = happyReduce_136

action_207 _ = happyReduce_59

action_208 _ = happyReduce_7

action_209 (91) = happyShift action_29
action_209 (5) = happyGoto action_213
action_209 _ = happyFail (happyExpListPerState 209)

action_210 _ = happyReduce_37

action_211 _ = happyReduce_22

action_212 _ = happyReduce_142

action_213 _ = happyReduce_138

action_214 (91) = happyShift action_18
action_214 (92) = happyShift action_19
action_214 (93) = happyShift action_20
action_214 (94) = happyShift action_21
action_214 (101) = happyShift action_230
action_214 (5) = happyGoto action_24
action_214 (7) = happyGoto action_6
action_214 (8) = happyGoto action_7
action_214 (9) = happyGoto action_8
action_214 (10) = happyGoto action_9
action_214 (11) = happyGoto action_10
action_214 (12) = happyGoto action_11
action_214 (13) = happyGoto action_12
action_214 (14) = happyGoto action_197
action_214 (48) = happyGoto action_229
action_214 (78) = happyGoto action_17
action_214 _ = happyFail (happyExpListPerState 214)

action_215 _ = happyReduce_129

action_216 (103) = happyShift action_228
action_216 _ = happyFail (happyExpListPerState 216)

action_217 _ = happyReduce_78

action_218 (102) = happyShift action_227
action_218 _ = happyReduce_110

action_219 (91) = happyShift action_29
action_219 (92) = happyShift action_90
action_219 (93) = happyShift action_91
action_219 (94) = happyShift action_92
action_219 (96) = happyShift action_93
action_219 (110) = happyShift action_94
action_219 (111) = happyShift action_95
action_219 (113) = happyShift action_96
action_219 (114) = happyShift action_97
action_219 (5) = happyGoto action_66
action_219 (30) = happyGoto action_67
action_219 (31) = happyGoto action_68
action_219 (34) = happyGoto action_69
action_219 (37) = happyGoto action_70
action_219 (38) = happyGoto action_71
action_219 (40) = happyGoto action_72
action_219 (41) = happyGoto action_73
action_219 (42) = happyGoto action_74
action_219 (43) = happyGoto action_75
action_219 (44) = happyGoto action_76
action_219 (45) = happyGoto action_77
action_219 (46) = happyGoto action_78
action_219 (47) = happyGoto action_79
action_219 (50) = happyGoto action_80
action_219 (52) = happyGoto action_81
action_219 (55) = happyGoto action_82
action_219 (56) = happyGoto action_226
action_219 (62) = happyGoto action_84
action_219 (63) = happyGoto action_85
action_219 (65) = happyGoto action_86
action_219 (76) = happyGoto action_87
action_219 (77) = happyGoto action_88
action_219 (80) = happyGoto action_89
action_219 _ = happyFail (happyExpListPerState 219)

action_220 (91) = happyShift action_29
action_220 (92) = happyShift action_90
action_220 (93) = happyShift action_91
action_220 (94) = happyShift action_92
action_220 (96) = happyShift action_93
action_220 (101) = happyShift action_225
action_220 (110) = happyShift action_94
action_220 (111) = happyShift action_95
action_220 (113) = happyShift action_96
action_220 (114) = happyShift action_97
action_220 (5) = happyGoto action_66
action_220 (30) = happyGoto action_67
action_220 (31) = happyGoto action_68
action_220 (34) = happyGoto action_69
action_220 (37) = happyGoto action_70
action_220 (38) = happyGoto action_71
action_220 (40) = happyGoto action_72
action_220 (41) = happyGoto action_73
action_220 (42) = happyGoto action_74
action_220 (43) = happyGoto action_75
action_220 (44) = happyGoto action_76
action_220 (45) = happyGoto action_77
action_220 (46) = happyGoto action_78
action_220 (47) = happyGoto action_79
action_220 (50) = happyGoto action_80
action_220 (52) = happyGoto action_81
action_220 (55) = happyGoto action_82
action_220 (56) = happyGoto action_224
action_220 (62) = happyGoto action_84
action_220 (63) = happyGoto action_85
action_220 (65) = happyGoto action_86
action_220 (76) = happyGoto action_87
action_220 (77) = happyGoto action_88
action_220 (80) = happyGoto action_89
action_220 _ = happyFail (happyExpListPerState 220)

action_221 _ = happyReduce_132

action_222 (103) = happyShift action_223
action_222 _ = happyFail (happyExpListPerState 222)

action_223 _ = happyReduce_91

action_224 _ = happyReduce_90

action_225 (91) = happyShift action_29
action_225 (92) = happyShift action_90
action_225 (93) = happyShift action_91
action_225 (94) = happyShift action_92
action_225 (96) = happyShift action_93
action_225 (110) = happyShift action_94
action_225 (111) = happyShift action_95
action_225 (113) = happyShift action_96
action_225 (114) = happyShift action_97
action_225 (5) = happyGoto action_66
action_225 (30) = happyGoto action_67
action_225 (31) = happyGoto action_68
action_225 (34) = happyGoto action_69
action_225 (37) = happyGoto action_70
action_225 (38) = happyGoto action_71
action_225 (40) = happyGoto action_72
action_225 (41) = happyGoto action_73
action_225 (42) = happyGoto action_74
action_225 (43) = happyGoto action_75
action_225 (44) = happyGoto action_76
action_225 (45) = happyGoto action_77
action_225 (46) = happyGoto action_78
action_225 (47) = happyGoto action_79
action_225 (50) = happyGoto action_80
action_225 (52) = happyGoto action_81
action_225 (55) = happyGoto action_82
action_225 (56) = happyGoto action_233
action_225 (62) = happyGoto action_84
action_225 (63) = happyGoto action_85
action_225 (65) = happyGoto action_86
action_225 (76) = happyGoto action_87
action_225 (77) = happyGoto action_88
action_225 (80) = happyGoto action_89
action_225 _ = happyFail (happyExpListPerState 225)

action_226 _ = happyReduce_77

action_227 (91) = happyShift action_18
action_227 (92) = happyShift action_19
action_227 (93) = happyShift action_20
action_227 (94) = happyShift action_21
action_227 (5) = happyGoto action_24
action_227 (7) = happyGoto action_6
action_227 (8) = happyGoto action_7
action_227 (9) = happyGoto action_8
action_227 (10) = happyGoto action_9
action_227 (11) = happyGoto action_10
action_227 (12) = happyGoto action_11
action_227 (13) = happyGoto action_12
action_227 (14) = happyGoto action_197
action_227 (48) = happyGoto action_232
action_227 (78) = happyGoto action_17
action_227 _ = happyFail (happyExpListPerState 227)

action_228 _ = happyReduce_81

action_229 _ = happyReduce_80

action_230 (91) = happyShift action_18
action_230 (92) = happyShift action_19
action_230 (93) = happyShift action_20
action_230 (94) = happyShift action_21
action_230 (5) = happyGoto action_24
action_230 (7) = happyGoto action_6
action_230 (8) = happyGoto action_7
action_230 (9) = happyGoto action_8
action_230 (10) = happyGoto action_9
action_230 (11) = happyGoto action_10
action_230 (12) = happyGoto action_11
action_230 (13) = happyGoto action_12
action_230 (14) = happyGoto action_197
action_230 (48) = happyGoto action_215
action_230 (49) = happyGoto action_231
action_230 (69) = happyGoto action_217
action_230 (78) = happyGoto action_17
action_230 (84) = happyGoto action_218
action_230 _ = happyFail (happyExpListPerState 230)

action_231 (103) = happyShift action_235
action_231 _ = happyFail (happyExpListPerState 231)

action_232 _ = happyReduce_130

action_233 (103) = happyShift action_234
action_233 _ = happyFail (happyExpListPerState 233)

action_234 _ = happyReduce_89

action_235 _ = happyReduce_82

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

happyReduce_5 = happySpecReduce_1  5 happyReduction_5
happyReduction_5 (HappyTerminal (TokenVariable _ happy_var_1))
	 =  HappyAbsSyn5
		 (tokenVariable2Variable happy_var_1
	)
happyReduction_5 _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_1  6 happyReduction_6
happyReduction_6 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn6
		 (case happy_var_1 of 
    TokenOperator _ op ->
      lexerOperator2Operator op
	)
happyReduction_6 _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_3  6 happyReduction_7
happyReduction_7 _
	(HappyTerminal (TokenVariable _ happy_var_2))
	_
	 =  HappyAbsSyn6
		 (let variable = tokenVariable2Variable happy_var_2
    in
      VariableAsOperator (getRange variable) variable
	)
happyReduction_7 _ _ _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_1  7 happyReduction_8
happyReduction_8 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn7
		 (VariablePattern (getRange happy_var_1) happy_var_1
	)
happyReduction_8 _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_1  8 happyReduction_9
happyReduction_9 (HappyTerminal (Hole happy_var_1))
	 =  HappyAbsSyn7
		 (HolePattern happy_var_1
	)
happyReduction_9 _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_1  9 happyReduction_10
happyReduction_10 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn7
		 (let literal=(tokenLiteral2Literal happy_var_1) 
  in 
    LiteralPattern (getRange literal) literal
	)
happyReduction_10 _  = notHappyAtAll 

happyReduce_11 = happyReduce 5 10 happyReduction_11
happyReduction_11 ((HappyTerminal (RightParen happy_var_5)) `HappyStk`
	(HappyAbsSyn17  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_2) `HappyStk`
	(HappyTerminal (LeftParen happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (AnnotationPattern (getRange (happy_var_1,happy_var_5)) happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_12 = happySpecReduce_1  11 happyReduction_12
happyReduction_12 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_12 _  = notHappyAtAll 

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
happyReduction_15 (HappyAbsSyn78  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_15 _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_1  11 happyReduction_16
happyReduction_16 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_16 _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_3  12 happyReduction_17
happyReduction_17 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn7
		 (AsPattern (getRange (happy_var_1,happy_var_3)) happy_var_1 happy_var_3
	)
happyReduction_17 _ _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_1  12 happyReduction_18
happyReduction_18 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_18 _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_2  13 happyReduction_19
happyReduction_19 (HappyAbsSyn67  happy_var_2)
	(HappyTerminal (TokenVariable _ happy_var_1))
	 =  HappyAbsSyn7
		 (let variable=(tokenVariable2Variable happy_var_1) 
  in
    ApplicationPattern (getRange(variable,happy_var_2)) variable happy_var_2
	)
happyReduction_19 _ _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_1  13 happyReduction_20
happyReduction_20 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_20 _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_1  14 happyReduction_21
happyReduction_21 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_21 _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_3  15 happyReduction_22
happyReduction_22 (HappyAbsSyn17  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn15
		 ((getRange (happy_var_1,happy_var_3),happy_var_1,happy_var_3)
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_1  16 happyReduction_23
happyReduction_23 (HappyAbsSyn75  happy_var_1)
	 =  HappyAbsSyn16
		 (happy_var_1
	)
happyReduction_23 _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_1  17 happyReduction_24
happyReduction_24 (HappyAbsSyn64  happy_var_1)
	 =  HappyAbsSyn17
		 (RecordType (getRange happy_var_1) (NonEmptyRecord (getRange happy_var_1) happy_var_1)
	)
happyReduction_24 _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_1  18 happyReduction_25
happyReduction_25 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn17
		 (VariableType (getRange happy_var_1) happy_var_1
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_1  19 happyReduction_26
happyReduction_26 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_26 _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_1  19 happyReduction_27
happyReduction_27 (HappyAbsSyn79  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_27 _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_1  19 happyReduction_28
happyReduction_28 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_28 _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_1  20 happyReduction_29
happyReduction_29 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_29 _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_2  20 happyReduction_30
happyReduction_30 (HappyAbsSyn17  happy_var_2)
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (ApplicationType (getRange (happy_var_2,happy_var_1)) happy_var_2 happy_var_1
	)
happyReduction_30 _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_1  21 happyReduction_31
happyReduction_31 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn21
		 (FirstItem happy_var_1
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_3  21 happyReduction_32
happyReduction_32 (HappyAbsSyn17  happy_var_3)
	(HappyAbsSyn6  happy_var_2)
	(HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn21
		 (IntercalatedCons happy_var_3 (IntercalatedCons happy_var_2 happy_var_1)
	)
happyReduction_32 _ _ _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_1  22 happyReduction_33
happyReduction_33 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn17
		 (MeaninglessOperatorsType (getRange happy_var_1) happy_var_1
	)
happyReduction_33 _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_1  23 happyReduction_34
happyReduction_34 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_34 _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_3  23 happyReduction_35
happyReduction_35 (HappyAbsSyn17  happy_var_3)
	_
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (TypeArrow (getRange (happy_var_1,happy_var_3)) happy_var_1 happy_var_3
	)
happyReduction_35 _ _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_1  24 happyReduction_36
happyReduction_36 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_36 _  = notHappyAtAll 

happyReduce_37 = happyReduce 4 24 happyReduction_37
happyReduction_37 ((HappyAbsSyn17  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn25  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn17
		 (TypeForall (getRange (happy_var_2,happy_var_4)) happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_38 = happySpecReduce_1  25 happyReduction_38
happyReduction_38 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn25
		 (happy_var_1 :| []
	)
happyReduction_38 _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_2  25 happyReduction_39
happyReduction_39 (HappyAbsSyn5  happy_var_2)
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (cons happy_var_2 happy_var_1
	)
happyReduction_39 _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_1  26 happyReduction_40
happyReduction_40 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn26
		 ([happy_var_1]
	)
happyReduction_40 _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_3  26 happyReduction_41
happyReduction_41 (HappyAbsSyn17  happy_var_3)
	_
	(HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn26
		 (happy_var_3:happy_var_1
	)
happyReduction_41 _ _ _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_1  27 happyReduction_42
happyReduction_42 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn27
		 (Constructor (getRange happy_var_1) happy_var_1 []
	)
happyReduction_42 _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_2  27 happyReduction_43
happyReduction_43 (HappyAbsSyn26  happy_var_2)
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn27
		 (Constructor (getRange happy_var_1) happy_var_1 happy_var_2
	)
happyReduction_43 _ _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_1  28 happyReduction_44
happyReduction_44 (HappyAbsSyn68  happy_var_1)
	 =  HappyAbsSyn28
		 (happy_var_1
	)
happyReduction_44 _  = notHappyAtAll 

happyReduce_45 = happyReduce 5 29 happyReduction_45
happyReduction_45 ((HappyAbsSyn28  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn66  happy_var_3) `HappyStk`
	(HappyAbsSyn5  happy_var_2) `HappyStk`
	(HappyTerminal (Data happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (ModuleDataType (getRange (happy_var_1,happy_var_5)) happy_var_2 (toList happy_var_3) happy_var_5
	) `HappyStk` happyRest

happyReduce_46 = happyReduce 4 29 happyReduction_46
happyReduction_46 ((HappyAbsSyn28  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_2) `HappyStk`
	(HappyTerminal (Data happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (ModuleDataType (getRange (happy_var_1,happy_var_4)) happy_var_2 [] happy_var_4
	) `HappyStk` happyRest

happyReduce_47 = happySpecReduce_1  30 happyReduction_47
happyReduction_47 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn30
		 (let literal=(tokenLiteral2Literal happy_var_1) 
  in 
    LiteralExpression (getRange literal) literal
	)
happyReduction_47 _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_1  31 happyReduction_48
happyReduction_48 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn30
		 (VariableExpression (getRange happy_var_1) happy_var_1
	)
happyReduction_48 _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_3  32 happyReduction_49
happyReduction_49 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn32
		 (((getRange (happy_var_1,happy_var_3)),happy_var_1,Just happy_var_3)
	)
happyReduction_49 _ _ _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_1  32 happyReduction_50
happyReduction_50 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn32
		 (((getRange happy_var_1),happy_var_1,Nothing)
	)
happyReduction_50 _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_1  33 happyReduction_51
happyReduction_51 (HappyAbsSyn71  happy_var_1)
	 =  HappyAbsSyn33
		 (happy_var_1
	)
happyReduction_51 _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_1  34 happyReduction_52
happyReduction_52 (HappyAbsSyn62  happy_var_1)
	 =  HappyAbsSyn30
		 (let range = getRange $ (\ (x,_,_) -> x ) <$> happy_var_1 
    in
    RecordExpression range (NonEmptyRecord range happy_var_1)
	)
happyReduction_52 _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_2  34 happyReduction_53
happyReduction_53 (HappyTerminal (RightBrace happy_var_2))
	(HappyTerminal (LeftBrace happy_var_1))
	 =  HappyAbsSyn30
		 (RecordExpression (getRange (happy_var_1,happy_var_2)) (EmptyRecord (getRange (happy_var_1,happy_var_2)))
	)
happyReduction_53 _ _  = notHappyAtAll 

happyReduce_54 = happySpecReduce_3  35 happyReduction_54
happyReduction_54 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn35
		 ((getRange (happy_var_1,happy_var_3),happy_var_1,happy_var_3)
	)
happyReduction_54 _ _ _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_1  36 happyReduction_55
happyReduction_55 (HappyAbsSyn72  happy_var_1)
	 =  HappyAbsSyn36
		 (happy_var_1
	)
happyReduction_55 _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_1  37 happyReduction_56
happyReduction_56 (HappyAbsSyn63  happy_var_1)
	 =  HappyAbsSyn30
		 (RecordUpdate (getRange happy_var_1) (NonEmptyRecord (getRange happy_var_1) happy_var_1)
	)
happyReduction_56 _  = notHappyAtAll 

happyReduce_57 = happySpecReduce_1  38 happyReduction_57
happyReduction_57 (HappyAbsSyn77  happy_var_1)
	 =  HappyAbsSyn30
		 (OperatorInParens (getRange happy_var_1) happy_var_1
	)
happyReduction_57 _  = notHappyAtAll 

happyReduce_58 = happySpecReduce_1  39 happyReduction_58
happyReduction_58 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_58 _  = notHappyAtAll 

happyReduce_59 = happySpecReduce_3  39 happyReduction_59
happyReduction_59 (HappyAbsSyn17  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (AnnotationExpression (getRange (happy_var_1,happy_var_3)) happy_var_1 happy_var_3
	)
happyReduction_59 _ _ _  = notHappyAtAll 

happyReduce_60 = happySpecReduce_2  40 happyReduction_60
happyReduction_60 (HappyAbsSyn17  happy_var_2)
	(HappyTerminal (At happy_var_1))
	 =  HappyAbsSyn30
		 (TypeArgumentExpression (getRange (happy_var_1,happy_var_2)) happy_var_2
	)
happyReduction_60 _ _  = notHappyAtAll 

happyReduce_61 = happySpecReduce_1  41 happyReduction_61
happyReduction_61 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_61 _  = notHappyAtAll 

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
happyReduction_67 (HappyAbsSyn76  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_67 _  = notHappyAtAll 

happyReduce_68 = happySpecReduce_3  42 happyReduction_68
happyReduction_68 (HappyAbsSyn73  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (makeAccessor happy_var_1 (toList happy_var_3)
	)
happyReduction_68 _ _ _  = notHappyAtAll 

happyReduce_69 = happySpecReduce_3  43 happyReduction_69
happyReduction_69 (HappyAbsSyn5  happy_var_3)
	_
	(HappyTerminal (Hole happy_var_1))
	 =  HappyAbsSyn30
		 (AccessorFunction (getRange (happy_var_1,happy_var_3)) happy_var_3
	)
happyReduction_69 _ _ _  = notHappyAtAll 

happyReduce_70 = happySpecReduce_1  44 happyReduction_70
happyReduction_70 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_70 _  = notHappyAtAll 

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

happyReduce_73 = happySpecReduce_1  45 happyReduction_73
happyReduction_73 (HappyAbsSyn65  happy_var_1)
	 =  HappyAbsSyn30
		 (case uncons happy_var_1 of 
    (f , Nothing) -> f
    (f ,Just args) ->
      ApplicationExpression (getRange happy_var_1) f args
	)
happyReduction_73 _  = notHappyAtAll 

happyReduce_74 = happySpecReduce_1  46 happyReduction_74
happyReduction_74 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn46
		 (FirstItem happy_var_1
	)
happyReduction_74 _  = notHappyAtAll 

happyReduce_75 = happySpecReduce_3  46 happyReduction_75
happyReduction_75 (HappyAbsSyn30  happy_var_3)
	(HappyAbsSyn6  happy_var_2)
	(HappyAbsSyn46  happy_var_1)
	 =  HappyAbsSyn46
		 (IntercalatedCons happy_var_3 (IntercalatedCons happy_var_2 happy_var_1)
	)
happyReduction_75 _ _ _  = notHappyAtAll 

happyReduce_76 = happySpecReduce_1  47 happyReduction_76
happyReduction_76 (HappyAbsSyn46  happy_var_1)
	 =  HappyAbsSyn30
		 (MeaninglessOperatorsExpression  (getRange happy_var_1) happy_var_1
	)
happyReduction_76 _  = notHappyAtAll 

happyReduce_77 = happySpecReduce_3  48 happyReduction_77
happyReduction_77 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn48
		 (CaseCase (getRange (happy_var_1,happy_var_3)) happy_var_1 happy_var_3
	)
happyReduction_77 _ _ _  = notHappyAtAll 

happyReduce_78 = happySpecReduce_1  49 happyReduction_78
happyReduction_78 (HappyAbsSyn69  happy_var_1)
	 =  HappyAbsSyn49
		 (happy_var_1
	)
happyReduction_78 _  = notHappyAtAll 

happyReduce_79 = happyReduce 4 50 happyReduction_79
happyReduction_79 ((HappyAbsSyn48  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_2) `HappyStk`
	(HappyTerminal (Case happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (SST.Case (getRange (happy_var_1,happy_var_4)) happy_var_2 (singleton happy_var_4)
	) `HappyStk` happyRest

happyReduce_80 = happyReduce 6 50 happyReduction_80
happyReduction_80 ((HappyAbsSyn48  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Case happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (SST.Case (getRange (happy_var_1,happy_var_6)) happy_var_3 (singleton happy_var_6)
	) `HappyStk` happyRest

happyReduce_81 = happyReduce 6 50 happyReduction_81
happyReduction_81 (_ `HappyStk`
	(HappyAbsSyn49  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_2) `HappyStk`
	(HappyTerminal (Case happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (SST.Case (getRange (happy_var_1,happy_var_5)) happy_var_2 happy_var_5
	) `HappyStk` happyRest

happyReduce_82 = happyReduce 8 50 happyReduction_82
happyReduction_82 (_ `HappyStk`
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

happyReduce_83 = happySpecReduce_1  50 happyReduction_83
happyReduction_83 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_83 _  = notHappyAtAll 

happyReduce_84 = happySpecReduce_1  51 happyReduction_84
happyReduction_84 (HappyAbsSyn74  happy_var_1)
	 =  HappyAbsSyn51
		 (happy_var_1
	)
happyReduction_84 _  = notHappyAtAll 

happyReduce_85 = happyReduce 4 52 happyReduction_85
happyReduction_85 ((HappyAbsSyn30  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn51  happy_var_2) `HappyStk`
	(HappyTerminal (LambdaStart happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (Lambda (getRange (happy_var_1,happy_var_4)) happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_86 = happySpecReduce_1  52 happyReduction_86
happyReduction_86 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_86 _  = notHappyAtAll 

happyReduce_87 = happySpecReduce_3  53 happyReduction_87
happyReduction_87 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn53
		 (LetBinding (getRange (happy_var_1,happy_var_3)) happy_var_1 happy_var_3
	)
happyReduction_87 _ _ _  = notHappyAtAll 

happyReduce_88 = happySpecReduce_1  54 happyReduction_88
happyReduction_88 (HappyAbsSyn70  happy_var_1)
	 =  HappyAbsSyn54
		 (happy_var_1
	)
happyReduction_88 _  = notHappyAtAll 

happyReduce_89 = happyReduce 8 55 happyReduction_89
happyReduction_89 (_ `HappyStk`
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

happyReduce_90 = happyReduce 6 55 happyReduction_90
happyReduction_90 ((HappyAbsSyn30  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn54  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Let happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (SST.Let (getRange (happy_var_1,happy_var_6)) happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_91 = happyReduce 6 55 happyReduction_91
happyReduction_91 (_ `HappyStk`
	(HappyAbsSyn30  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn53  happy_var_2) `HappyStk`
	(HappyTerminal (Let happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (SST.Let (getRange (happy_var_1,happy_var_5)) (happy_var_2 :|[]) happy_var_5
	) `HappyStk` happyRest

happyReduce_92 = happyReduce 4 55 happyReduction_92
happyReduction_92 ((HappyAbsSyn30  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn53  happy_var_2) `HappyStk`
	(HappyTerminal (Let happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (SST.Let (getRange (happy_var_1,happy_var_4)) (happy_var_2 :| []) happy_var_4
	) `HappyStk` happyRest

happyReduce_93 = happySpecReduce_1  55 happyReduction_93
happyReduction_93 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_93 _  = notHappyAtAll 

happyReduce_94 = happySpecReduce_1  56 happyReduction_94
happyReduction_94 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_94 _  = notHappyAtAll 

happyReduce_95 = happyReduce 5 57 happyReduction_95
happyReduction_95 (_ `HappyStk`
	(HappyAbsSyn17  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (ModuleVariableDeclaration (getRange (happy_var_1,happy_var_4)) happy_var_1 happy_var_4
	) `HappyStk` happyRest

happyReduce_96 = happyReduce 5 58 happyReduction_96
happyReduction_96 (_ `HappyStk`
	(HappyAbsSyn30  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (ModulePatternDefinition (getRange (happy_var_1,happy_var_4)) happy_var_1 happy_var_4
	) `HappyStk` happyRest

happyReduce_97 = happySpecReduce_1  59 happyReduction_97
happyReduction_97 (HappyTerminal (Type happy_var_1))
	 =  HappyAbsSyn59
		 (IsTypeOperator (getRange happy_var_1)
	)
happyReduction_97 _  = notHappyAtAll 

happyReduce_98 = happySpecReduce_1  59 happyReduction_98
happyReduction_98 (HappyTerminal (Term happy_var_1))
	 =  HappyAbsSyn59
		 (IsTypeOperator(getRange happy_var_1)
	)
happyReduction_98 _  = notHappyAtAll 

happyReduce_99 = happySpecReduce_1  60 happyReduction_99
happyReduction_99 (HappyTerminal (Left_ happy_var_1))
	 =  HappyAbsSyn60
		 (LeftOperator(getRange happy_var_1)
	)
happyReduction_99 _  = notHappyAtAll 

happyReduce_100 = happySpecReduce_1  60 happyReduction_100
happyReduction_100 (HappyTerminal (Right_ happy_var_1))
	 =  HappyAbsSyn60
		 (RightOperator(getRange happy_var_1)
	)
happyReduction_100 _  = notHappyAtAll 

happyReduce_101 = happySpecReduce_1  60 happyReduction_101
happyReduction_101 (HappyTerminal (None happy_var_1))
	 =  HappyAbsSyn60
		 (NoneOperator(getRange happy_var_1)
	)
happyReduction_101 _  = notHappyAtAll 

happyReduce_102 = happyReduce 5 61 happyReduction_102
happyReduction_102 ((HappyTerminal happy_var_5) `HappyStk`
	(HappyAbsSyn60  happy_var_4) `HappyStk`
	(HappyAbsSyn59  happy_var_3) `HappyStk`
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

happyReduce_103 = happySpecReduce_3  62 happyReduction_103
happyReduction_103 _
	(HappyAbsSyn33  happy_var_2)
	_
	 =  HappyAbsSyn62
		 (happy_var_2
	)
happyReduction_103 _ _ _  = notHappyAtAll 

happyReduce_104 = happySpecReduce_3  63 happyReduction_104
happyReduction_104 _
	(HappyAbsSyn36  happy_var_2)
	_
	 =  HappyAbsSyn63
		 (happy_var_2
	)
happyReduction_104 _ _ _  = notHappyAtAll 

happyReduce_105 = happySpecReduce_3  64 happyReduction_105
happyReduction_105 _
	(HappyAbsSyn16  happy_var_2)
	_
	 =  HappyAbsSyn64
		 (happy_var_2
	)
happyReduction_105 _ _ _  = notHappyAtAll 

happyReduce_106 = happySpecReduce_1  65 happyReduction_106
happyReduction_106 (HappyAbsSyn80  happy_var_1)
	 =  HappyAbsSyn65
		 (reverse happy_var_1
	)
happyReduction_106 _  = notHappyAtAll 

happyReduce_107 = happySpecReduce_1  66 happyReduction_107
happyReduction_107 (HappyAbsSyn81  happy_var_1)
	 =  HappyAbsSyn66
		 (reverse happy_var_1
	)
happyReduction_107 _  = notHappyAtAll 

happyReduce_108 = happySpecReduce_1  67 happyReduction_108
happyReduction_108 (HappyAbsSyn82  happy_var_1)
	 =  HappyAbsSyn67
		 (reverse happy_var_1
	)
happyReduction_108 _  = notHappyAtAll 

happyReduce_109 = happySpecReduce_1  68 happyReduction_109
happyReduction_109 (HappyAbsSyn83  happy_var_1)
	 =  HappyAbsSyn68
		 (reverse happy_var_1
	)
happyReduction_109 _  = notHappyAtAll 

happyReduce_110 = happySpecReduce_1  69 happyReduction_110
happyReduction_110 (HappyAbsSyn84  happy_var_1)
	 =  HappyAbsSyn69
		 (reverse happy_var_1
	)
happyReduction_110 _  = notHappyAtAll 

happyReduce_111 = happySpecReduce_1  70 happyReduction_111
happyReduction_111 (HappyAbsSyn85  happy_var_1)
	 =  HappyAbsSyn70
		 (reverse happy_var_1
	)
happyReduction_111 _  = notHappyAtAll 

happyReduce_112 = happySpecReduce_1  71 happyReduction_112
happyReduction_112 (HappyAbsSyn86  happy_var_1)
	 =  HappyAbsSyn71
		 (reverse happy_var_1
	)
happyReduction_112 _  = notHappyAtAll 

happyReduce_113 = happySpecReduce_1  72 happyReduction_113
happyReduction_113 (HappyAbsSyn87  happy_var_1)
	 =  HappyAbsSyn72
		 (reverse happy_var_1
	)
happyReduction_113 _  = notHappyAtAll 

happyReduce_114 = happySpecReduce_1  73 happyReduction_114
happyReduction_114 (HappyAbsSyn88  happy_var_1)
	 =  HappyAbsSyn73
		 (reverse happy_var_1
	)
happyReduction_114 _  = notHappyAtAll 

happyReduce_115 = happySpecReduce_1  74 happyReduction_115
happyReduction_115 (HappyAbsSyn89  happy_var_1)
	 =  HappyAbsSyn74
		 (reverse happy_var_1
	)
happyReduction_115 _  = notHappyAtAll 

happyReduce_116 = happySpecReduce_1  75 happyReduction_116
happyReduction_116 (HappyAbsSyn90  happy_var_1)
	 =  HappyAbsSyn75
		 (reverse happy_var_1
	)
happyReduction_116 _  = notHappyAtAll 

happyReduce_117 = happySpecReduce_3  76 happyReduction_117
happyReduction_117 _
	(HappyAbsSyn30  happy_var_2)
	_
	 =  HappyAbsSyn76
		 (happy_var_2
	)
happyReduction_117 _ _ _  = notHappyAtAll 

happyReduce_118 = happySpecReduce_3  77 happyReduction_118
happyReduction_118 _
	(HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn77
		 (happy_var_2
	)
happyReduction_118 _ _ _  = notHappyAtAll 

happyReduce_119 = happySpecReduce_3  78 happyReduction_119
happyReduction_119 _
	(HappyAbsSyn7  happy_var_2)
	_
	 =  HappyAbsSyn78
		 (happy_var_2
	)
happyReduction_119 _ _ _  = notHappyAtAll 

happyReduce_120 = happySpecReduce_3  79 happyReduction_120
happyReduction_120 _
	(HappyAbsSyn17  happy_var_2)
	_
	 =  HappyAbsSyn79
		 (happy_var_2
	)
happyReduction_120 _ _ _  = notHappyAtAll 

happyReduce_121 = happySpecReduce_1  80 happyReduction_121
happyReduction_121 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn80
		 (happy_var_1 :| []
	)
happyReduction_121 _  = notHappyAtAll 

happyReduce_122 = happySpecReduce_2  80 happyReduction_122
happyReduction_122 (HappyAbsSyn30  happy_var_2)
	(HappyAbsSyn80  happy_var_1)
	 =  HappyAbsSyn80
		 (cons happy_var_2 happy_var_1
	)
happyReduction_122 _ _  = notHappyAtAll 

happyReduce_123 = happySpecReduce_1  81 happyReduction_123
happyReduction_123 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn81
		 (happy_var_1 :| []
	)
happyReduction_123 _  = notHappyAtAll 

happyReduce_124 = happySpecReduce_2  81 happyReduction_124
happyReduction_124 (HappyAbsSyn5  happy_var_2)
	(HappyAbsSyn81  happy_var_1)
	 =  HappyAbsSyn81
		 (cons happy_var_2 happy_var_1
	)
happyReduction_124 _ _  = notHappyAtAll 

happyReduce_125 = happySpecReduce_1  82 happyReduction_125
happyReduction_125 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn82
		 (happy_var_1 :| []
	)
happyReduction_125 _  = notHappyAtAll 

happyReduce_126 = happySpecReduce_2  82 happyReduction_126
happyReduction_126 (HappyAbsSyn7  happy_var_2)
	(HappyAbsSyn82  happy_var_1)
	 =  HappyAbsSyn82
		 (cons happy_var_2 happy_var_1
	)
happyReduction_126 _ _  = notHappyAtAll 

happyReduce_127 = happySpecReduce_1  83 happyReduction_127
happyReduction_127 (HappyAbsSyn27  happy_var_1)
	 =  HappyAbsSyn83
		 (happy_var_1 :| []
	)
happyReduction_127 _  = notHappyAtAll 

happyReduce_128 = happySpecReduce_3  83 happyReduction_128
happyReduction_128 (HappyAbsSyn27  happy_var_3)
	_
	(HappyAbsSyn83  happy_var_1)
	 =  HappyAbsSyn83
		 (cons happy_var_3 happy_var_1
	)
happyReduction_128 _ _ _  = notHappyAtAll 

happyReduce_129 = happySpecReduce_1  84 happyReduction_129
happyReduction_129 (HappyAbsSyn48  happy_var_1)
	 =  HappyAbsSyn84
		 (happy_var_1 :| []
	)
happyReduction_129 _  = notHappyAtAll 

happyReduce_130 = happySpecReduce_3  84 happyReduction_130
happyReduction_130 (HappyAbsSyn48  happy_var_3)
	_
	(HappyAbsSyn84  happy_var_1)
	 =  HappyAbsSyn84
		 (cons happy_var_3 happy_var_1
	)
happyReduction_130 _ _ _  = notHappyAtAll 

happyReduce_131 = happySpecReduce_1  85 happyReduction_131
happyReduction_131 (HappyAbsSyn53  happy_var_1)
	 =  HappyAbsSyn85
		 (happy_var_1 :| []
	)
happyReduction_131 _  = notHappyAtAll 

happyReduce_132 = happySpecReduce_3  85 happyReduction_132
happyReduction_132 (HappyAbsSyn53  happy_var_3)
	_
	(HappyAbsSyn85  happy_var_1)
	 =  HappyAbsSyn85
		 (cons happy_var_3 happy_var_1
	)
happyReduction_132 _ _ _  = notHappyAtAll 

happyReduce_133 = happySpecReduce_1  86 happyReduction_133
happyReduction_133 (HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn86
		 (happy_var_1 :| []
	)
happyReduction_133 _  = notHappyAtAll 

happyReduce_134 = happySpecReduce_3  86 happyReduction_134
happyReduction_134 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn86  happy_var_1)
	 =  HappyAbsSyn86
		 (cons happy_var_3 happy_var_1
	)
happyReduction_134 _ _ _  = notHappyAtAll 

happyReduce_135 = happySpecReduce_1  87 happyReduction_135
happyReduction_135 (HappyAbsSyn35  happy_var_1)
	 =  HappyAbsSyn87
		 (happy_var_1 :| []
	)
happyReduction_135 _  = notHappyAtAll 

happyReduce_136 = happySpecReduce_3  87 happyReduction_136
happyReduction_136 (HappyAbsSyn35  happy_var_3)
	_
	(HappyAbsSyn87  happy_var_1)
	 =  HappyAbsSyn87
		 (cons happy_var_3 happy_var_1
	)
happyReduction_136 _ _ _  = notHappyAtAll 

happyReduce_137 = happySpecReduce_1  88 happyReduction_137
happyReduction_137 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn88
		 (happy_var_1 :| []
	)
happyReduction_137 _  = notHappyAtAll 

happyReduce_138 = happySpecReduce_3  88 happyReduction_138
happyReduction_138 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn88  happy_var_1)
	 =  HappyAbsSyn88
		 (cons happy_var_3 happy_var_1
	)
happyReduction_138 _ _ _  = notHappyAtAll 

happyReduce_139 = happySpecReduce_1  89 happyReduction_139
happyReduction_139 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn89
		 (happy_var_1 :| []
	)
happyReduction_139 _  = notHappyAtAll 

happyReduce_140 = happySpecReduce_3  89 happyReduction_140
happyReduction_140 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn89  happy_var_1)
	 =  HappyAbsSyn89
		 (cons happy_var_3 happy_var_1
	)
happyReduction_140 _ _ _  = notHappyAtAll 

happyReduce_141 = happySpecReduce_1  90 happyReduction_141
happyReduction_141 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn90
		 (happy_var_1 :| []
	)
happyReduction_141 _  = notHappyAtAll 

happyReduce_142 = happySpecReduce_3  90 happyReduction_142
happyReduction_142 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn90  happy_var_1)
	 =  HappyAbsSyn90
		 (cons happy_var_3 happy_var_1
	)
happyReduction_142 _ _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 123 123 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenVariable _ happy_dollar_dollar -> cont 91;
	Hole happy_dollar_dollar -> cont 92;
	LiteralUint _ _ -> cont 93;
	LeftParen happy_dollar_dollar -> cont 94;
	RightParen happy_dollar_dollar -> cont 95;
	LeftBrace happy_dollar_dollar -> cont 96;
	RightBrace happy_dollar_dollar -> cont 97;
	Colon happy_dollar_dollar -> cont 98;
	Comma happy_dollar_dollar -> cont 99;
	BackTick happy_dollar_dollar -> cont 100;
	LayoutStart happy_dollar_dollar -> cont 101;
	LayoutSeparator happy_dollar_dollar -> cont 102;
	LayoutEnd happy_dollar_dollar -> cont 103;
	RightArrow happy_dollar_dollar -> cont 104;
	TokenOperator _ _ -> cont 105;
	Forall happy_dollar_dollar -> cont 106;
	Dot happy_dollar_dollar -> cont 107;
	Data happy_dollar_dollar -> cont 108;
	Equal happy_dollar_dollar -> cont 109;
	At happy_dollar_dollar -> cont 110;
	Case happy_dollar_dollar -> cont 111;
	Of happy_dollar_dollar -> cont 112;
	LambdaStart happy_dollar_dollar -> cont 113;
	Let happy_dollar_dollar -> cont 114;
	In happy_dollar_dollar -> cont 115;
	OperatorKeyword happy_dollar_dollar -> cont 116;
	Type happy_dollar_dollar -> cont 117;
	Term happy_dollar_dollar -> cont 118;
	Left_ happy_dollar_dollar -> cont 119;
	Right_ happy_dollar_dollar -> cont 120;
	None happy_dollar_dollar -> cont 121;
	Pipe happy_dollar_dollar -> cont 122;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 123 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Prelude.Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure  = HappyIdentity
    (<*>) = ap
instance Prelude.Monad HappyIdentity where
    return = pure
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (Prelude.>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (Prelude.return)
happyThen1 m k tks = (Prelude.>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (Prelude.return) a
happyError' :: () => ([(Token)], [Prelude.String]) -> HappyIdentity a
happyError' = HappyIdentity Prelude.. parseError
parse tks = happyRunIdentity happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError :: ([Token],[String]) -> a
parseError (_,pos) = error ("Parse error, expected:  " <> show pos)
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
