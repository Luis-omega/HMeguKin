{-# OPTIONS_GHC -w #-}
module HMeguKin.Parser.Parser(parse) where

import Data.List.NonEmpty(NonEmpty((:|)),cons,reverse)
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

data HappyAbsSyn t62 t63 t64 t65 t66 t67 t68 t69 t70 t71 t72 t73 t74 t75 t76 t77 t78 t79 t80 t81 t82 t83 t84 t85 t86
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

happyExpList :: Happy_Data_Array.Array Prelude.Int Prelude.Int
happyExpList = Happy_Data_Array.listArray (0,1465) ([0,0,0,0,0,960,32896,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,60,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,240,0,0,0,0,0,0,0,256,0,0,0,0,0,0,0,3072,0,0,0,0,0,0,512,0,0,0,0,0,0,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,49152,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,1024,0,0,0,0,0,0,960,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,41984,512,0,0,0,0,0,0,47,216,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,164,2,0,0,0,0,0,0,0,112,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,41984,0,0,0,0,0,0,0,16896,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,656,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,188,864,0,0,0,0,0,0,0,0,0,0,0,0,0,4224,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4352,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,0,35776,13840,0,0,0,0,0,4096,4,0,0,0,0,0,0,164,0,0,0,0,0,0,12032,55300,0,0,0,0,0,49152,3,0,0,0,0,0,0,16624,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,2624,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1024,0,0,0,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,16384,0,0,0,0,0,61440,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,33792,0,0,0,0,0,0,47,216,0,0,0,0,0,0,0,0,0,0,0,0,0,16392,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,4,0,0,0,0,0,0,2048,16,0,0,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,12032,55296,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,47,216,0,0,0,0,0,0,0,0,0,0,0,0,4096,4096,0,0,0,0,0,0,512,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,36864,2,0,0,0,0,0,0,164,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,656,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,164,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,0,0,0,164,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,61440,32770,13,0,0,0,0,0,188,864,0,0,0,0,0,0,272,0,0,0,0,0,49152,259,0,0,0,0,0,0,240,0,0,0,0,0,0,48128,24576,3,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,12032,55300,0,0,0,0,0,49152,11,54,0,0,0,0,0,656,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,188,864,0,0,0,0,0,3840,0,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,49152,3,0,0,0,0,0,0,0,512,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,1,0,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,61440,64,0,0,0,0,0,0,16384,0,0,0,0,0,0,3840,0,0,0,0,0,0,49152,267,54,0,0,0,0,0,17136,3456,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,188,864,0,0,0,0,0,0,0,0,0,0,0,0,49152,11,54,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,960,0,0,0,0,0,0,0,256,0,0,0,0,0,0,16384,4,0,0,0,0,0,0,272,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","module_statement","meta_variable","meta_operator","pattern_match_variable","pattern_match_hole","pattern_match_literal","pattern_annotation","pattern_match_atom","pattern_as","pattern_match_application","pattern_match","type_record_item","type_record_inner","type_record","type_variable","type_atom","type_application","type_operators_plus","type_operators","type_expression_inner","type_scheme","type_data_type_args","type_expression_inner_sep_comma","data_type_constructor","data_type_constructor_plus","data_type","expression_literal","expression_variable","expression_record_item","expression_record_inner","expression_record","expression_record_update_item","expression_record_update_inner","expression_record_update","expression_operator_parens","expression_annotation","expression_type_arg","expression_accessor_field","expression_accessor_funtion","expression_accessor","expression_atom","expression_application","expression_operators_plus","expression_operators","expression_case_single","expression_case_cases","expression_case","expression_lambda_arguments","expression_lambda","expression_let_binding","expression_let_inside","expression_let","expression","variable_declaration","pattern_declaration","fixity","precedence","operator_fixity","braces__expression_record_inner__","braces__expression_record_update_inner__","braces__type_record_inner__","list__meta_variable__","list1__expression_atom__","list1__pattern_as__","listSepBy1__expression_case_single__LayoutSeparator__","listSepBy1__expression_let_binding__LayoutSeparator__","listSepBy1__expression_record_item__Comma__","listSepBy1__expression_record_update_item__Comma__","listSepBy1__pattern_match__Comma__","listSepBy1__type_record_item__Comma__","parens__expression_annotation__","parens__meta_operator__","parens__pattern_match__","parens__type_expression_inner__","plus__expression_atom__","plus__pattern_as__","sepBy1__expression_case_single__LayoutSeparator__","sepBy1__expression_let_binding__LayoutSeparator__","sepBy1__expression_record_item__Comma__","sepBy1__expression_record_update_item__Comma__","sepBy1__pattern_match__Comma__","sepBy1__type_record_item__Comma__","star__meta_variable__","Variable","Hole","UInt","LParen","RParen","LBrace","RBrace","Colon","Comma","BackTick","LayoutStart","LayoutSeparator","LayoutEnd","RightArrow","TokenOperator","Forall","Dot","Data","Equal","At","Case","Of","Lambda","Let","In","OperatorKeyword","Type","Term","Left_","Right_","None","%eof"]
        bit_start = st Prelude.* 118
        bit_end = (st Prelude.+ 1) Prelude.* 118
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..117]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

action_0 (87) = happyShift action_18
action_0 (88) = happyShift action_19
action_0 (89) = happyShift action_20
action_0 (90) = happyShift action_21
action_0 (104) = happyShift action_3
action_0 (112) = happyShift action_22
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
action_0 (76) = happyGoto action_17
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (104) = happyShift action_3
action_1 (29) = happyGoto action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyReduce_1

action_3 (87) = happyShift action_29
action_3 (5) = happyGoto action_33
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (118) = happyAccept
action_4 _ = happyFail (happyExpListPerState 4)

action_5 (94) = happyShift action_31
action_5 (106) = happyShift action_32
action_5 _ = happyReduce_8

action_6 _ = happyReduce_13

action_7 _ = happyReduce_14

action_8 _ = happyReduce_12

action_9 _ = happyReduce_16

action_10 _ = happyReduce_18

action_11 _ = happyReduce_20

action_12 _ = happyReduce_21

action_13 (105) = happyShift action_30
action_13 _ = happyFail (happyExpListPerState 13)

action_14 _ = happyReduce_2

action_15 _ = happyReduce_3

action_16 _ = happyReduce_4

action_17 _ = happyReduce_15

action_18 (87) = happyShift action_29
action_18 (88) = happyShift action_19
action_18 (89) = happyShift action_20
action_18 (90) = happyShift action_21
action_18 (5) = happyGoto action_24
action_18 (7) = happyGoto action_6
action_18 (8) = happyGoto action_7
action_18 (9) = happyGoto action_8
action_18 (10) = happyGoto action_9
action_18 (11) = happyGoto action_10
action_18 (12) = happyGoto action_26
action_18 (67) = happyGoto action_27
action_18 (76) = happyGoto action_17
action_18 (79) = happyGoto action_28
action_18 _ = happyReduce_5

action_19 _ = happyReduce_9

action_20 _ = happyReduce_10

action_21 (87) = happyShift action_18
action_21 (88) = happyShift action_19
action_21 (89) = happyShift action_20
action_21 (90) = happyShift action_21
action_21 (5) = happyGoto action_24
action_21 (7) = happyGoto action_6
action_21 (8) = happyGoto action_7
action_21 (9) = happyGoto action_8
action_21 (10) = happyGoto action_9
action_21 (11) = happyGoto action_10
action_21 (12) = happyGoto action_11
action_21 (13) = happyGoto action_12
action_21 (14) = happyGoto action_25
action_21 (76) = happyGoto action_17
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (101) = happyShift action_23
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (113) = happyShift action_44
action_23 (114) = happyShift action_45
action_23 (59) = happyGoto action_43
action_23 _ = happyFail (happyExpListPerState 23)

action_24 (106) = happyShift action_32
action_24 _ = happyReduce_8

action_25 (91) = happyShift action_41
action_25 (94) = happyShift action_42
action_25 _ = happyFail (happyExpListPerState 25)

action_26 _ = happyReduce_123

action_27 _ = happyReduce_19

action_28 (87) = happyShift action_29
action_28 (88) = happyShift action_19
action_28 (89) = happyShift action_20
action_28 (90) = happyShift action_21
action_28 (5) = happyGoto action_24
action_28 (7) = happyGoto action_6
action_28 (8) = happyGoto action_7
action_28 (9) = happyGoto action_8
action_28 (10) = happyGoto action_9
action_28 (11) = happyGoto action_10
action_28 (12) = happyGoto action_40
action_28 (76) = happyGoto action_17
action_28 _ = happyReduce_110

action_29 _ = happyReduce_5

action_30 (97) = happyShift action_39
action_30 _ = happyFail (happyExpListPerState 30)

action_31 (97) = happyShift action_38
action_31 _ = happyFail (happyExpListPerState 31)

action_32 (87) = happyShift action_29
action_32 (88) = happyShift action_19
action_32 (89) = happyShift action_20
action_32 (90) = happyShift action_21
action_32 (5) = happyGoto action_36
action_32 (7) = happyGoto action_6
action_32 (8) = happyGoto action_7
action_32 (9) = happyGoto action_8
action_32 (10) = happyGoto action_9
action_32 (11) = happyGoto action_37
action_32 (76) = happyGoto action_17
action_32 _ = happyFail (happyExpListPerState 32)

action_33 (65) = happyGoto action_34
action_33 (86) = happyGoto action_35
action_33 _ = happyReduce_137

action_34 (87) = happyShift action_29
action_34 (5) = happyGoto action_96
action_34 (27) = happyGoto action_97
action_34 (28) = happyGoto action_98
action_34 _ = happyFail (happyExpListPerState 34)

action_35 (87) = happyShift action_29
action_35 (5) = happyGoto action_95
action_35 _ = happyFail (happyExpListPerState 35)

action_36 _ = happyReduce_8

action_37 _ = happyReduce_17

action_38 (87) = happyShift action_29
action_38 (90) = happyShift action_61
action_38 (92) = happyShift action_62
action_38 (102) = happyShift action_63
action_38 (5) = happyGoto action_50
action_38 (17) = happyGoto action_51
action_38 (18) = happyGoto action_52
action_38 (19) = happyGoto action_53
action_38 (20) = happyGoto action_54
action_38 (21) = happyGoto action_55
action_38 (22) = happyGoto action_56
action_38 (23) = happyGoto action_57
action_38 (24) = happyGoto action_94
action_38 (64) = happyGoto action_59
action_38 (77) = happyGoto action_60
action_38 _ = happyFail (happyExpListPerState 38)

action_39 (87) = happyShift action_29
action_39 (88) = happyShift action_86
action_39 (89) = happyShift action_87
action_39 (90) = happyShift action_88
action_39 (92) = happyShift action_89
action_39 (106) = happyShift action_90
action_39 (107) = happyShift action_91
action_39 (109) = happyShift action_92
action_39 (110) = happyShift action_93
action_39 (5) = happyGoto action_64
action_39 (30) = happyGoto action_65
action_39 (31) = happyGoto action_66
action_39 (34) = happyGoto action_67
action_39 (37) = happyGoto action_68
action_39 (38) = happyGoto action_69
action_39 (40) = happyGoto action_70
action_39 (41) = happyGoto action_71
action_39 (42) = happyGoto action_72
action_39 (43) = happyGoto action_73
action_39 (44) = happyGoto action_74
action_39 (45) = happyGoto action_75
action_39 (46) = happyGoto action_76
action_39 (47) = happyGoto action_77
action_39 (50) = happyGoto action_78
action_39 (52) = happyGoto action_79
action_39 (55) = happyGoto action_80
action_39 (56) = happyGoto action_81
action_39 (62) = happyGoto action_82
action_39 (63) = happyGoto action_83
action_39 (74) = happyGoto action_84
action_39 (75) = happyGoto action_85
action_39 _ = happyFail (happyExpListPerState 39)

action_40 _ = happyReduce_124

action_41 _ = happyReduce_119

action_42 (87) = happyShift action_29
action_42 (90) = happyShift action_61
action_42 (92) = happyShift action_62
action_42 (102) = happyShift action_63
action_42 (5) = happyGoto action_50
action_42 (17) = happyGoto action_51
action_42 (18) = happyGoto action_52
action_42 (19) = happyGoto action_53
action_42 (20) = happyGoto action_54
action_42 (21) = happyGoto action_55
action_42 (22) = happyGoto action_56
action_42 (23) = happyGoto action_57
action_42 (24) = happyGoto action_58
action_42 (64) = happyGoto action_59
action_42 (77) = happyGoto action_60
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (115) = happyShift action_47
action_43 (116) = happyShift action_48
action_43 (117) = happyShift action_49
action_43 (60) = happyGoto action_46
action_43 _ = happyFail (happyExpListPerState 43)

action_44 _ = happyReduce_99

action_45 _ = happyReduce_100

action_46 (89) = happyShift action_148
action_46 _ = happyFail (happyExpListPerState 46)

action_47 _ = happyReduce_101

action_48 _ = happyReduce_102

action_49 _ = happyReduce_103

action_50 _ = happyReduce_25

action_51 _ = happyReduce_28

action_52 _ = happyReduce_26

action_53 _ = happyReduce_29

action_54 (87) = happyShift action_29
action_54 (90) = happyShift action_61
action_54 (92) = happyShift action_62
action_54 (5) = happyGoto action_50
action_54 (17) = happyGoto action_51
action_54 (18) = happyGoto action_52
action_54 (19) = happyGoto action_147
action_54 (64) = happyGoto action_59
action_54 (77) = happyGoto action_60
action_54 _ = happyReduce_31

action_55 (96) = happyShift action_126
action_55 (101) = happyShift action_127
action_55 (6) = happyGoto action_146
action_55 _ = happyReduce_33

action_56 (100) = happyShift action_145
action_56 _ = happyReduce_34

action_57 _ = happyReduce_36

action_58 (91) = happyShift action_144
action_58 _ = happyFail (happyExpListPerState 58)

action_59 _ = happyReduce_24

action_60 _ = happyReduce_27

action_61 (87) = happyShift action_29
action_61 (90) = happyShift action_61
action_61 (92) = happyShift action_62
action_61 (5) = happyGoto action_50
action_61 (17) = happyGoto action_51
action_61 (18) = happyGoto action_52
action_61 (19) = happyGoto action_53
action_61 (20) = happyGoto action_54
action_61 (21) = happyGoto action_55
action_61 (22) = happyGoto action_56
action_61 (23) = happyGoto action_143
action_61 (64) = happyGoto action_59
action_61 (77) = happyGoto action_60
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (87) = happyShift action_29
action_62 (5) = happyGoto action_138
action_62 (15) = happyGoto action_139
action_62 (16) = happyGoto action_140
action_62 (73) = happyGoto action_141
action_62 (85) = happyGoto action_142
action_62 _ = happyFail (happyExpListPerState 62)

action_63 (87) = happyShift action_29
action_63 (5) = happyGoto action_136
action_63 (25) = happyGoto action_137
action_63 _ = happyFail (happyExpListPerState 63)

action_64 _ = happyReduce_48

action_65 _ = happyReduce_66

action_66 _ = happyReduce_65

action_67 _ = happyReduce_67

action_68 _ = happyReduce_68

action_69 _ = happyReduce_69

action_70 _ = happyReduce_70

action_71 _ = happyReduce_63

action_72 _ = happyReduce_64

action_73 _ = happyReduce_71

action_74 (87) = happyShift action_29
action_74 (88) = happyShift action_86
action_74 (89) = happyShift action_87
action_74 (90) = happyShift action_88
action_74 (92) = happyShift action_89
action_74 (106) = happyShift action_90
action_74 (107) = happyShift action_91
action_74 (109) = happyShift action_92
action_74 (110) = happyShift action_93
action_74 (5) = happyGoto action_64
action_74 (30) = happyGoto action_65
action_74 (31) = happyGoto action_66
action_74 (34) = happyGoto action_67
action_74 (37) = happyGoto action_68
action_74 (38) = happyGoto action_69
action_74 (40) = happyGoto action_70
action_74 (41) = happyGoto action_71
action_74 (42) = happyGoto action_72
action_74 (43) = happyGoto action_73
action_74 (44) = happyGoto action_132
action_74 (45) = happyGoto action_75
action_74 (46) = happyGoto action_76
action_74 (47) = happyGoto action_77
action_74 (50) = happyGoto action_78
action_74 (52) = happyGoto action_79
action_74 (55) = happyGoto action_80
action_74 (56) = happyGoto action_133
action_74 (62) = happyGoto action_82
action_74 (63) = happyGoto action_83
action_74 (66) = happyGoto action_134
action_74 (74) = happyGoto action_84
action_74 (75) = happyGoto action_85
action_74 (78) = happyGoto action_135
action_74 _ = happyReduce_74

action_75 _ = happyReduce_75

action_76 (96) = happyShift action_126
action_76 (101) = happyShift action_127
action_76 (6) = happyGoto action_131
action_76 _ = happyReduce_77

action_77 _ = happyReduce_85

action_78 _ = happyReduce_88

action_79 _ = happyReduce_95

action_80 _ = happyReduce_96

action_81 (99) = happyShift action_129
action_81 (103) = happyShift action_130
action_81 _ = happyFail (happyExpListPerState 81)

action_82 _ = happyReduce_52

action_83 _ = happyReduce_56

action_84 _ = happyReduce_72

action_85 _ = happyReduce_57

action_86 (103) = happyShift action_128
action_86 _ = happyFail (happyExpListPerState 86)

action_87 _ = happyReduce_47

action_88 (87) = happyShift action_29
action_88 (88) = happyShift action_86
action_88 (89) = happyShift action_87
action_88 (90) = happyShift action_88
action_88 (92) = happyShift action_89
action_88 (96) = happyShift action_126
action_88 (101) = happyShift action_127
action_88 (106) = happyShift action_90
action_88 (107) = happyShift action_91
action_88 (109) = happyShift action_92
action_88 (110) = happyShift action_93
action_88 (5) = happyGoto action_64
action_88 (6) = happyGoto action_123
action_88 (30) = happyGoto action_65
action_88 (31) = happyGoto action_66
action_88 (34) = happyGoto action_67
action_88 (37) = happyGoto action_68
action_88 (38) = happyGoto action_69
action_88 (39) = happyGoto action_124
action_88 (40) = happyGoto action_70
action_88 (41) = happyGoto action_71
action_88 (42) = happyGoto action_72
action_88 (43) = happyGoto action_73
action_88 (44) = happyGoto action_74
action_88 (45) = happyGoto action_75
action_88 (46) = happyGoto action_76
action_88 (47) = happyGoto action_77
action_88 (50) = happyGoto action_78
action_88 (52) = happyGoto action_79
action_88 (55) = happyGoto action_80
action_88 (56) = happyGoto action_125
action_88 (62) = happyGoto action_82
action_88 (63) = happyGoto action_83
action_88 (74) = happyGoto action_84
action_88 (75) = happyGoto action_85
action_88 _ = happyFail (happyExpListPerState 88)

action_89 (87) = happyShift action_29
action_89 (93) = happyShift action_122
action_89 (5) = happyGoto action_113
action_89 (32) = happyGoto action_114
action_89 (33) = happyGoto action_115
action_89 (35) = happyGoto action_116
action_89 (36) = happyGoto action_117
action_89 (70) = happyGoto action_118
action_89 (71) = happyGoto action_119
action_89 (82) = happyGoto action_120
action_89 (83) = happyGoto action_121
action_89 _ = happyFail (happyExpListPerState 89)

action_90 (87) = happyShift action_29
action_90 (90) = happyShift action_61
action_90 (92) = happyShift action_62
action_90 (5) = happyGoto action_50
action_90 (17) = happyGoto action_51
action_90 (18) = happyGoto action_52
action_90 (19) = happyGoto action_112
action_90 (64) = happyGoto action_59
action_90 (77) = happyGoto action_60
action_90 _ = happyFail (happyExpListPerState 90)

action_91 (87) = happyShift action_29
action_91 (88) = happyShift action_86
action_91 (89) = happyShift action_87
action_91 (90) = happyShift action_88
action_91 (92) = happyShift action_89
action_91 (97) = happyShift action_111
action_91 (106) = happyShift action_90
action_91 (107) = happyShift action_91
action_91 (109) = happyShift action_92
action_91 (110) = happyShift action_93
action_91 (5) = happyGoto action_64
action_91 (30) = happyGoto action_65
action_91 (31) = happyGoto action_66
action_91 (34) = happyGoto action_67
action_91 (37) = happyGoto action_68
action_91 (38) = happyGoto action_69
action_91 (40) = happyGoto action_70
action_91 (41) = happyGoto action_71
action_91 (42) = happyGoto action_72
action_91 (43) = happyGoto action_73
action_91 (44) = happyGoto action_74
action_91 (45) = happyGoto action_75
action_91 (46) = happyGoto action_76
action_91 (47) = happyGoto action_77
action_91 (50) = happyGoto action_78
action_91 (52) = happyGoto action_79
action_91 (55) = happyGoto action_80
action_91 (56) = happyGoto action_110
action_91 (62) = happyGoto action_82
action_91 (63) = happyGoto action_83
action_91 (74) = happyGoto action_84
action_91 (75) = happyGoto action_85
action_91 _ = happyFail (happyExpListPerState 91)

action_92 (87) = happyShift action_18
action_92 (88) = happyShift action_19
action_92 (89) = happyShift action_20
action_92 (90) = happyShift action_21
action_92 (5) = happyGoto action_24
action_92 (7) = happyGoto action_6
action_92 (8) = happyGoto action_7
action_92 (9) = happyGoto action_8
action_92 (10) = happyGoto action_9
action_92 (11) = happyGoto action_10
action_92 (12) = happyGoto action_11
action_92 (13) = happyGoto action_12
action_92 (14) = happyGoto action_106
action_92 (51) = happyGoto action_107
action_92 (72) = happyGoto action_108
action_92 (76) = happyGoto action_17
action_92 (84) = happyGoto action_109
action_92 _ = happyFail (happyExpListPerState 92)

action_93 (87) = happyShift action_18
action_93 (88) = happyShift action_19
action_93 (89) = happyShift action_20
action_93 (90) = happyShift action_21
action_93 (97) = happyShift action_105
action_93 (5) = happyGoto action_24
action_93 (7) = happyGoto action_6
action_93 (8) = happyGoto action_7
action_93 (9) = happyGoto action_8
action_93 (10) = happyGoto action_9
action_93 (11) = happyGoto action_10
action_93 (12) = happyGoto action_11
action_93 (13) = happyGoto action_12
action_93 (14) = happyGoto action_103
action_93 (53) = happyGoto action_104
action_93 (76) = happyGoto action_17
action_93 _ = happyFail (happyExpListPerState 93)

action_94 (99) = happyShift action_102
action_94 _ = happyFail (happyExpListPerState 94)

action_95 _ = happyReduce_138

action_96 (87) = happyShift action_29
action_96 (90) = happyShift action_61
action_96 (92) = happyShift action_62
action_96 (5) = happyGoto action_50
action_96 (17) = happyGoto action_51
action_96 (18) = happyGoto action_52
action_96 (19) = happyGoto action_53
action_96 (20) = happyGoto action_54
action_96 (21) = happyGoto action_55
action_96 (22) = happyGoto action_56
action_96 (23) = happyGoto action_100
action_96 (26) = happyGoto action_101
action_96 (64) = happyGoto action_59
action_96 (77) = happyGoto action_60
action_96 _ = happyReduce_42

action_97 _ = happyReduce_44

action_98 (95) = happyShift action_99
action_98 _ = happyReduce_46

action_99 (87) = happyShift action_29
action_99 (5) = happyGoto action_96
action_99 (27) = happyGoto action_182
action_99 _ = happyFail (happyExpListPerState 99)

action_100 _ = happyReduce_40

action_101 (95) = happyShift action_181
action_101 _ = happyReduce_43

action_102 _ = happyReduce_97

action_103 (105) = happyShift action_180
action_103 _ = happyFail (happyExpListPerState 103)

action_104 (111) = happyShift action_179
action_104 _ = happyFail (happyExpListPerState 104)

action_105 (87) = happyShift action_18
action_105 (88) = happyShift action_19
action_105 (89) = happyShift action_20
action_105 (90) = happyShift action_21
action_105 (5) = happyGoto action_24
action_105 (7) = happyGoto action_6
action_105 (8) = happyGoto action_7
action_105 (9) = happyGoto action_8
action_105 (10) = happyGoto action_9
action_105 (11) = happyGoto action_10
action_105 (12) = happyGoto action_11
action_105 (13) = happyGoto action_12
action_105 (14) = happyGoto action_103
action_105 (53) = happyGoto action_175
action_105 (54) = happyGoto action_176
action_105 (69) = happyGoto action_177
action_105 (76) = happyGoto action_17
action_105 (81) = happyGoto action_178
action_105 _ = happyFail (happyExpListPerState 105)

action_106 _ = happyReduce_133

action_107 (100) = happyShift action_174
action_107 _ = happyFail (happyExpListPerState 107)

action_108 _ = happyReduce_86

action_109 (95) = happyShift action_173
action_109 _ = happyReduce_115

action_110 (103) = happyShift action_130
action_110 (108) = happyShift action_172
action_110 _ = happyFail (happyExpListPerState 110)

action_111 (87) = happyShift action_29
action_111 (88) = happyShift action_86
action_111 (89) = happyShift action_87
action_111 (90) = happyShift action_88
action_111 (92) = happyShift action_89
action_111 (106) = happyShift action_90
action_111 (107) = happyShift action_91
action_111 (109) = happyShift action_92
action_111 (110) = happyShift action_93
action_111 (5) = happyGoto action_64
action_111 (30) = happyGoto action_65
action_111 (31) = happyGoto action_66
action_111 (34) = happyGoto action_67
action_111 (37) = happyGoto action_68
action_111 (38) = happyGoto action_69
action_111 (40) = happyGoto action_70
action_111 (41) = happyGoto action_71
action_111 (42) = happyGoto action_72
action_111 (43) = happyGoto action_73
action_111 (44) = happyGoto action_74
action_111 (45) = happyGoto action_75
action_111 (46) = happyGoto action_76
action_111 (47) = happyGoto action_77
action_111 (50) = happyGoto action_78
action_111 (52) = happyGoto action_79
action_111 (55) = happyGoto action_80
action_111 (56) = happyGoto action_171
action_111 (62) = happyGoto action_82
action_111 (63) = happyGoto action_83
action_111 (74) = happyGoto action_84
action_111 (75) = happyGoto action_85
action_111 _ = happyFail (happyExpListPerState 111)

action_112 _ = happyReduce_60

action_113 (94) = happyShift action_169
action_113 (105) = happyShift action_170
action_113 _ = happyReduce_50

action_114 _ = happyReduce_129

action_115 (93) = happyShift action_168
action_115 _ = happyFail (happyExpListPerState 115)

action_116 _ = happyReduce_131

action_117 (93) = happyShift action_167
action_117 _ = happyFail (happyExpListPerState 117)

action_118 _ = happyReduce_51

action_119 _ = happyReduce_55

action_120 (95) = happyShift action_166
action_120 _ = happyReduce_113

action_121 (95) = happyShift action_165
action_121 _ = happyReduce_114

action_122 _ = happyReduce_53

action_123 (91) = happyShift action_164
action_123 _ = happyFail (happyExpListPerState 123)

action_124 (91) = happyShift action_163
action_124 _ = happyFail (happyExpListPerState 124)

action_125 (94) = happyShift action_162
action_125 (103) = happyShift action_130
action_125 _ = happyReduce_58

action_126 (87) = happyShift action_161
action_126 _ = happyFail (happyExpListPerState 126)

action_127 _ = happyReduce_6

action_128 (87) = happyShift action_29
action_128 (5) = happyGoto action_160
action_128 _ = happyFail (happyExpListPerState 128)

action_129 _ = happyReduce_98

action_130 (87) = happyShift action_29
action_130 (5) = happyGoto action_159
action_130 _ = happyFail (happyExpListPerState 130)

action_131 (87) = happyShift action_29
action_131 (88) = happyShift action_86
action_131 (89) = happyShift action_87
action_131 (90) = happyShift action_88
action_131 (92) = happyShift action_89
action_131 (106) = happyShift action_90
action_131 (107) = happyShift action_91
action_131 (109) = happyShift action_92
action_131 (110) = happyShift action_93
action_131 (5) = happyGoto action_64
action_131 (30) = happyGoto action_65
action_131 (31) = happyGoto action_66
action_131 (34) = happyGoto action_67
action_131 (37) = happyGoto action_68
action_131 (38) = happyGoto action_69
action_131 (40) = happyGoto action_70
action_131 (41) = happyGoto action_71
action_131 (42) = happyGoto action_72
action_131 (43) = happyGoto action_73
action_131 (44) = happyGoto action_74
action_131 (45) = happyGoto action_158
action_131 (46) = happyGoto action_76
action_131 (47) = happyGoto action_77
action_131 (50) = happyGoto action_78
action_131 (52) = happyGoto action_79
action_131 (55) = happyGoto action_80
action_131 (56) = happyGoto action_133
action_131 (62) = happyGoto action_82
action_131 (63) = happyGoto action_83
action_131 (74) = happyGoto action_84
action_131 (75) = happyGoto action_85
action_131 _ = happyFail (happyExpListPerState 131)

action_132 (87) = happyShift action_29
action_132 (88) = happyShift action_86
action_132 (89) = happyShift action_87
action_132 (90) = happyShift action_88
action_132 (92) = happyShift action_89
action_132 (96) = happyReduce_121
action_132 (101) = happyReduce_121
action_132 (103) = happyReduce_121
action_132 (106) = happyShift action_90
action_132 (107) = happyShift action_91
action_132 (109) = happyShift action_92
action_132 (110) = happyShift action_93
action_132 (5) = happyGoto action_64
action_132 (30) = happyGoto action_65
action_132 (31) = happyGoto action_66
action_132 (34) = happyGoto action_67
action_132 (37) = happyGoto action_68
action_132 (38) = happyGoto action_69
action_132 (40) = happyGoto action_70
action_132 (41) = happyGoto action_71
action_132 (42) = happyGoto action_72
action_132 (43) = happyGoto action_73
action_132 (44) = happyGoto action_132
action_132 (45) = happyGoto action_75
action_132 (46) = happyGoto action_76
action_132 (47) = happyGoto action_77
action_132 (50) = happyGoto action_78
action_132 (52) = happyGoto action_79
action_132 (55) = happyGoto action_80
action_132 (56) = happyGoto action_133
action_132 (62) = happyGoto action_82
action_132 (63) = happyGoto action_83
action_132 (66) = happyGoto action_134
action_132 (74) = happyGoto action_84
action_132 (75) = happyGoto action_85
action_132 (78) = happyGoto action_135
action_132 _ = happyReduce_121

action_133 (103) = happyShift action_130
action_133 _ = happyFail (happyExpListPerState 133)

action_134 _ = happyReduce_73

action_135 (87) = happyShift action_29
action_135 (88) = happyShift action_86
action_135 (89) = happyShift action_87
action_135 (90) = happyShift action_88
action_135 (92) = happyShift action_89
action_135 (106) = happyShift action_90
action_135 (107) = happyShift action_91
action_135 (109) = happyShift action_92
action_135 (110) = happyShift action_93
action_135 (5) = happyGoto action_64
action_135 (30) = happyGoto action_65
action_135 (31) = happyGoto action_66
action_135 (34) = happyGoto action_67
action_135 (37) = happyGoto action_68
action_135 (38) = happyGoto action_69
action_135 (40) = happyGoto action_70
action_135 (41) = happyGoto action_71
action_135 (42) = happyGoto action_72
action_135 (43) = happyGoto action_73
action_135 (44) = happyGoto action_157
action_135 (45) = happyGoto action_75
action_135 (46) = happyGoto action_76
action_135 (47) = happyGoto action_77
action_135 (50) = happyGoto action_78
action_135 (52) = happyGoto action_79
action_135 (55) = happyGoto action_80
action_135 (56) = happyGoto action_133
action_135 (62) = happyGoto action_82
action_135 (63) = happyGoto action_83
action_135 (74) = happyGoto action_84
action_135 (75) = happyGoto action_85
action_135 _ = happyReduce_109

action_136 _ = happyReduce_38

action_137 (87) = happyShift action_29
action_137 (103) = happyShift action_156
action_137 (5) = happyGoto action_155
action_137 _ = happyFail (happyExpListPerState 137)

action_138 (94) = happyShift action_154
action_138 _ = happyFail (happyExpListPerState 138)

action_139 _ = happyReduce_135

action_140 (93) = happyShift action_153
action_140 _ = happyFail (happyExpListPerState 140)

action_141 _ = happyReduce_23

action_142 (95) = happyShift action_152
action_142 _ = happyReduce_116

action_143 (91) = happyShift action_151
action_143 _ = happyFail (happyExpListPerState 143)

action_144 _ = happyReduce_11

action_145 (87) = happyShift action_29
action_145 (90) = happyShift action_61
action_145 (92) = happyShift action_62
action_145 (5) = happyGoto action_50
action_145 (17) = happyGoto action_51
action_145 (18) = happyGoto action_52
action_145 (19) = happyGoto action_53
action_145 (20) = happyGoto action_54
action_145 (21) = happyGoto action_55
action_145 (22) = happyGoto action_56
action_145 (23) = happyGoto action_150
action_145 (64) = happyGoto action_59
action_145 (77) = happyGoto action_60
action_145 _ = happyFail (happyExpListPerState 145)

action_146 (87) = happyShift action_29
action_146 (90) = happyShift action_61
action_146 (92) = happyShift action_62
action_146 (5) = happyGoto action_50
action_146 (17) = happyGoto action_51
action_146 (18) = happyGoto action_52
action_146 (19) = happyGoto action_53
action_146 (20) = happyGoto action_149
action_146 (64) = happyGoto action_59
action_146 (77) = happyGoto action_60
action_146 _ = happyFail (happyExpListPerState 146)

action_147 _ = happyReduce_30

action_148 _ = happyReduce_104

action_149 (87) = happyShift action_29
action_149 (90) = happyShift action_61
action_149 (92) = happyShift action_62
action_149 (5) = happyGoto action_50
action_149 (17) = happyGoto action_51
action_149 (18) = happyGoto action_52
action_149 (19) = happyGoto action_147
action_149 (64) = happyGoto action_59
action_149 (77) = happyGoto action_60
action_149 _ = happyReduce_32

action_150 _ = happyReduce_35

action_151 _ = happyReduce_120

action_152 (87) = happyShift action_29
action_152 (5) = happyGoto action_138
action_152 (15) = happyGoto action_208
action_152 _ = happyFail (happyExpListPerState 152)

action_153 _ = happyReduce_107

action_154 (87) = happyShift action_29
action_154 (90) = happyShift action_61
action_154 (92) = happyShift action_62
action_154 (5) = happyGoto action_50
action_154 (17) = happyGoto action_51
action_154 (18) = happyGoto action_52
action_154 (19) = happyGoto action_53
action_154 (20) = happyGoto action_54
action_154 (21) = happyGoto action_55
action_154 (22) = happyGoto action_56
action_154 (23) = happyGoto action_207
action_154 (64) = happyGoto action_59
action_154 (77) = happyGoto action_60
action_154 _ = happyFail (happyExpListPerState 154)

action_155 _ = happyReduce_39

action_156 (87) = happyShift action_29
action_156 (90) = happyShift action_61
action_156 (92) = happyShift action_62
action_156 (5) = happyGoto action_50
action_156 (17) = happyGoto action_51
action_156 (18) = happyGoto action_52
action_156 (19) = happyGoto action_53
action_156 (20) = happyGoto action_54
action_156 (21) = happyGoto action_55
action_156 (22) = happyGoto action_56
action_156 (23) = happyGoto action_206
action_156 (64) = happyGoto action_59
action_156 (77) = happyGoto action_60
action_156 _ = happyFail (happyExpListPerState 156)

action_157 (87) = happyShift action_29
action_157 (88) = happyShift action_86
action_157 (89) = happyShift action_87
action_157 (90) = happyShift action_88
action_157 (92) = happyShift action_89
action_157 (96) = happyReduce_122
action_157 (101) = happyReduce_122
action_157 (103) = happyReduce_122
action_157 (106) = happyShift action_90
action_157 (107) = happyShift action_91
action_157 (109) = happyShift action_92
action_157 (110) = happyShift action_93
action_157 (5) = happyGoto action_64
action_157 (30) = happyGoto action_65
action_157 (31) = happyGoto action_66
action_157 (34) = happyGoto action_67
action_157 (37) = happyGoto action_68
action_157 (38) = happyGoto action_69
action_157 (40) = happyGoto action_70
action_157 (41) = happyGoto action_71
action_157 (42) = happyGoto action_72
action_157 (43) = happyGoto action_73
action_157 (44) = happyGoto action_132
action_157 (45) = happyGoto action_75
action_157 (46) = happyGoto action_76
action_157 (47) = happyGoto action_77
action_157 (50) = happyGoto action_78
action_157 (52) = happyGoto action_79
action_157 (55) = happyGoto action_80
action_157 (56) = happyGoto action_133
action_157 (62) = happyGoto action_82
action_157 (63) = happyGoto action_83
action_157 (66) = happyGoto action_134
action_157 (74) = happyGoto action_84
action_157 (75) = happyGoto action_85
action_157 (78) = happyGoto action_135
action_157 _ = happyReduce_122

action_158 (96) = happyReduce_76
action_158 (101) = happyReduce_76
action_158 (103) = happyReduce_76
action_158 _ = happyReduce_76

action_159 _ = happyReduce_61

action_160 _ = happyReduce_62

action_161 (96) = happyShift action_205
action_161 _ = happyFail (happyExpListPerState 161)

action_162 (87) = happyShift action_29
action_162 (90) = happyShift action_61
action_162 (92) = happyShift action_62
action_162 (102) = happyShift action_63
action_162 (5) = happyGoto action_50
action_162 (17) = happyGoto action_51
action_162 (18) = happyGoto action_52
action_162 (19) = happyGoto action_53
action_162 (20) = happyGoto action_54
action_162 (21) = happyGoto action_55
action_162 (22) = happyGoto action_56
action_162 (23) = happyGoto action_57
action_162 (24) = happyGoto action_204
action_162 (64) = happyGoto action_59
action_162 (77) = happyGoto action_60
action_162 _ = happyFail (happyExpListPerState 162)

action_163 _ = happyReduce_117

action_164 _ = happyReduce_118

action_165 (87) = happyShift action_29
action_165 (5) = happyGoto action_202
action_165 (35) = happyGoto action_203
action_165 _ = happyFail (happyExpListPerState 165)

action_166 (87) = happyShift action_29
action_166 (5) = happyGoto action_200
action_166 (32) = happyGoto action_201
action_166 _ = happyFail (happyExpListPerState 166)

action_167 _ = happyReduce_106

action_168 _ = happyReduce_105

action_169 (87) = happyShift action_29
action_169 (88) = happyShift action_86
action_169 (89) = happyShift action_87
action_169 (90) = happyShift action_88
action_169 (92) = happyShift action_89
action_169 (106) = happyShift action_90
action_169 (107) = happyShift action_91
action_169 (109) = happyShift action_92
action_169 (110) = happyShift action_93
action_169 (5) = happyGoto action_64
action_169 (30) = happyGoto action_65
action_169 (31) = happyGoto action_66
action_169 (34) = happyGoto action_67
action_169 (37) = happyGoto action_68
action_169 (38) = happyGoto action_69
action_169 (40) = happyGoto action_70
action_169 (41) = happyGoto action_71
action_169 (42) = happyGoto action_72
action_169 (43) = happyGoto action_73
action_169 (44) = happyGoto action_74
action_169 (45) = happyGoto action_75
action_169 (46) = happyGoto action_76
action_169 (47) = happyGoto action_77
action_169 (50) = happyGoto action_78
action_169 (52) = happyGoto action_79
action_169 (55) = happyGoto action_80
action_169 (56) = happyGoto action_199
action_169 (62) = happyGoto action_82
action_169 (63) = happyGoto action_83
action_169 (74) = happyGoto action_84
action_169 (75) = happyGoto action_85
action_169 _ = happyFail (happyExpListPerState 169)

action_170 (87) = happyShift action_29
action_170 (88) = happyShift action_86
action_170 (89) = happyShift action_87
action_170 (90) = happyShift action_88
action_170 (92) = happyShift action_89
action_170 (106) = happyShift action_90
action_170 (107) = happyShift action_91
action_170 (109) = happyShift action_92
action_170 (110) = happyShift action_93
action_170 (5) = happyGoto action_64
action_170 (30) = happyGoto action_65
action_170 (31) = happyGoto action_66
action_170 (34) = happyGoto action_67
action_170 (37) = happyGoto action_68
action_170 (38) = happyGoto action_69
action_170 (40) = happyGoto action_70
action_170 (41) = happyGoto action_71
action_170 (42) = happyGoto action_72
action_170 (43) = happyGoto action_73
action_170 (44) = happyGoto action_74
action_170 (45) = happyGoto action_75
action_170 (46) = happyGoto action_76
action_170 (47) = happyGoto action_77
action_170 (50) = happyGoto action_78
action_170 (52) = happyGoto action_79
action_170 (55) = happyGoto action_80
action_170 (56) = happyGoto action_198
action_170 (62) = happyGoto action_82
action_170 (63) = happyGoto action_83
action_170 (74) = happyGoto action_84
action_170 (75) = happyGoto action_85
action_170 _ = happyFail (happyExpListPerState 170)

action_171 (99) = happyShift action_197
action_171 (103) = happyShift action_130
action_171 _ = happyFail (happyExpListPerState 171)

action_172 (87) = happyShift action_18
action_172 (88) = happyShift action_19
action_172 (89) = happyShift action_20
action_172 (90) = happyShift action_21
action_172 (97) = happyShift action_196
action_172 (5) = happyGoto action_24
action_172 (7) = happyGoto action_6
action_172 (8) = happyGoto action_7
action_172 (9) = happyGoto action_8
action_172 (10) = happyGoto action_9
action_172 (11) = happyGoto action_10
action_172 (12) = happyGoto action_11
action_172 (13) = happyGoto action_12
action_172 (14) = happyGoto action_191
action_172 (48) = happyGoto action_192
action_172 (49) = happyGoto action_193
action_172 (68) = happyGoto action_194
action_172 (76) = happyGoto action_17
action_172 (80) = happyGoto action_195
action_172 _ = happyFail (happyExpListPerState 172)

action_173 (87) = happyShift action_18
action_173 (88) = happyShift action_19
action_173 (89) = happyShift action_20
action_173 (90) = happyShift action_21
action_173 (5) = happyGoto action_24
action_173 (7) = happyGoto action_6
action_173 (8) = happyGoto action_7
action_173 (9) = happyGoto action_8
action_173 (10) = happyGoto action_9
action_173 (11) = happyGoto action_10
action_173 (12) = happyGoto action_11
action_173 (13) = happyGoto action_12
action_173 (14) = happyGoto action_190
action_173 (76) = happyGoto action_17
action_173 _ = happyFail (happyExpListPerState 173)

action_174 (87) = happyShift action_29
action_174 (88) = happyShift action_86
action_174 (89) = happyShift action_87
action_174 (90) = happyShift action_88
action_174 (92) = happyShift action_89
action_174 (106) = happyShift action_90
action_174 (107) = happyShift action_91
action_174 (109) = happyShift action_92
action_174 (110) = happyShift action_93
action_174 (5) = happyGoto action_64
action_174 (30) = happyGoto action_65
action_174 (31) = happyGoto action_66
action_174 (34) = happyGoto action_67
action_174 (37) = happyGoto action_68
action_174 (38) = happyGoto action_69
action_174 (40) = happyGoto action_70
action_174 (41) = happyGoto action_71
action_174 (42) = happyGoto action_72
action_174 (43) = happyGoto action_73
action_174 (44) = happyGoto action_74
action_174 (45) = happyGoto action_75
action_174 (46) = happyGoto action_76
action_174 (47) = happyGoto action_77
action_174 (50) = happyGoto action_78
action_174 (52) = happyGoto action_79
action_174 (55) = happyGoto action_80
action_174 (56) = happyGoto action_189
action_174 (62) = happyGoto action_82
action_174 (63) = happyGoto action_83
action_174 (74) = happyGoto action_84
action_174 (75) = happyGoto action_85
action_174 _ = happyFail (happyExpListPerState 174)

action_175 _ = happyReduce_127

action_176 (99) = happyShift action_188
action_176 _ = happyFail (happyExpListPerState 176)

action_177 _ = happyReduce_90

action_178 (98) = happyShift action_187
action_178 _ = happyReduce_112

action_179 (87) = happyShift action_29
action_179 (88) = happyShift action_86
action_179 (89) = happyShift action_87
action_179 (90) = happyShift action_88
action_179 (92) = happyShift action_89
action_179 (97) = happyShift action_186
action_179 (106) = happyShift action_90
action_179 (107) = happyShift action_91
action_179 (109) = happyShift action_92
action_179 (110) = happyShift action_93
action_179 (5) = happyGoto action_64
action_179 (30) = happyGoto action_65
action_179 (31) = happyGoto action_66
action_179 (34) = happyGoto action_67
action_179 (37) = happyGoto action_68
action_179 (38) = happyGoto action_69
action_179 (40) = happyGoto action_70
action_179 (41) = happyGoto action_71
action_179 (42) = happyGoto action_72
action_179 (43) = happyGoto action_73
action_179 (44) = happyGoto action_74
action_179 (45) = happyGoto action_75
action_179 (46) = happyGoto action_76
action_179 (47) = happyGoto action_77
action_179 (50) = happyGoto action_78
action_179 (52) = happyGoto action_79
action_179 (55) = happyGoto action_80
action_179 (56) = happyGoto action_185
action_179 (62) = happyGoto action_82
action_179 (63) = happyGoto action_83
action_179 (74) = happyGoto action_84
action_179 (75) = happyGoto action_85
action_179 _ = happyFail (happyExpListPerState 179)

action_180 (87) = happyShift action_29
action_180 (88) = happyShift action_86
action_180 (89) = happyShift action_87
action_180 (90) = happyShift action_88
action_180 (92) = happyShift action_89
action_180 (106) = happyShift action_90
action_180 (107) = happyShift action_91
action_180 (109) = happyShift action_92
action_180 (110) = happyShift action_93
action_180 (5) = happyGoto action_64
action_180 (30) = happyGoto action_65
action_180 (31) = happyGoto action_66
action_180 (34) = happyGoto action_67
action_180 (37) = happyGoto action_68
action_180 (38) = happyGoto action_69
action_180 (40) = happyGoto action_70
action_180 (41) = happyGoto action_71
action_180 (42) = happyGoto action_72
action_180 (43) = happyGoto action_73
action_180 (44) = happyGoto action_74
action_180 (45) = happyGoto action_75
action_180 (46) = happyGoto action_76
action_180 (47) = happyGoto action_77
action_180 (50) = happyGoto action_78
action_180 (52) = happyGoto action_79
action_180 (55) = happyGoto action_80
action_180 (56) = happyGoto action_184
action_180 (62) = happyGoto action_82
action_180 (63) = happyGoto action_83
action_180 (74) = happyGoto action_84
action_180 (75) = happyGoto action_85
action_180 _ = happyFail (happyExpListPerState 180)

action_181 (87) = happyShift action_29
action_181 (90) = happyShift action_61
action_181 (92) = happyShift action_62
action_181 (5) = happyGoto action_50
action_181 (17) = happyGoto action_51
action_181 (18) = happyGoto action_52
action_181 (19) = happyGoto action_53
action_181 (20) = happyGoto action_54
action_181 (21) = happyGoto action_55
action_181 (22) = happyGoto action_56
action_181 (23) = happyGoto action_183
action_181 (64) = happyGoto action_59
action_181 (77) = happyGoto action_60
action_181 _ = happyFail (happyExpListPerState 181)

action_182 _ = happyReduce_45

action_183 _ = happyReduce_41

action_184 (103) = happyShift action_130
action_184 _ = happyReduce_89

action_185 (103) = happyShift action_130
action_185 _ = happyReduce_94

action_186 (87) = happyShift action_29
action_186 (88) = happyShift action_86
action_186 (89) = happyShift action_87
action_186 (90) = happyShift action_88
action_186 (92) = happyShift action_89
action_186 (106) = happyShift action_90
action_186 (107) = happyShift action_91
action_186 (109) = happyShift action_92
action_186 (110) = happyShift action_93
action_186 (5) = happyGoto action_64
action_186 (30) = happyGoto action_65
action_186 (31) = happyGoto action_66
action_186 (34) = happyGoto action_67
action_186 (37) = happyGoto action_68
action_186 (38) = happyGoto action_69
action_186 (40) = happyGoto action_70
action_186 (41) = happyGoto action_71
action_186 (42) = happyGoto action_72
action_186 (43) = happyGoto action_73
action_186 (44) = happyGoto action_74
action_186 (45) = happyGoto action_75
action_186 (46) = happyGoto action_76
action_186 (47) = happyGoto action_77
action_186 (50) = happyGoto action_78
action_186 (52) = happyGoto action_79
action_186 (55) = happyGoto action_80
action_186 (56) = happyGoto action_215
action_186 (62) = happyGoto action_82
action_186 (63) = happyGoto action_83
action_186 (74) = happyGoto action_84
action_186 (75) = happyGoto action_85
action_186 _ = happyFail (happyExpListPerState 186)

action_187 (87) = happyShift action_18
action_187 (88) = happyShift action_19
action_187 (89) = happyShift action_20
action_187 (90) = happyShift action_21
action_187 (5) = happyGoto action_24
action_187 (7) = happyGoto action_6
action_187 (8) = happyGoto action_7
action_187 (9) = happyGoto action_8
action_187 (10) = happyGoto action_9
action_187 (11) = happyGoto action_10
action_187 (12) = happyGoto action_11
action_187 (13) = happyGoto action_12
action_187 (14) = happyGoto action_103
action_187 (53) = happyGoto action_214
action_187 (76) = happyGoto action_17
action_187 _ = happyFail (happyExpListPerState 187)

action_188 (111) = happyShift action_213
action_188 _ = happyFail (happyExpListPerState 188)

action_189 (103) = happyShift action_130
action_189 _ = happyReduce_87

action_190 _ = happyReduce_134

action_191 (100) = happyShift action_212
action_191 _ = happyFail (happyExpListPerState 191)

action_192 _ = happyReduce_125

action_193 _ = happyReduce_81

action_194 _ = happyReduce_80

action_195 (98) = happyShift action_211
action_195 _ = happyReduce_111

action_196 (87) = happyShift action_18
action_196 (88) = happyShift action_19
action_196 (89) = happyShift action_20
action_196 (90) = happyShift action_21
action_196 (5) = happyGoto action_24
action_196 (7) = happyGoto action_6
action_196 (8) = happyGoto action_7
action_196 (9) = happyGoto action_8
action_196 (10) = happyGoto action_9
action_196 (11) = happyGoto action_10
action_196 (12) = happyGoto action_11
action_196 (13) = happyGoto action_12
action_196 (14) = happyGoto action_191
action_196 (48) = happyGoto action_192
action_196 (49) = happyGoto action_210
action_196 (68) = happyGoto action_194
action_196 (76) = happyGoto action_17
action_196 (80) = happyGoto action_195
action_196 _ = happyFail (happyExpListPerState 196)

action_197 (108) = happyShift action_209
action_197 _ = happyFail (happyExpListPerState 197)

action_198 (103) = happyShift action_130
action_198 _ = happyReduce_54

action_199 (103) = happyShift action_130
action_199 _ = happyReduce_49

action_200 (94) = happyShift action_169
action_200 _ = happyReduce_50

action_201 _ = happyReduce_130

action_202 (105) = happyShift action_170
action_202 _ = happyFail (happyExpListPerState 202)

action_203 _ = happyReduce_132

action_204 _ = happyReduce_59

action_205 _ = happyReduce_7

action_206 _ = happyReduce_37

action_207 _ = happyReduce_22

action_208 _ = happyReduce_136

action_209 (87) = happyShift action_18
action_209 (88) = happyShift action_19
action_209 (89) = happyShift action_20
action_209 (90) = happyShift action_21
action_209 (97) = happyShift action_224
action_209 (5) = happyGoto action_24
action_209 (7) = happyGoto action_6
action_209 (8) = happyGoto action_7
action_209 (9) = happyGoto action_8
action_209 (10) = happyGoto action_9
action_209 (11) = happyGoto action_10
action_209 (12) = happyGoto action_11
action_209 (13) = happyGoto action_12
action_209 (14) = happyGoto action_191
action_209 (48) = happyGoto action_192
action_209 (49) = happyGoto action_223
action_209 (68) = happyGoto action_194
action_209 (76) = happyGoto action_17
action_209 (80) = happyGoto action_195
action_209 _ = happyFail (happyExpListPerState 209)

action_210 (99) = happyShift action_222
action_210 _ = happyFail (happyExpListPerState 210)

action_211 (87) = happyShift action_18
action_211 (88) = happyShift action_19
action_211 (89) = happyShift action_20
action_211 (90) = happyShift action_21
action_211 (5) = happyGoto action_24
action_211 (7) = happyGoto action_6
action_211 (8) = happyGoto action_7
action_211 (9) = happyGoto action_8
action_211 (10) = happyGoto action_9
action_211 (11) = happyGoto action_10
action_211 (12) = happyGoto action_11
action_211 (13) = happyGoto action_12
action_211 (14) = happyGoto action_191
action_211 (48) = happyGoto action_221
action_211 (76) = happyGoto action_17
action_211 _ = happyFail (happyExpListPerState 211)

action_212 (87) = happyShift action_29
action_212 (88) = happyShift action_86
action_212 (89) = happyShift action_87
action_212 (90) = happyShift action_88
action_212 (92) = happyShift action_89
action_212 (97) = happyShift action_220
action_212 (106) = happyShift action_90
action_212 (107) = happyShift action_91
action_212 (109) = happyShift action_92
action_212 (110) = happyShift action_93
action_212 (5) = happyGoto action_64
action_212 (30) = happyGoto action_65
action_212 (31) = happyGoto action_66
action_212 (34) = happyGoto action_67
action_212 (37) = happyGoto action_68
action_212 (38) = happyGoto action_69
action_212 (40) = happyGoto action_70
action_212 (41) = happyGoto action_71
action_212 (42) = happyGoto action_72
action_212 (43) = happyGoto action_73
action_212 (44) = happyGoto action_74
action_212 (45) = happyGoto action_75
action_212 (46) = happyGoto action_76
action_212 (47) = happyGoto action_77
action_212 (50) = happyGoto action_78
action_212 (52) = happyGoto action_79
action_212 (55) = happyGoto action_80
action_212 (56) = happyGoto action_219
action_212 (62) = happyGoto action_82
action_212 (63) = happyGoto action_83
action_212 (74) = happyGoto action_84
action_212 (75) = happyGoto action_85
action_212 _ = happyFail (happyExpListPerState 212)

action_213 (87) = happyShift action_29
action_213 (88) = happyShift action_86
action_213 (89) = happyShift action_87
action_213 (90) = happyShift action_88
action_213 (92) = happyShift action_89
action_213 (97) = happyShift action_218
action_213 (106) = happyShift action_90
action_213 (107) = happyShift action_91
action_213 (109) = happyShift action_92
action_213 (110) = happyShift action_93
action_213 (5) = happyGoto action_64
action_213 (30) = happyGoto action_65
action_213 (31) = happyGoto action_66
action_213 (34) = happyGoto action_67
action_213 (37) = happyGoto action_68
action_213 (38) = happyGoto action_69
action_213 (40) = happyGoto action_70
action_213 (41) = happyGoto action_71
action_213 (42) = happyGoto action_72
action_213 (43) = happyGoto action_73
action_213 (44) = happyGoto action_74
action_213 (45) = happyGoto action_75
action_213 (46) = happyGoto action_76
action_213 (47) = happyGoto action_77
action_213 (50) = happyGoto action_78
action_213 (52) = happyGoto action_79
action_213 (55) = happyGoto action_80
action_213 (56) = happyGoto action_217
action_213 (62) = happyGoto action_82
action_213 (63) = happyGoto action_83
action_213 (74) = happyGoto action_84
action_213 (75) = happyGoto action_85
action_213 _ = happyFail (happyExpListPerState 213)

action_214 _ = happyReduce_128

action_215 (99) = happyShift action_216
action_215 (103) = happyShift action_130
action_215 _ = happyFail (happyExpListPerState 215)

action_216 _ = happyReduce_93

action_217 (103) = happyShift action_130
action_217 _ = happyReduce_92

action_218 (87) = happyShift action_29
action_218 (88) = happyShift action_86
action_218 (89) = happyShift action_87
action_218 (90) = happyShift action_88
action_218 (92) = happyShift action_89
action_218 (106) = happyShift action_90
action_218 (107) = happyShift action_91
action_218 (109) = happyShift action_92
action_218 (110) = happyShift action_93
action_218 (5) = happyGoto action_64
action_218 (30) = happyGoto action_65
action_218 (31) = happyGoto action_66
action_218 (34) = happyGoto action_67
action_218 (37) = happyGoto action_68
action_218 (38) = happyGoto action_69
action_218 (40) = happyGoto action_70
action_218 (41) = happyGoto action_71
action_218 (42) = happyGoto action_72
action_218 (43) = happyGoto action_73
action_218 (44) = happyGoto action_74
action_218 (45) = happyGoto action_75
action_218 (46) = happyGoto action_76
action_218 (47) = happyGoto action_77
action_218 (50) = happyGoto action_78
action_218 (52) = happyGoto action_79
action_218 (55) = happyGoto action_80
action_218 (56) = happyGoto action_227
action_218 (62) = happyGoto action_82
action_218 (63) = happyGoto action_83
action_218 (74) = happyGoto action_84
action_218 (75) = happyGoto action_85
action_218 _ = happyFail (happyExpListPerState 218)

action_219 (103) = happyShift action_130
action_219 _ = happyReduce_78

action_220 (87) = happyShift action_29
action_220 (88) = happyShift action_86
action_220 (89) = happyShift action_87
action_220 (90) = happyShift action_88
action_220 (92) = happyShift action_89
action_220 (106) = happyShift action_90
action_220 (107) = happyShift action_91
action_220 (109) = happyShift action_92
action_220 (110) = happyShift action_93
action_220 (5) = happyGoto action_64
action_220 (30) = happyGoto action_65
action_220 (31) = happyGoto action_66
action_220 (34) = happyGoto action_67
action_220 (37) = happyGoto action_68
action_220 (38) = happyGoto action_69
action_220 (40) = happyGoto action_70
action_220 (41) = happyGoto action_71
action_220 (42) = happyGoto action_72
action_220 (43) = happyGoto action_73
action_220 (44) = happyGoto action_74
action_220 (45) = happyGoto action_75
action_220 (46) = happyGoto action_76
action_220 (47) = happyGoto action_77
action_220 (50) = happyGoto action_78
action_220 (52) = happyGoto action_79
action_220 (55) = happyGoto action_80
action_220 (56) = happyGoto action_226
action_220 (62) = happyGoto action_82
action_220 (63) = happyGoto action_83
action_220 (74) = happyGoto action_84
action_220 (75) = happyGoto action_85
action_220 _ = happyFail (happyExpListPerState 220)

action_221 _ = happyReduce_126

action_222 _ = happyReduce_83

action_223 _ = happyReduce_82

action_224 (87) = happyShift action_18
action_224 (88) = happyShift action_19
action_224 (89) = happyShift action_20
action_224 (90) = happyShift action_21
action_224 (5) = happyGoto action_24
action_224 (7) = happyGoto action_6
action_224 (8) = happyGoto action_7
action_224 (9) = happyGoto action_8
action_224 (10) = happyGoto action_9
action_224 (11) = happyGoto action_10
action_224 (12) = happyGoto action_11
action_224 (13) = happyGoto action_12
action_224 (14) = happyGoto action_191
action_224 (48) = happyGoto action_192
action_224 (49) = happyGoto action_225
action_224 (68) = happyGoto action_194
action_224 (76) = happyGoto action_17
action_224 (80) = happyGoto action_195
action_224 _ = happyFail (happyExpListPerState 224)

action_225 (99) = happyShift action_230
action_225 _ = happyFail (happyExpListPerState 225)

action_226 (99) = happyShift action_229
action_226 (103) = happyShift action_130
action_226 _ = happyFail (happyExpListPerState 226)

action_227 (99) = happyShift action_228
action_227 (103) = happyShift action_130
action_227 _ = happyFail (happyExpListPerState 227)

action_228 _ = happyReduce_91

action_229 _ = happyReduce_79

action_230 _ = happyReduce_84

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
happyReduction_15 (HappyAbsSyn76  happy_var_1)
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
happyReduction_23 (HappyAbsSyn73  happy_var_1)
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
happyReduction_27 (HappyAbsSyn77  happy_var_1)
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
happyReduction_44 (HappyAbsSyn27  happy_var_1)
	 =  HappyAbsSyn28
		 (happy_var_1:|[]
	)
happyReduction_44 _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_3  28 happyReduction_45
happyReduction_45 (HappyAbsSyn27  happy_var_3)
	_
	(HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (cons happy_var_3 happy_var_1
	)
happyReduction_45 _ _ _  = notHappyAtAll 

happyReduce_46 = happyReduce 4 29 happyReduction_46
happyReduction_46 ((HappyAbsSyn28  happy_var_4) `HappyStk`
	(HappyAbsSyn65  happy_var_3) `HappyStk`
	(HappyAbsSyn5  happy_var_2) `HappyStk`
	(HappyTerminal (Data happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (ModuleDataType (getRange (happy_var_1,happy_var_4)) happy_var_2 happy_var_3 happy_var_4
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
happyReduction_51 (HappyAbsSyn70  happy_var_1)
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
happyReduction_55 (HappyAbsSyn71  happy_var_1)
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
happyReduction_57 (HappyAbsSyn75  happy_var_1)
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

happyReduce_61 = happySpecReduce_3  41 happyReduction_61
happyReduction_61 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (Accessor (getRange (happy_var_1,happy_var_3)) happy_var_1 happy_var_3
	)
happyReduction_61 _ _ _  = notHappyAtAll 

happyReduce_62 = happySpecReduce_3  42 happyReduction_62
happyReduction_62 (HappyAbsSyn5  happy_var_3)
	_
	(HappyTerminal (Hole happy_var_1))
	 =  HappyAbsSyn30
		 (AccessorFunction (getRange (happy_var_1,happy_var_3)) happy_var_3
	)
happyReduction_62 _ _ _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_1  43 happyReduction_63
happyReduction_63 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_63 _  = notHappyAtAll 

happyReduce_64 = happySpecReduce_1  43 happyReduction_64
happyReduction_64 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_64 _  = notHappyAtAll 

happyReduce_65 = happySpecReduce_1  44 happyReduction_65
happyReduction_65 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_65 _  = notHappyAtAll 

happyReduce_66 = happySpecReduce_1  44 happyReduction_66
happyReduction_66 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_66 _  = notHappyAtAll 

happyReduce_67 = happySpecReduce_1  44 happyReduction_67
happyReduction_67 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_67 _  = notHappyAtAll 

happyReduce_68 = happySpecReduce_1  44 happyReduction_68
happyReduction_68 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_68 _  = notHappyAtAll 

happyReduce_69 = happySpecReduce_1  44 happyReduction_69
happyReduction_69 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_69 _  = notHappyAtAll 

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
happyReduction_72 (HappyAbsSyn74  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_72 _  = notHappyAtAll 

happyReduce_73 = happySpecReduce_2  45 happyReduction_73
happyReduction_73 (HappyAbsSyn66  happy_var_2)
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (ApplicationExpression (getRange (happy_var_1,happy_var_2)) happy_var_1 happy_var_2
	)
happyReduction_73 _ _  = notHappyAtAll 

happyReduce_74 = happySpecReduce_1  45 happyReduction_74
happyReduction_74 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
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
		 (MeaninglessOperatorsExpression  (getRange happy_var_1) happy_var_1
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

happyReduce_79 = happyReduce 5 48 happyReduction_79
happyReduction_79 (_ `HappyStk`
	(HappyAbsSyn30  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn48
		 (CaseCase (getRange (happy_var_1,happy_var_4)) happy_var_1 happy_var_4
	) `HappyStk` happyRest

happyReduce_80 = happySpecReduce_1  49 happyReduction_80
happyReduction_80 (HappyAbsSyn68  happy_var_1)
	 =  HappyAbsSyn49
		 (happy_var_1
	)
happyReduction_80 _  = notHappyAtAll 

happyReduce_81 = happyReduce 4 50 happyReduction_81
happyReduction_81 ((HappyAbsSyn49  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_2) `HappyStk`
	(HappyTerminal (Case happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (SST.Case (getRange (happy_var_1,happy_var_4)) happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_82 = happyReduce 6 50 happyReduction_82
happyReduction_82 ((HappyAbsSyn49  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Case happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (SST.Case (getRange (happy_var_1,happy_var_6)) happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_83 = happyReduce 6 50 happyReduction_83
happyReduction_83 (_ `HappyStk`
	(HappyAbsSyn49  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_2) `HappyStk`
	(HappyTerminal (Case happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (SST.Case (getRange (happy_var_1,happy_var_5)) happy_var_2 happy_var_5
	) `HappyStk` happyRest

happyReduce_84 = happyReduce 8 50 happyReduction_84
happyReduction_84 (_ `HappyStk`
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

happyReduce_85 = happySpecReduce_1  50 happyReduction_85
happyReduction_85 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_85 _  = notHappyAtAll 

happyReduce_86 = happySpecReduce_1  51 happyReduction_86
happyReduction_86 (HappyAbsSyn72  happy_var_1)
	 =  HappyAbsSyn51
		 (happy_var_1
	)
happyReduction_86 _  = notHappyAtAll 

happyReduce_87 = happyReduce 4 52 happyReduction_87
happyReduction_87 ((HappyAbsSyn30  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn51  happy_var_2) `HappyStk`
	(HappyTerminal (LambdaStart happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (Lambda (getRange (happy_var_1,happy_var_4)) happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_88 = happySpecReduce_1  52 happyReduction_88
happyReduction_88 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_88 _  = notHappyAtAll 

happyReduce_89 = happySpecReduce_3  53 happyReduction_89
happyReduction_89 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn53
		 (LetBinding (getRange (happy_var_1,happy_var_3)) happy_var_1 happy_var_3
	)
happyReduction_89 _ _ _  = notHappyAtAll 

happyReduce_90 = happySpecReduce_1  54 happyReduction_90
happyReduction_90 (HappyAbsSyn69  happy_var_1)
	 =  HappyAbsSyn54
		 (happy_var_1
	)
happyReduction_90 _  = notHappyAtAll 

happyReduce_91 = happyReduce 8 55 happyReduction_91
happyReduction_91 (_ `HappyStk`
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

happyReduce_92 = happyReduce 6 55 happyReduction_92
happyReduction_92 ((HappyAbsSyn30  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn54  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Let happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (SST.Let (getRange (happy_var_1,happy_var_6)) happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_93 = happyReduce 6 55 happyReduction_93
happyReduction_93 (_ `HappyStk`
	(HappyAbsSyn30  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn53  happy_var_2) `HappyStk`
	(HappyTerminal (Let happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (SST.Let (getRange (happy_var_1,happy_var_5)) (happy_var_2 :|[]) happy_var_5
	) `HappyStk` happyRest

happyReduce_94 = happyReduce 4 55 happyReduction_94
happyReduction_94 ((HappyAbsSyn30  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn53  happy_var_2) `HappyStk`
	(HappyTerminal (Let happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (SST.Let (getRange (happy_var_1,happy_var_4)) (happy_var_2 :| []) happy_var_4
	) `HappyStk` happyRest

happyReduce_95 = happySpecReduce_1  55 happyReduction_95
happyReduction_95 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_95 _  = notHappyAtAll 

happyReduce_96 = happySpecReduce_1  56 happyReduction_96
happyReduction_96 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_96 _  = notHappyAtAll 

happyReduce_97 = happyReduce 5 57 happyReduction_97
happyReduction_97 (_ `HappyStk`
	(HappyAbsSyn17  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (ModuleVariableDeclaration (getRange (happy_var_1,happy_var_4)) happy_var_1 happy_var_4
	) `HappyStk` happyRest

happyReduce_98 = happyReduce 5 58 happyReduction_98
happyReduction_98 (_ `HappyStk`
	(HappyAbsSyn30  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (ModulePatternDefinition (getRange (happy_var_1,happy_var_4)) happy_var_1 happy_var_4
	) `HappyStk` happyRest

happyReduce_99 = happySpecReduce_1  59 happyReduction_99
happyReduction_99 (HappyTerminal (Type happy_var_1))
	 =  HappyAbsSyn59
		 (IsTypeOperator (getRange happy_var_1)
	)
happyReduction_99 _  = notHappyAtAll 

happyReduce_100 = happySpecReduce_1  59 happyReduction_100
happyReduction_100 (HappyTerminal (Term happy_var_1))
	 =  HappyAbsSyn59
		 (IsTypeOperator(getRange happy_var_1)
	)
happyReduction_100 _  = notHappyAtAll 

happyReduce_101 = happySpecReduce_1  60 happyReduction_101
happyReduction_101 (HappyTerminal (Left_ happy_var_1))
	 =  HappyAbsSyn60
		 (LeftOperator(getRange happy_var_1)
	)
happyReduction_101 _  = notHappyAtAll 

happyReduce_102 = happySpecReduce_1  60 happyReduction_102
happyReduction_102 (HappyTerminal (Right_ happy_var_1))
	 =  HappyAbsSyn60
		 (RightOperator(getRange happy_var_1)
	)
happyReduction_102 _  = notHappyAtAll 

happyReduce_103 = happySpecReduce_1  60 happyReduction_103
happyReduction_103 (HappyTerminal (None happy_var_1))
	 =  HappyAbsSyn60
		 (NoneOperator(getRange happy_var_1)
	)
happyReduction_103 _  = notHappyAtAll 

happyReduce_104 = happyReduce 5 61 happyReduction_104
happyReduction_104 ((HappyTerminal happy_var_5) `HappyStk`
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

happyReduce_105 = happySpecReduce_3  62 happyReduction_105
happyReduction_105 _
	(HappyAbsSyn33  happy_var_2)
	_
	 =  HappyAbsSyn62
		 (happy_var_2
	)
happyReduction_105 _ _ _  = notHappyAtAll 

happyReduce_106 = happySpecReduce_3  63 happyReduction_106
happyReduction_106 _
	(HappyAbsSyn36  happy_var_2)
	_
	 =  HappyAbsSyn63
		 (happy_var_2
	)
happyReduction_106 _ _ _  = notHappyAtAll 

happyReduce_107 = happySpecReduce_3  64 happyReduction_107
happyReduction_107 _
	(HappyAbsSyn16  happy_var_2)
	_
	 =  HappyAbsSyn64
		 (happy_var_2
	)
happyReduction_107 _ _ _  = notHappyAtAll 

happyReduce_108 = happySpecReduce_1  65 happyReduction_108
happyReduction_108 (HappyAbsSyn86  happy_var_1)
	 =  HappyAbsSyn65
		 (List.reverse happy_var_1
	)
happyReduction_108 _  = notHappyAtAll 

happyReduce_109 = happySpecReduce_1  66 happyReduction_109
happyReduction_109 (HappyAbsSyn78  happy_var_1)
	 =  HappyAbsSyn66
		 (reverse happy_var_1
	)
happyReduction_109 _  = notHappyAtAll 

happyReduce_110 = happySpecReduce_1  67 happyReduction_110
happyReduction_110 (HappyAbsSyn79  happy_var_1)
	 =  HappyAbsSyn67
		 (reverse happy_var_1
	)
happyReduction_110 _  = notHappyAtAll 

happyReduce_111 = happySpecReduce_1  68 happyReduction_111
happyReduction_111 (HappyAbsSyn80  happy_var_1)
	 =  HappyAbsSyn68
		 (reverse happy_var_1
	)
happyReduction_111 _  = notHappyAtAll 

happyReduce_112 = happySpecReduce_1  69 happyReduction_112
happyReduction_112 (HappyAbsSyn81  happy_var_1)
	 =  HappyAbsSyn69
		 (reverse happy_var_1
	)
happyReduction_112 _  = notHappyAtAll 

happyReduce_113 = happySpecReduce_1  70 happyReduction_113
happyReduction_113 (HappyAbsSyn82  happy_var_1)
	 =  HappyAbsSyn70
		 (reverse happy_var_1
	)
happyReduction_113 _  = notHappyAtAll 

happyReduce_114 = happySpecReduce_1  71 happyReduction_114
happyReduction_114 (HappyAbsSyn83  happy_var_1)
	 =  HappyAbsSyn71
		 (reverse happy_var_1
	)
happyReduction_114 _  = notHappyAtAll 

happyReduce_115 = happySpecReduce_1  72 happyReduction_115
happyReduction_115 (HappyAbsSyn84  happy_var_1)
	 =  HappyAbsSyn72
		 (reverse happy_var_1
	)
happyReduction_115 _  = notHappyAtAll 

happyReduce_116 = happySpecReduce_1  73 happyReduction_116
happyReduction_116 (HappyAbsSyn85  happy_var_1)
	 =  HappyAbsSyn73
		 (reverse happy_var_1
	)
happyReduction_116 _  = notHappyAtAll 

happyReduce_117 = happySpecReduce_3  74 happyReduction_117
happyReduction_117 _
	(HappyAbsSyn30  happy_var_2)
	_
	 =  HappyAbsSyn74
		 (happy_var_2
	)
happyReduction_117 _ _ _  = notHappyAtAll 

happyReduce_118 = happySpecReduce_3  75 happyReduction_118
happyReduction_118 _
	(HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn75
		 (happy_var_2
	)
happyReduction_118 _ _ _  = notHappyAtAll 

happyReduce_119 = happySpecReduce_3  76 happyReduction_119
happyReduction_119 _
	(HappyAbsSyn7  happy_var_2)
	_
	 =  HappyAbsSyn76
		 (happy_var_2
	)
happyReduction_119 _ _ _  = notHappyAtAll 

happyReduce_120 = happySpecReduce_3  77 happyReduction_120
happyReduction_120 _
	(HappyAbsSyn17  happy_var_2)
	_
	 =  HappyAbsSyn77
		 (happy_var_2
	)
happyReduction_120 _ _ _  = notHappyAtAll 

happyReduce_121 = happySpecReduce_1  78 happyReduction_121
happyReduction_121 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn78
		 (happy_var_1 :| []
	)
happyReduction_121 _  = notHappyAtAll 

happyReduce_122 = happySpecReduce_2  78 happyReduction_122
happyReduction_122 (HappyAbsSyn30  happy_var_2)
	(HappyAbsSyn78  happy_var_1)
	 =  HappyAbsSyn78
		 (cons happy_var_2 happy_var_1
	)
happyReduction_122 _ _  = notHappyAtAll 

happyReduce_123 = happySpecReduce_1  79 happyReduction_123
happyReduction_123 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn79
		 (happy_var_1 :| []
	)
happyReduction_123 _  = notHappyAtAll 

happyReduce_124 = happySpecReduce_2  79 happyReduction_124
happyReduction_124 (HappyAbsSyn7  happy_var_2)
	(HappyAbsSyn79  happy_var_1)
	 =  HappyAbsSyn79
		 (cons happy_var_2 happy_var_1
	)
happyReduction_124 _ _  = notHappyAtAll 

happyReduce_125 = happySpecReduce_1  80 happyReduction_125
happyReduction_125 (HappyAbsSyn48  happy_var_1)
	 =  HappyAbsSyn80
		 (happy_var_1 :| []
	)
happyReduction_125 _  = notHappyAtAll 

happyReduce_126 = happySpecReduce_3  80 happyReduction_126
happyReduction_126 (HappyAbsSyn48  happy_var_3)
	_
	(HappyAbsSyn80  happy_var_1)
	 =  HappyAbsSyn80
		 (cons happy_var_3 happy_var_1
	)
happyReduction_126 _ _ _  = notHappyAtAll 

happyReduce_127 = happySpecReduce_1  81 happyReduction_127
happyReduction_127 (HappyAbsSyn53  happy_var_1)
	 =  HappyAbsSyn81
		 (happy_var_1 :| []
	)
happyReduction_127 _  = notHappyAtAll 

happyReduce_128 = happySpecReduce_3  81 happyReduction_128
happyReduction_128 (HappyAbsSyn53  happy_var_3)
	_
	(HappyAbsSyn81  happy_var_1)
	 =  HappyAbsSyn81
		 (cons happy_var_3 happy_var_1
	)
happyReduction_128 _ _ _  = notHappyAtAll 

happyReduce_129 = happySpecReduce_1  82 happyReduction_129
happyReduction_129 (HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn82
		 (happy_var_1 :| []
	)
happyReduction_129 _  = notHappyAtAll 

happyReduce_130 = happySpecReduce_3  82 happyReduction_130
happyReduction_130 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn82  happy_var_1)
	 =  HappyAbsSyn82
		 (cons happy_var_3 happy_var_1
	)
happyReduction_130 _ _ _  = notHappyAtAll 

happyReduce_131 = happySpecReduce_1  83 happyReduction_131
happyReduction_131 (HappyAbsSyn35  happy_var_1)
	 =  HappyAbsSyn83
		 (happy_var_1 :| []
	)
happyReduction_131 _  = notHappyAtAll 

happyReduce_132 = happySpecReduce_3  83 happyReduction_132
happyReduction_132 (HappyAbsSyn35  happy_var_3)
	_
	(HappyAbsSyn83  happy_var_1)
	 =  HappyAbsSyn83
		 (cons happy_var_3 happy_var_1
	)
happyReduction_132 _ _ _  = notHappyAtAll 

happyReduce_133 = happySpecReduce_1  84 happyReduction_133
happyReduction_133 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn84
		 (happy_var_1 :| []
	)
happyReduction_133 _  = notHappyAtAll 

happyReduce_134 = happySpecReduce_3  84 happyReduction_134
happyReduction_134 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn84  happy_var_1)
	 =  HappyAbsSyn84
		 (cons happy_var_3 happy_var_1
	)
happyReduction_134 _ _ _  = notHappyAtAll 

happyReduce_135 = happySpecReduce_1  85 happyReduction_135
happyReduction_135 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn85
		 (happy_var_1 :| []
	)
happyReduction_135 _  = notHappyAtAll 

happyReduce_136 = happySpecReduce_3  85 happyReduction_136
happyReduction_136 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn85  happy_var_1)
	 =  HappyAbsSyn85
		 (cons happy_var_3 happy_var_1
	)
happyReduction_136 _ _ _  = notHappyAtAll 

happyReduce_137 = happySpecReduce_0  86 happyReduction_137
happyReduction_137  =  HappyAbsSyn86
		 ([]
	)

happyReduce_138 = happySpecReduce_2  86 happyReduction_138
happyReduction_138 (HappyAbsSyn5  happy_var_2)
	(HappyAbsSyn86  happy_var_1)
	 =  HappyAbsSyn86
		 (happy_var_2:happy_var_1
	)
happyReduction_138 _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 118 118 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenVariable _ happy_dollar_dollar -> cont 87;
	Hole happy_dollar_dollar -> cont 88;
	LiteralUint _ _ -> cont 89;
	LeftParen happy_dollar_dollar -> cont 90;
	RightParen happy_dollar_dollar -> cont 91;
	LeftBrace happy_dollar_dollar -> cont 92;
	RightBrace happy_dollar_dollar -> cont 93;
	Colon happy_dollar_dollar -> cont 94;
	Comma happy_dollar_dollar -> cont 95;
	BackTick happy_dollar_dollar -> cont 96;
	LayoutStart happy_dollar_dollar -> cont 97;
	LayoutSeparator happy_dollar_dollar -> cont 98;
	LayoutEnd happy_dollar_dollar -> cont 99;
	RightArrow happy_dollar_dollar -> cont 100;
	TokenOperator _ _ -> cont 101;
	Forall happy_dollar_dollar -> cont 102;
	Dot happy_dollar_dollar -> cont 103;
	Data happy_dollar_dollar -> cont 104;
	Equal happy_dollar_dollar -> cont 105;
	At happy_dollar_dollar -> cont 106;
	Case happy_dollar_dollar -> cont 107;
	Of happy_dollar_dollar -> cont 108;
	LambdaStart happy_dollar_dollar -> cont 109;
	Let happy_dollar_dollar -> cont 110;
	In happy_dollar_dollar -> cont 111;
	OperatorKeyword happy_dollar_dollar -> cont 112;
	Type happy_dollar_dollar -> cont 113;
	Term happy_dollar_dollar -> cont 114;
	Left_ happy_dollar_dollar -> cont 115;
	Right_ happy_dollar_dollar -> cont 116;
	None happy_dollar_dollar -> cont 117;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 118 tk tks = happyError' (tks, explist)
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
