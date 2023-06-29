{-# OPTIONS_GHC -w #-}
module HMeguKin.Parser.Parser(parse) where

import Data.List.NonEmpty(NonEmpty((:|)),cons,reverse)
import Data.List qualified as List
import Prelude hiding(reverse)

import HMeguKin.Parser.Types(Token(..),Range) 
import HMeguKin.Parser.Types qualified as Types
import HMeguKin.Parser.SST hiding (LiteralUint,Case,Let)
import HMeguKin.Parser.SST qualified as SST

import Debug.Trace(trace)
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.20.1.1

data HappyAbsSyn t57 t58 t59 t60 t61 t62 t63 t64 t65 t66 t67 t68 t69 t70 t71 t72 t73 t74 t75 t76 t77 t78 t79 t80 t81 t82 t83
	= HappyTerminal (Token)
	| HappyErrorToken Prelude.Int
	| HappyAbsSyn4 (Expression)
	| HappyAbsSyn5 (Variable)
	| HappyAbsSyn6 (Operator)
	| HappyAbsSyn7 (Pattern)
	| HappyAbsSyn15 (NonEmpty Pattern)
	| HappyAbsSyn16 ((Range,Variable,Type))
	| HappyAbsSyn17 (NonEmpty(Range,Variable,Type))
	| HappyAbsSyn18 (Type)
	| HappyAbsSyn22 (IntercalatedList Type Operator)
	| HappyAbsSyn26 (NonEmpty Variable)
	| HappyAbsSyn27 ([Type])
	| HappyAbsSyn28 (Constructor)
	| HappyAbsSyn29 (NonEmpty Constructor)
	| HappyAbsSyn30 (ModuleStatement)
	| HappyAbsSyn33 ((Range,Variable,Maybe Expression))
	| HappyAbsSyn34 (NonEmpty (Range,Variable,Maybe Expression))
	| HappyAbsSyn36 ((Range,Variable,Expression))
	| HappyAbsSyn37 (NonEmpty (Range,Variable,Expression))
	| HappyAbsSyn47 (IntercalatedList Expression Operator)
	| HappyAbsSyn49 (CaseCase)
	| HappyAbsSyn50 (NonEmpty CaseCase)
	| HappyAbsSyn54 (LetBinding)
	| HappyAbsSyn55 (NonEmpty LetBinding)
	| HappyAbsSyn57 t57
	| HappyAbsSyn58 t58
	| HappyAbsSyn59 t59
	| HappyAbsSyn60 t60
	| HappyAbsSyn61 t61
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

happyExpList :: Happy_Data_Array.Array Prelude.Int Prelude.Int
happyExpList = Happy_Data_Array.listArray (0,1085) ([0,0,0,0,0,360,1728,0,0,0,0,0,45,216,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,11520,2048,0,0,0,0,0,0,0,0,0,0,0,0,2048,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,33882,432,0,0,0,0,16384,16,0,0,0,0,0,18432,1,0,0,0,0,0,11520,55300,0,0,0,0,0,480,0,0,0,0,0,0,4156,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,512,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,480,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,61440,0,0,0,0,0,0,7680,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,0,40960,5,27,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10496,0,0,0,0,0,0,32,0,0,0,0,0,0,512,16,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,0,32,0,0,0,0,0,0,4,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,0,0,0,0,0,1440,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,53248,32770,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,41984,512,0,0,0,0,0,128,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,26624,49153,6,0,0,0,0,11520,55296,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,328,0,0,0,0,0,0,16896,0,0,0,0,0,0,1024,0,0,0,0,0,16384,0,0,0,0,0,0,0,8,0,0,0,0,0,16624,0,0,0,0,0,0,90,432,0,0,0,0,0,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,576,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7680,0,0,0,0,0,0,960,0,0,0,0,0,0,360,1728,0,0,0,0,0,1069,216,0,0,0,0,57344,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,90,432,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,164,2,0,0,0,0,32768,7,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1920,0,0,0,0,0,0,0,512,0,0,0,0,0,0,0,0,0,0,0,16384,10,0,0,0,0,0,18432,1,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,32768,20,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,2048,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,164,0,0,0,0,0,0,0,0,0,0,0,0,61440,64,0,0,0,0,0,0,32,0,0,0,0,0,960,0,0,0,0,0,0,8552,1728,0,0,0,0,0,1069,216,0,0,0,0,0,0,0,0,0,0,0,16384,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,26624,49153,6,0,0,0,0,0,0,0,0,0,0,0,1440,6912,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7680,0,0,0,0,0,0,0,0,0,0,0,0,0,328,0,0,0,0,0,0,0,0,0,0,0,0,0,512,0,0,0,0,0,0,64,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","expression","meta_variable","meta_operator","pattern_match_variable","pattern_match_hole","pattern_match_literal","pattern_annotation","pattern_match_atom","pattern_as","pattern_match_application","pattern_match","pattern_match_function_args","type_record_item","type_record_inner","type_record","type_variable","type_atom","type_application","type_operators_plus","type_operators","type_expression_inner","type_scheme","type_data_type_args","type_expression_inner_sep_comma","data_type_constructor","data_type_constructor_plus","data_type","expression_literal","expression_variable","expression_record_item","expression_record_inner","expression_record","expression_record_update_item","expression_record_update_inner","expression_record_update","expression_operator_parens","expression_annotation","expression_type_arg","expression_accessor_field","expression_accessor_funtion","expression_accessor","expression_atom","expression_application","expression_operators_plus","expression_operators","expression_case_single","expression_case_cases","expression_case","expression_lambda_arguments","expression_lambda","expression_let_binding","expression_let_inside","expression_let","braces__expression_record_inner__","braces__expression_record_update_inner__","braces__type_record_inner__","list__meta_variable__","list1__expression_atom__","list1__pattern_as__","list1__pattern_match__","listSepBy1__expression_case_single__LayoutSeparator__","listSepBy1__expression_let_binding__LayoutSeparator__","listSepBy1__expression_record_item__Comma__","listSepBy1__expression_record_update_item__Comma__","listSepBy1__pattern_match__Comma__","listSepBy1__type_record_item__Comma__","parens__expression_annotation__","parens__meta_operator__","parens__pattern_match__","parens__type_expression_inner__","plus__expression_atom__","plus__pattern_as__","plus__pattern_match__","sepBy1__expression_case_single__LayoutSeparator__","sepBy1__expression_let_binding__LayoutSeparator__","sepBy1__expression_record_item__Comma__","sepBy1__expression_record_update_item__Comma__","sepBy1__pattern_match__Comma__","sepBy1__type_record_item__Comma__","star__meta_variable__","Variable","Hole","Int","LParen","RParen","LBrace","RBrace","Colon","Comma","BackTick","LayoutStart","LayoutSeparator","LayoutEnd","RightArrow","TokenOperator","Forall","Dot","Data","Equal","At","Case","Of","Lambda","Let","In","%eof"]
        bit_start = st Prelude.* 109
        bit_end = (st Prelude.+ 1) Prelude.* 109
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..108]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

action_0 (84) = happyShift action_20
action_0 (86) = happyShift action_21
action_0 (87) = happyShift action_22
action_0 (89) = happyShift action_23
action_0 (103) = happyShift action_24
action_0 (104) = happyShift action_25
action_0 (106) = happyShift action_26
action_0 (107) = happyShift action_27
action_0 (4) = happyGoto action_28
action_0 (5) = happyGoto action_2
action_0 (31) = happyGoto action_3
action_0 (32) = happyGoto action_4
action_0 (35) = happyGoto action_5
action_0 (38) = happyGoto action_6
action_0 (39) = happyGoto action_7
action_0 (41) = happyGoto action_8
action_0 (45) = happyGoto action_9
action_0 (46) = happyGoto action_10
action_0 (47) = happyGoto action_11
action_0 (48) = happyGoto action_12
action_0 (51) = happyGoto action_13
action_0 (53) = happyGoto action_14
action_0 (56) = happyGoto action_15
action_0 (57) = happyGoto action_16
action_0 (58) = happyGoto action_17
action_0 (70) = happyGoto action_18
action_0 (71) = happyGoto action_19
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (84) = happyShift action_20
action_1 (86) = happyShift action_21
action_1 (87) = happyShift action_22
action_1 (89) = happyShift action_23
action_1 (103) = happyShift action_24
action_1 (104) = happyShift action_25
action_1 (106) = happyShift action_26
action_1 (107) = happyShift action_27
action_1 (5) = happyGoto action_2
action_1 (31) = happyGoto action_3
action_1 (32) = happyGoto action_4
action_1 (35) = happyGoto action_5
action_1 (38) = happyGoto action_6
action_1 (39) = happyGoto action_7
action_1 (41) = happyGoto action_8
action_1 (45) = happyGoto action_9
action_1 (46) = happyGoto action_10
action_1 (47) = happyGoto action_11
action_1 (48) = happyGoto action_12
action_1 (51) = happyGoto action_13
action_1 (53) = happyGoto action_14
action_1 (56) = happyGoto action_15
action_1 (57) = happyGoto action_16
action_1 (58) = happyGoto action_17
action_1 (70) = happyGoto action_18
action_1 (71) = happyGoto action_19
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyReduce_46

action_3 _ = happyReduce_64

action_4 _ = happyReduce_63

action_5 _ = happyReduce_65

action_6 _ = happyReduce_66

action_7 _ = happyReduce_67

action_8 _ = happyReduce_68

action_9 (84) = happyShift action_20
action_9 (86) = happyShift action_21
action_9 (87) = happyShift action_22
action_9 (89) = happyShift action_23
action_9 (103) = happyShift action_24
action_9 (5) = happyGoto action_2
action_9 (31) = happyGoto action_3
action_9 (32) = happyGoto action_4
action_9 (35) = happyGoto action_5
action_9 (38) = happyGoto action_6
action_9 (39) = happyGoto action_7
action_9 (41) = happyGoto action_8
action_9 (45) = happyGoto action_75
action_9 (57) = happyGoto action_16
action_9 (58) = happyGoto action_17
action_9 (61) = happyGoto action_76
action_9 (70) = happyGoto action_18
action_9 (71) = happyGoto action_19
action_9 (74) = happyGoto action_77
action_9 _ = happyReduce_71

action_10 _ = happyReduce_72

action_11 (93) = happyShift action_72
action_11 (98) = happyShift action_73
action_11 (6) = happyGoto action_74
action_11 _ = happyReduce_74

action_12 _ = happyReduce_82

action_13 _ = happyReduce_85

action_14 _ = happyReduce_92

action_15 _ = happyReduce_1

action_16 _ = happyReduce_50

action_17 _ = happyReduce_54

action_18 _ = happyReduce_69

action_19 _ = happyReduce_55

action_20 _ = happyReduce_2

action_21 _ = happyReduce_45

action_22 (84) = happyShift action_20
action_22 (86) = happyShift action_21
action_22 (87) = happyShift action_22
action_22 (89) = happyShift action_23
action_22 (93) = happyShift action_72
action_22 (98) = happyShift action_73
action_22 (103) = happyShift action_24
action_22 (104) = happyShift action_25
action_22 (106) = happyShift action_26
action_22 (107) = happyShift action_27
action_22 (4) = happyGoto action_69
action_22 (5) = happyGoto action_2
action_22 (6) = happyGoto action_70
action_22 (31) = happyGoto action_3
action_22 (32) = happyGoto action_4
action_22 (35) = happyGoto action_5
action_22 (38) = happyGoto action_6
action_22 (39) = happyGoto action_7
action_22 (40) = happyGoto action_71
action_22 (41) = happyGoto action_8
action_22 (45) = happyGoto action_9
action_22 (46) = happyGoto action_10
action_22 (47) = happyGoto action_11
action_22 (48) = happyGoto action_12
action_22 (51) = happyGoto action_13
action_22 (53) = happyGoto action_14
action_22 (56) = happyGoto action_15
action_22 (57) = happyGoto action_16
action_22 (58) = happyGoto action_17
action_22 (70) = happyGoto action_18
action_22 (71) = happyGoto action_19
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (84) = happyShift action_20
action_23 (90) = happyShift action_68
action_23 (5) = happyGoto action_59
action_23 (33) = happyGoto action_60
action_23 (34) = happyGoto action_61
action_23 (36) = happyGoto action_62
action_23 (37) = happyGoto action_63
action_23 (66) = happyGoto action_64
action_23 (67) = happyGoto action_65
action_23 (79) = happyGoto action_66
action_23 (80) = happyGoto action_67
action_23 _ = happyFail (happyExpListPerState 23)

action_24 (84) = happyShift action_20
action_24 (87) = happyShift action_57
action_24 (89) = happyShift action_58
action_24 (5) = happyGoto action_51
action_24 (18) = happyGoto action_52
action_24 (19) = happyGoto action_53
action_24 (20) = happyGoto action_54
action_24 (59) = happyGoto action_55
action_24 (73) = happyGoto action_56
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (84) = happyShift action_20
action_25 (86) = happyShift action_21
action_25 (87) = happyShift action_22
action_25 (89) = happyShift action_23
action_25 (94) = happyShift action_50
action_25 (103) = happyShift action_24
action_25 (104) = happyShift action_25
action_25 (106) = happyShift action_26
action_25 (107) = happyShift action_27
action_25 (4) = happyGoto action_49
action_25 (5) = happyGoto action_2
action_25 (31) = happyGoto action_3
action_25 (32) = happyGoto action_4
action_25 (35) = happyGoto action_5
action_25 (38) = happyGoto action_6
action_25 (39) = happyGoto action_7
action_25 (41) = happyGoto action_8
action_25 (45) = happyGoto action_9
action_25 (46) = happyGoto action_10
action_25 (47) = happyGoto action_11
action_25 (48) = happyGoto action_12
action_25 (51) = happyGoto action_13
action_25 (53) = happyGoto action_14
action_25 (56) = happyGoto action_15
action_25 (57) = happyGoto action_16
action_25 (58) = happyGoto action_17
action_25 (70) = happyGoto action_18
action_25 (71) = happyGoto action_19
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (84) = happyShift action_42
action_26 (85) = happyShift action_43
action_26 (86) = happyShift action_44
action_26 (87) = happyShift action_45
action_26 (5) = happyGoto action_29
action_26 (7) = happyGoto action_30
action_26 (8) = happyGoto action_31
action_26 (9) = happyGoto action_32
action_26 (10) = happyGoto action_33
action_26 (11) = happyGoto action_34
action_26 (12) = happyGoto action_35
action_26 (13) = happyGoto action_36
action_26 (14) = happyGoto action_37
action_26 (52) = happyGoto action_47
action_26 (68) = happyGoto action_48
action_26 (72) = happyGoto action_40
action_26 (81) = happyGoto action_41
action_26 _ = happyFail (happyExpListPerState 26)

action_27 (84) = happyShift action_42
action_27 (85) = happyShift action_43
action_27 (86) = happyShift action_44
action_27 (87) = happyShift action_45
action_27 (94) = happyShift action_46
action_27 (5) = happyGoto action_29
action_27 (7) = happyGoto action_30
action_27 (8) = happyGoto action_31
action_27 (9) = happyGoto action_32
action_27 (10) = happyGoto action_33
action_27 (11) = happyGoto action_34
action_27 (12) = happyGoto action_35
action_27 (13) = happyGoto action_36
action_27 (14) = happyGoto action_37
action_27 (54) = happyGoto action_38
action_27 (68) = happyGoto action_39
action_27 (72) = happyGoto action_40
action_27 (81) = happyGoto action_41
action_27 _ = happyFail (happyExpListPerState 27)

action_28 (109) = happyAccept
action_28 _ = happyFail (happyExpListPerState 28)

action_29 (103) = happyShift action_114
action_29 _ = happyReduce_5

action_30 _ = happyReduce_10

action_31 _ = happyReduce_11

action_32 _ = happyReduce_9

action_33 _ = happyReduce_13

action_34 _ = happyReduce_15

action_35 _ = happyReduce_17

action_36 _ = happyReduce_18

action_37 _ = happyReduce_124

action_38 (108) = happyShift action_113
action_38 _ = happyFail (happyExpListPerState 38)

action_39 (102) = happyShift action_112
action_39 _ = happyFail (happyExpListPerState 39)

action_40 _ = happyReduce_12

action_41 (92) = happyShift action_111
action_41 _ = happyReduce_104

action_42 (84) = happyShift action_20
action_42 (85) = happyShift action_43
action_42 (86) = happyShift action_44
action_42 (87) = happyShift action_45
action_42 (5) = happyGoto action_29
action_42 (7) = happyGoto action_30
action_42 (8) = happyGoto action_31
action_42 (9) = happyGoto action_32
action_42 (10) = happyGoto action_33
action_42 (11) = happyGoto action_34
action_42 (12) = happyGoto action_108
action_42 (62) = happyGoto action_109
action_42 (72) = happyGoto action_40
action_42 (75) = happyGoto action_110
action_42 _ = happyReduce_2

action_43 _ = happyReduce_6

action_44 _ = happyReduce_7

action_45 (84) = happyShift action_42
action_45 (85) = happyShift action_43
action_45 (86) = happyShift action_44
action_45 (87) = happyShift action_45
action_45 (5) = happyGoto action_29
action_45 (7) = happyGoto action_30
action_45 (8) = happyGoto action_31
action_45 (9) = happyGoto action_32
action_45 (10) = happyGoto action_33
action_45 (11) = happyGoto action_34
action_45 (12) = happyGoto action_35
action_45 (13) = happyGoto action_36
action_45 (14) = happyGoto action_107
action_45 (72) = happyGoto action_40
action_45 _ = happyFail (happyExpListPerState 45)

action_46 (84) = happyShift action_42
action_46 (85) = happyShift action_43
action_46 (86) = happyShift action_44
action_46 (87) = happyShift action_45
action_46 (5) = happyGoto action_29
action_46 (7) = happyGoto action_30
action_46 (8) = happyGoto action_31
action_46 (9) = happyGoto action_32
action_46 (10) = happyGoto action_33
action_46 (11) = happyGoto action_34
action_46 (12) = happyGoto action_35
action_46 (13) = happyGoto action_36
action_46 (14) = happyGoto action_37
action_46 (54) = happyGoto action_103
action_46 (55) = happyGoto action_104
action_46 (65) = happyGoto action_105
action_46 (68) = happyGoto action_39
action_46 (72) = happyGoto action_40
action_46 (78) = happyGoto action_106
action_46 (81) = happyGoto action_41
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (97) = happyShift action_102
action_47 _ = happyFail (happyExpListPerState 47)

action_48 _ = happyReduce_83

action_49 (105) = happyShift action_101
action_49 _ = happyFail (happyExpListPerState 49)

action_50 (84) = happyShift action_20
action_50 (86) = happyShift action_21
action_50 (87) = happyShift action_22
action_50 (89) = happyShift action_23
action_50 (103) = happyShift action_24
action_50 (104) = happyShift action_25
action_50 (106) = happyShift action_26
action_50 (107) = happyShift action_27
action_50 (4) = happyGoto action_100
action_50 (5) = happyGoto action_2
action_50 (31) = happyGoto action_3
action_50 (32) = happyGoto action_4
action_50 (35) = happyGoto action_5
action_50 (38) = happyGoto action_6
action_50 (39) = happyGoto action_7
action_50 (41) = happyGoto action_8
action_50 (45) = happyGoto action_9
action_50 (46) = happyGoto action_10
action_50 (47) = happyGoto action_11
action_50 (48) = happyGoto action_12
action_50 (51) = happyGoto action_13
action_50 (53) = happyGoto action_14
action_50 (56) = happyGoto action_15
action_50 (57) = happyGoto action_16
action_50 (58) = happyGoto action_17
action_50 (70) = happyGoto action_18
action_50 (71) = happyGoto action_19
action_50 _ = happyFail (happyExpListPerState 50)

action_51 _ = happyReduce_23

action_52 _ = happyReduce_26

action_53 _ = happyReduce_24

action_54 _ = happyReduce_58

action_55 _ = happyReduce_22

action_56 _ = happyReduce_25

action_57 (84) = happyShift action_20
action_57 (87) = happyShift action_57
action_57 (89) = happyShift action_58
action_57 (5) = happyGoto action_51
action_57 (18) = happyGoto action_52
action_57 (19) = happyGoto action_53
action_57 (20) = happyGoto action_95
action_57 (21) = happyGoto action_96
action_57 (22) = happyGoto action_97
action_57 (23) = happyGoto action_98
action_57 (24) = happyGoto action_99
action_57 (59) = happyGoto action_55
action_57 (73) = happyGoto action_56
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (84) = happyShift action_20
action_58 (5) = happyGoto action_90
action_58 (16) = happyGoto action_91
action_58 (17) = happyGoto action_92
action_58 (69) = happyGoto action_93
action_58 (82) = happyGoto action_94
action_58 _ = happyFail (happyExpListPerState 58)

action_59 (91) = happyShift action_88
action_59 (102) = happyShift action_89
action_59 _ = happyReduce_48

action_60 _ = happyReduce_120

action_61 (90) = happyShift action_87
action_61 _ = happyFail (happyExpListPerState 61)

action_62 _ = happyReduce_122

action_63 (90) = happyShift action_86
action_63 _ = happyFail (happyExpListPerState 63)

action_64 _ = happyReduce_49

action_65 _ = happyReduce_53

action_66 (92) = happyShift action_85
action_66 _ = happyReduce_102

action_67 (92) = happyShift action_84
action_67 _ = happyReduce_103

action_68 _ = happyReduce_51

action_69 (91) = happyShift action_83
action_69 _ = happyReduce_56

action_70 (88) = happyShift action_82
action_70 _ = happyFail (happyExpListPerState 70)

action_71 (88) = happyShift action_81
action_71 _ = happyFail (happyExpListPerState 71)

action_72 (84) = happyShift action_80
action_72 _ = happyFail (happyExpListPerState 72)

action_73 _ = happyReduce_3

action_74 (84) = happyShift action_20
action_74 (86) = happyShift action_21
action_74 (87) = happyShift action_22
action_74 (89) = happyShift action_23
action_74 (103) = happyShift action_24
action_74 (5) = happyGoto action_2
action_74 (31) = happyGoto action_3
action_74 (32) = happyGoto action_4
action_74 (35) = happyGoto action_5
action_74 (38) = happyGoto action_6
action_74 (39) = happyGoto action_7
action_74 (41) = happyGoto action_8
action_74 (45) = happyGoto action_9
action_74 (46) = happyGoto action_79
action_74 (57) = happyGoto action_16
action_74 (58) = happyGoto action_17
action_74 (70) = happyGoto action_18
action_74 (71) = happyGoto action_19
action_74 _ = happyFail (happyExpListPerState 74)

action_75 _ = happyReduce_110

action_76 _ = happyReduce_70

action_77 (84) = happyShift action_20
action_77 (86) = happyShift action_21
action_77 (87) = happyShift action_22
action_77 (89) = happyShift action_23
action_77 (103) = happyShift action_24
action_77 (5) = happyGoto action_2
action_77 (31) = happyGoto action_3
action_77 (32) = happyGoto action_4
action_77 (35) = happyGoto action_5
action_77 (38) = happyGoto action_6
action_77 (39) = happyGoto action_7
action_77 (41) = happyGoto action_8
action_77 (45) = happyGoto action_78
action_77 (57) = happyGoto action_16
action_77 (58) = happyGoto action_17
action_77 (70) = happyGoto action_18
action_77 (71) = happyGoto action_19
action_77 _ = happyReduce_97

action_78 _ = happyReduce_111

action_79 _ = happyReduce_73

action_80 (93) = happyShift action_150
action_80 _ = happyFail (happyExpListPerState 80)

action_81 _ = happyReduce_106

action_82 _ = happyReduce_107

action_83 (84) = happyShift action_20
action_83 (87) = happyShift action_57
action_83 (89) = happyShift action_58
action_83 (99) = happyShift action_149
action_83 (5) = happyGoto action_51
action_83 (18) = happyGoto action_52
action_83 (19) = happyGoto action_53
action_83 (20) = happyGoto action_95
action_83 (21) = happyGoto action_96
action_83 (22) = happyGoto action_97
action_83 (23) = happyGoto action_98
action_83 (24) = happyGoto action_147
action_83 (25) = happyGoto action_148
action_83 (59) = happyGoto action_55
action_83 (73) = happyGoto action_56
action_83 _ = happyFail (happyExpListPerState 83)

action_84 (84) = happyShift action_20
action_84 (5) = happyGoto action_145
action_84 (36) = happyGoto action_146
action_84 _ = happyFail (happyExpListPerState 84)

action_85 (84) = happyShift action_20
action_85 (5) = happyGoto action_143
action_85 (33) = happyGoto action_144
action_85 _ = happyFail (happyExpListPerState 85)

action_86 _ = happyReduce_94

action_87 _ = happyReduce_93

action_88 (84) = happyShift action_20
action_88 (86) = happyShift action_21
action_88 (87) = happyShift action_22
action_88 (89) = happyShift action_23
action_88 (103) = happyShift action_24
action_88 (104) = happyShift action_25
action_88 (106) = happyShift action_26
action_88 (107) = happyShift action_27
action_88 (4) = happyGoto action_142
action_88 (5) = happyGoto action_2
action_88 (31) = happyGoto action_3
action_88 (32) = happyGoto action_4
action_88 (35) = happyGoto action_5
action_88 (38) = happyGoto action_6
action_88 (39) = happyGoto action_7
action_88 (41) = happyGoto action_8
action_88 (45) = happyGoto action_9
action_88 (46) = happyGoto action_10
action_88 (47) = happyGoto action_11
action_88 (48) = happyGoto action_12
action_88 (51) = happyGoto action_13
action_88 (53) = happyGoto action_14
action_88 (56) = happyGoto action_15
action_88 (57) = happyGoto action_16
action_88 (58) = happyGoto action_17
action_88 (70) = happyGoto action_18
action_88 (71) = happyGoto action_19
action_88 _ = happyFail (happyExpListPerState 88)

action_89 (84) = happyShift action_20
action_89 (86) = happyShift action_21
action_89 (87) = happyShift action_22
action_89 (89) = happyShift action_23
action_89 (103) = happyShift action_24
action_89 (104) = happyShift action_25
action_89 (106) = happyShift action_26
action_89 (107) = happyShift action_27
action_89 (4) = happyGoto action_141
action_89 (5) = happyGoto action_2
action_89 (31) = happyGoto action_3
action_89 (32) = happyGoto action_4
action_89 (35) = happyGoto action_5
action_89 (38) = happyGoto action_6
action_89 (39) = happyGoto action_7
action_89 (41) = happyGoto action_8
action_89 (45) = happyGoto action_9
action_89 (46) = happyGoto action_10
action_89 (47) = happyGoto action_11
action_89 (48) = happyGoto action_12
action_89 (51) = happyGoto action_13
action_89 (53) = happyGoto action_14
action_89 (56) = happyGoto action_15
action_89 (57) = happyGoto action_16
action_89 (58) = happyGoto action_17
action_89 (70) = happyGoto action_18
action_89 (71) = happyGoto action_19
action_89 _ = happyFail (happyExpListPerState 89)

action_90 (91) = happyShift action_140
action_90 _ = happyFail (happyExpListPerState 90)

action_91 _ = happyReduce_126

action_92 (90) = happyShift action_139
action_92 _ = happyFail (happyExpListPerState 92)

action_93 _ = happyReduce_21

action_94 (92) = happyShift action_138
action_94 _ = happyReduce_105

action_95 _ = happyReduce_27

action_96 (84) = happyShift action_20
action_96 (87) = happyShift action_57
action_96 (89) = happyShift action_58
action_96 (5) = happyGoto action_51
action_96 (18) = happyGoto action_52
action_96 (19) = happyGoto action_53
action_96 (20) = happyGoto action_137
action_96 (59) = happyGoto action_55
action_96 (73) = happyGoto action_56
action_96 _ = happyReduce_29

action_97 (93) = happyShift action_72
action_97 (98) = happyShift action_73
action_97 (6) = happyGoto action_136
action_97 _ = happyReduce_31

action_98 (97) = happyShift action_135
action_98 _ = happyReduce_32

action_99 (88) = happyShift action_134
action_99 _ = happyFail (happyExpListPerState 99)

action_100 (96) = happyShift action_133
action_100 _ = happyFail (happyExpListPerState 100)

action_101 (84) = happyShift action_42
action_101 (85) = happyShift action_43
action_101 (86) = happyShift action_44
action_101 (87) = happyShift action_45
action_101 (94) = happyShift action_132
action_101 (5) = happyGoto action_29
action_101 (7) = happyGoto action_30
action_101 (8) = happyGoto action_31
action_101 (9) = happyGoto action_32
action_101 (10) = happyGoto action_33
action_101 (11) = happyGoto action_34
action_101 (12) = happyGoto action_35
action_101 (13) = happyGoto action_36
action_101 (14) = happyGoto action_127
action_101 (49) = happyGoto action_128
action_101 (50) = happyGoto action_129
action_101 (64) = happyGoto action_130
action_101 (72) = happyGoto action_40
action_101 (77) = happyGoto action_131
action_101 _ = happyFail (happyExpListPerState 101)

action_102 (84) = happyShift action_20
action_102 (86) = happyShift action_21
action_102 (87) = happyShift action_22
action_102 (89) = happyShift action_23
action_102 (103) = happyShift action_24
action_102 (104) = happyShift action_25
action_102 (106) = happyShift action_26
action_102 (107) = happyShift action_27
action_102 (4) = happyGoto action_126
action_102 (5) = happyGoto action_2
action_102 (31) = happyGoto action_3
action_102 (32) = happyGoto action_4
action_102 (35) = happyGoto action_5
action_102 (38) = happyGoto action_6
action_102 (39) = happyGoto action_7
action_102 (41) = happyGoto action_8
action_102 (45) = happyGoto action_9
action_102 (46) = happyGoto action_10
action_102 (47) = happyGoto action_11
action_102 (48) = happyGoto action_12
action_102 (51) = happyGoto action_13
action_102 (53) = happyGoto action_14
action_102 (56) = happyGoto action_15
action_102 (57) = happyGoto action_16
action_102 (58) = happyGoto action_17
action_102 (70) = happyGoto action_18
action_102 (71) = happyGoto action_19
action_102 _ = happyFail (happyExpListPerState 102)

action_103 _ = happyReduce_118

action_104 (96) = happyShift action_125
action_104 _ = happyFail (happyExpListPerState 104)

action_105 _ = happyReduce_87

action_106 (95) = happyShift action_124
action_106 _ = happyReduce_101

action_107 (88) = happyShift action_122
action_107 (91) = happyShift action_123
action_107 _ = happyFail (happyExpListPerState 107)

action_108 _ = happyReduce_112

action_109 _ = happyReduce_16

action_110 (84) = happyShift action_20
action_110 (85) = happyShift action_43
action_110 (86) = happyShift action_44
action_110 (87) = happyShift action_45
action_110 (5) = happyGoto action_29
action_110 (7) = happyGoto action_30
action_110 (8) = happyGoto action_31
action_110 (9) = happyGoto action_32
action_110 (10) = happyGoto action_33
action_110 (11) = happyGoto action_34
action_110 (12) = happyGoto action_121
action_110 (72) = happyGoto action_40
action_110 _ = happyReduce_98

action_111 (84) = happyShift action_42
action_111 (85) = happyShift action_43
action_111 (86) = happyShift action_44
action_111 (87) = happyShift action_45
action_111 (5) = happyGoto action_29
action_111 (7) = happyGoto action_30
action_111 (8) = happyGoto action_31
action_111 (9) = happyGoto action_32
action_111 (10) = happyGoto action_33
action_111 (11) = happyGoto action_34
action_111 (12) = happyGoto action_35
action_111 (13) = happyGoto action_36
action_111 (14) = happyGoto action_120
action_111 (72) = happyGoto action_40
action_111 _ = happyFail (happyExpListPerState 111)

action_112 (84) = happyShift action_20
action_112 (86) = happyShift action_21
action_112 (87) = happyShift action_22
action_112 (89) = happyShift action_23
action_112 (103) = happyShift action_24
action_112 (104) = happyShift action_25
action_112 (106) = happyShift action_26
action_112 (107) = happyShift action_27
action_112 (4) = happyGoto action_119
action_112 (5) = happyGoto action_2
action_112 (31) = happyGoto action_3
action_112 (32) = happyGoto action_4
action_112 (35) = happyGoto action_5
action_112 (38) = happyGoto action_6
action_112 (39) = happyGoto action_7
action_112 (41) = happyGoto action_8
action_112 (45) = happyGoto action_9
action_112 (46) = happyGoto action_10
action_112 (47) = happyGoto action_11
action_112 (48) = happyGoto action_12
action_112 (51) = happyGoto action_13
action_112 (53) = happyGoto action_14
action_112 (56) = happyGoto action_15
action_112 (57) = happyGoto action_16
action_112 (58) = happyGoto action_17
action_112 (70) = happyGoto action_18
action_112 (71) = happyGoto action_19
action_112 _ = happyFail (happyExpListPerState 112)

action_113 (84) = happyShift action_20
action_113 (86) = happyShift action_21
action_113 (87) = happyShift action_22
action_113 (89) = happyShift action_23
action_113 (94) = happyShift action_118
action_113 (103) = happyShift action_24
action_113 (104) = happyShift action_25
action_113 (106) = happyShift action_26
action_113 (107) = happyShift action_27
action_113 (4) = happyGoto action_117
action_113 (5) = happyGoto action_2
action_113 (31) = happyGoto action_3
action_113 (32) = happyGoto action_4
action_113 (35) = happyGoto action_5
action_113 (38) = happyGoto action_6
action_113 (39) = happyGoto action_7
action_113 (41) = happyGoto action_8
action_113 (45) = happyGoto action_9
action_113 (46) = happyGoto action_10
action_113 (47) = happyGoto action_11
action_113 (48) = happyGoto action_12
action_113 (51) = happyGoto action_13
action_113 (53) = happyGoto action_14
action_113 (56) = happyGoto action_15
action_113 (57) = happyGoto action_16
action_113 (58) = happyGoto action_17
action_113 (70) = happyGoto action_18
action_113 (71) = happyGoto action_19
action_113 _ = happyFail (happyExpListPerState 113)

action_114 (84) = happyShift action_20
action_114 (85) = happyShift action_43
action_114 (86) = happyShift action_44
action_114 (87) = happyShift action_45
action_114 (5) = happyGoto action_115
action_114 (7) = happyGoto action_30
action_114 (8) = happyGoto action_31
action_114 (9) = happyGoto action_32
action_114 (10) = happyGoto action_33
action_114 (11) = happyGoto action_116
action_114 (72) = happyGoto action_40
action_114 _ = happyFail (happyExpListPerState 114)

action_115 _ = happyReduce_5

action_116 _ = happyReduce_14

action_117 _ = happyReduce_91

action_118 (84) = happyShift action_20
action_118 (86) = happyShift action_21
action_118 (87) = happyShift action_22
action_118 (89) = happyShift action_23
action_118 (103) = happyShift action_24
action_118 (104) = happyShift action_25
action_118 (106) = happyShift action_26
action_118 (107) = happyShift action_27
action_118 (4) = happyGoto action_164
action_118 (5) = happyGoto action_2
action_118 (31) = happyGoto action_3
action_118 (32) = happyGoto action_4
action_118 (35) = happyGoto action_5
action_118 (38) = happyGoto action_6
action_118 (39) = happyGoto action_7
action_118 (41) = happyGoto action_8
action_118 (45) = happyGoto action_9
action_118 (46) = happyGoto action_10
action_118 (47) = happyGoto action_11
action_118 (48) = happyGoto action_12
action_118 (51) = happyGoto action_13
action_118 (53) = happyGoto action_14
action_118 (56) = happyGoto action_15
action_118 (57) = happyGoto action_16
action_118 (58) = happyGoto action_17
action_118 (70) = happyGoto action_18
action_118 (71) = happyGoto action_19
action_118 _ = happyFail (happyExpListPerState 118)

action_119 _ = happyReduce_86

action_120 _ = happyReduce_125

action_121 _ = happyReduce_113

action_122 _ = happyReduce_108

action_123 (84) = happyShift action_20
action_123 (87) = happyShift action_57
action_123 (89) = happyShift action_58
action_123 (99) = happyShift action_149
action_123 (5) = happyGoto action_51
action_123 (18) = happyGoto action_52
action_123 (19) = happyGoto action_53
action_123 (20) = happyGoto action_95
action_123 (21) = happyGoto action_96
action_123 (22) = happyGoto action_97
action_123 (23) = happyGoto action_98
action_123 (24) = happyGoto action_147
action_123 (25) = happyGoto action_163
action_123 (59) = happyGoto action_55
action_123 (73) = happyGoto action_56
action_123 _ = happyFail (happyExpListPerState 123)

action_124 (84) = happyShift action_42
action_124 (85) = happyShift action_43
action_124 (86) = happyShift action_44
action_124 (87) = happyShift action_45
action_124 (5) = happyGoto action_29
action_124 (7) = happyGoto action_30
action_124 (8) = happyGoto action_31
action_124 (9) = happyGoto action_32
action_124 (10) = happyGoto action_33
action_124 (11) = happyGoto action_34
action_124 (12) = happyGoto action_35
action_124 (13) = happyGoto action_36
action_124 (14) = happyGoto action_37
action_124 (54) = happyGoto action_162
action_124 (68) = happyGoto action_39
action_124 (72) = happyGoto action_40
action_124 (81) = happyGoto action_41
action_124 _ = happyFail (happyExpListPerState 124)

action_125 (108) = happyShift action_161
action_125 _ = happyFail (happyExpListPerState 125)

action_126 _ = happyReduce_84

action_127 (97) = happyShift action_160
action_127 _ = happyFail (happyExpListPerState 127)

action_128 _ = happyReduce_116

action_129 _ = happyReduce_78

action_130 _ = happyReduce_77

action_131 (95) = happyShift action_159
action_131 _ = happyReduce_100

action_132 (84) = happyShift action_42
action_132 (85) = happyShift action_43
action_132 (86) = happyShift action_44
action_132 (87) = happyShift action_45
action_132 (5) = happyGoto action_29
action_132 (7) = happyGoto action_30
action_132 (8) = happyGoto action_31
action_132 (9) = happyGoto action_32
action_132 (10) = happyGoto action_33
action_132 (11) = happyGoto action_34
action_132 (12) = happyGoto action_35
action_132 (13) = happyGoto action_36
action_132 (14) = happyGoto action_127
action_132 (49) = happyGoto action_128
action_132 (50) = happyGoto action_158
action_132 (64) = happyGoto action_130
action_132 (72) = happyGoto action_40
action_132 (77) = happyGoto action_131
action_132 _ = happyFail (happyExpListPerState 132)

action_133 (105) = happyShift action_157
action_133 _ = happyFail (happyExpListPerState 133)

action_134 _ = happyReduce_109

action_135 (84) = happyShift action_20
action_135 (87) = happyShift action_57
action_135 (89) = happyShift action_58
action_135 (5) = happyGoto action_51
action_135 (18) = happyGoto action_52
action_135 (19) = happyGoto action_53
action_135 (20) = happyGoto action_95
action_135 (21) = happyGoto action_96
action_135 (22) = happyGoto action_97
action_135 (23) = happyGoto action_98
action_135 (24) = happyGoto action_156
action_135 (59) = happyGoto action_55
action_135 (73) = happyGoto action_56
action_135 _ = happyFail (happyExpListPerState 135)

action_136 (84) = happyShift action_20
action_136 (87) = happyShift action_57
action_136 (89) = happyShift action_58
action_136 (5) = happyGoto action_51
action_136 (18) = happyGoto action_52
action_136 (19) = happyGoto action_53
action_136 (20) = happyGoto action_95
action_136 (21) = happyGoto action_155
action_136 (59) = happyGoto action_55
action_136 (73) = happyGoto action_56
action_136 _ = happyFail (happyExpListPerState 136)

action_137 _ = happyReduce_28

action_138 (84) = happyShift action_20
action_138 (5) = happyGoto action_90
action_138 (16) = happyGoto action_154
action_138 _ = happyFail (happyExpListPerState 138)

action_139 _ = happyReduce_95

action_140 (84) = happyShift action_20
action_140 (87) = happyShift action_57
action_140 (89) = happyShift action_58
action_140 (5) = happyGoto action_51
action_140 (18) = happyGoto action_52
action_140 (19) = happyGoto action_53
action_140 (20) = happyGoto action_95
action_140 (21) = happyGoto action_96
action_140 (22) = happyGoto action_97
action_140 (23) = happyGoto action_98
action_140 (24) = happyGoto action_153
action_140 (59) = happyGoto action_55
action_140 (73) = happyGoto action_56
action_140 _ = happyFail (happyExpListPerState 140)

action_141 _ = happyReduce_52

action_142 _ = happyReduce_47

action_143 (91) = happyShift action_88
action_143 _ = happyReduce_48

action_144 _ = happyReduce_121

action_145 (102) = happyShift action_89
action_145 _ = happyFail (happyExpListPerState 145)

action_146 _ = happyReduce_123

action_147 _ = happyReduce_34

action_148 _ = happyReduce_57

action_149 (84) = happyShift action_20
action_149 (5) = happyGoto action_151
action_149 (26) = happyGoto action_152
action_149 _ = happyFail (happyExpListPerState 149)

action_150 _ = happyReduce_4

action_151 _ = happyReduce_36

action_152 (84) = happyShift action_20
action_152 (100) = happyShift action_176
action_152 (5) = happyGoto action_175
action_152 _ = happyFail (happyExpListPerState 152)

action_153 _ = happyReduce_20

action_154 _ = happyReduce_127

action_155 (84) = happyShift action_20
action_155 (87) = happyShift action_57
action_155 (89) = happyShift action_58
action_155 (5) = happyGoto action_51
action_155 (18) = happyGoto action_52
action_155 (19) = happyGoto action_53
action_155 (20) = happyGoto action_137
action_155 (59) = happyGoto action_55
action_155 (73) = happyGoto action_56
action_155 _ = happyReduce_30

action_156 _ = happyReduce_33

action_157 (84) = happyShift action_42
action_157 (85) = happyShift action_43
action_157 (86) = happyShift action_44
action_157 (87) = happyShift action_45
action_157 (94) = happyShift action_174
action_157 (5) = happyGoto action_29
action_157 (7) = happyGoto action_30
action_157 (8) = happyGoto action_31
action_157 (9) = happyGoto action_32
action_157 (10) = happyGoto action_33
action_157 (11) = happyGoto action_34
action_157 (12) = happyGoto action_35
action_157 (13) = happyGoto action_36
action_157 (14) = happyGoto action_127
action_157 (49) = happyGoto action_128
action_157 (50) = happyGoto action_173
action_157 (64) = happyGoto action_130
action_157 (72) = happyGoto action_40
action_157 (77) = happyGoto action_131
action_157 _ = happyFail (happyExpListPerState 157)

action_158 (96) = happyShift action_172
action_158 _ = happyFail (happyExpListPerState 158)

action_159 (84) = happyShift action_42
action_159 (85) = happyShift action_43
action_159 (86) = happyShift action_44
action_159 (87) = happyShift action_45
action_159 (5) = happyGoto action_29
action_159 (7) = happyGoto action_30
action_159 (8) = happyGoto action_31
action_159 (9) = happyGoto action_32
action_159 (10) = happyGoto action_33
action_159 (11) = happyGoto action_34
action_159 (12) = happyGoto action_35
action_159 (13) = happyGoto action_36
action_159 (14) = happyGoto action_127
action_159 (49) = happyGoto action_171
action_159 (72) = happyGoto action_40
action_159 _ = happyFail (happyExpListPerState 159)

action_160 (84) = happyShift action_20
action_160 (86) = happyShift action_21
action_160 (87) = happyShift action_22
action_160 (89) = happyShift action_23
action_160 (94) = happyShift action_170
action_160 (103) = happyShift action_24
action_160 (104) = happyShift action_25
action_160 (106) = happyShift action_26
action_160 (107) = happyShift action_27
action_160 (4) = happyGoto action_169
action_160 (5) = happyGoto action_2
action_160 (31) = happyGoto action_3
action_160 (32) = happyGoto action_4
action_160 (35) = happyGoto action_5
action_160 (38) = happyGoto action_6
action_160 (39) = happyGoto action_7
action_160 (41) = happyGoto action_8
action_160 (45) = happyGoto action_9
action_160 (46) = happyGoto action_10
action_160 (47) = happyGoto action_11
action_160 (48) = happyGoto action_12
action_160 (51) = happyGoto action_13
action_160 (53) = happyGoto action_14
action_160 (56) = happyGoto action_15
action_160 (57) = happyGoto action_16
action_160 (58) = happyGoto action_17
action_160 (70) = happyGoto action_18
action_160 (71) = happyGoto action_19
action_160 _ = happyFail (happyExpListPerState 160)

action_161 (84) = happyShift action_20
action_161 (86) = happyShift action_21
action_161 (87) = happyShift action_22
action_161 (89) = happyShift action_23
action_161 (94) = happyShift action_168
action_161 (103) = happyShift action_24
action_161 (104) = happyShift action_25
action_161 (106) = happyShift action_26
action_161 (107) = happyShift action_27
action_161 (4) = happyGoto action_167
action_161 (5) = happyGoto action_2
action_161 (31) = happyGoto action_3
action_161 (32) = happyGoto action_4
action_161 (35) = happyGoto action_5
action_161 (38) = happyGoto action_6
action_161 (39) = happyGoto action_7
action_161 (41) = happyGoto action_8
action_161 (45) = happyGoto action_9
action_161 (46) = happyGoto action_10
action_161 (47) = happyGoto action_11
action_161 (48) = happyGoto action_12
action_161 (51) = happyGoto action_13
action_161 (53) = happyGoto action_14
action_161 (56) = happyGoto action_15
action_161 (57) = happyGoto action_16
action_161 (58) = happyGoto action_17
action_161 (70) = happyGoto action_18
action_161 (71) = happyGoto action_19
action_161 _ = happyFail (happyExpListPerState 161)

action_162 _ = happyReduce_119

action_163 (88) = happyShift action_166
action_163 _ = happyFail (happyExpListPerState 163)

action_164 (96) = happyShift action_165
action_164 _ = happyFail (happyExpListPerState 164)

action_165 _ = happyReduce_90

action_166 _ = happyReduce_8

action_167 _ = happyReduce_89

action_168 (84) = happyShift action_20
action_168 (86) = happyShift action_21
action_168 (87) = happyShift action_22
action_168 (89) = happyShift action_23
action_168 (103) = happyShift action_24
action_168 (104) = happyShift action_25
action_168 (106) = happyShift action_26
action_168 (107) = happyShift action_27
action_168 (4) = happyGoto action_180
action_168 (5) = happyGoto action_2
action_168 (31) = happyGoto action_3
action_168 (32) = happyGoto action_4
action_168 (35) = happyGoto action_5
action_168 (38) = happyGoto action_6
action_168 (39) = happyGoto action_7
action_168 (41) = happyGoto action_8
action_168 (45) = happyGoto action_9
action_168 (46) = happyGoto action_10
action_168 (47) = happyGoto action_11
action_168 (48) = happyGoto action_12
action_168 (51) = happyGoto action_13
action_168 (53) = happyGoto action_14
action_168 (56) = happyGoto action_15
action_168 (57) = happyGoto action_16
action_168 (58) = happyGoto action_17
action_168 (70) = happyGoto action_18
action_168 (71) = happyGoto action_19
action_168 _ = happyFail (happyExpListPerState 168)

action_169 _ = happyReduce_75

action_170 (84) = happyShift action_20
action_170 (86) = happyShift action_21
action_170 (87) = happyShift action_22
action_170 (89) = happyShift action_23
action_170 (103) = happyShift action_24
action_170 (104) = happyShift action_25
action_170 (106) = happyShift action_26
action_170 (107) = happyShift action_27
action_170 (4) = happyGoto action_179
action_170 (5) = happyGoto action_2
action_170 (31) = happyGoto action_3
action_170 (32) = happyGoto action_4
action_170 (35) = happyGoto action_5
action_170 (38) = happyGoto action_6
action_170 (39) = happyGoto action_7
action_170 (41) = happyGoto action_8
action_170 (45) = happyGoto action_9
action_170 (46) = happyGoto action_10
action_170 (47) = happyGoto action_11
action_170 (48) = happyGoto action_12
action_170 (51) = happyGoto action_13
action_170 (53) = happyGoto action_14
action_170 (56) = happyGoto action_15
action_170 (57) = happyGoto action_16
action_170 (58) = happyGoto action_17
action_170 (70) = happyGoto action_18
action_170 (71) = happyGoto action_19
action_170 _ = happyFail (happyExpListPerState 170)

action_171 _ = happyReduce_117

action_172 _ = happyReduce_80

action_173 _ = happyReduce_79

action_174 (84) = happyShift action_42
action_174 (85) = happyShift action_43
action_174 (86) = happyShift action_44
action_174 (87) = happyShift action_45
action_174 (5) = happyGoto action_29
action_174 (7) = happyGoto action_30
action_174 (8) = happyGoto action_31
action_174 (9) = happyGoto action_32
action_174 (10) = happyGoto action_33
action_174 (11) = happyGoto action_34
action_174 (12) = happyGoto action_35
action_174 (13) = happyGoto action_36
action_174 (14) = happyGoto action_127
action_174 (49) = happyGoto action_128
action_174 (50) = happyGoto action_178
action_174 (64) = happyGoto action_130
action_174 (72) = happyGoto action_40
action_174 (77) = happyGoto action_131
action_174 _ = happyFail (happyExpListPerState 174)

action_175 _ = happyReduce_37

action_176 (84) = happyShift action_20
action_176 (87) = happyShift action_57
action_176 (89) = happyShift action_58
action_176 (5) = happyGoto action_51
action_176 (18) = happyGoto action_52
action_176 (19) = happyGoto action_53
action_176 (20) = happyGoto action_95
action_176 (21) = happyGoto action_96
action_176 (22) = happyGoto action_97
action_176 (23) = happyGoto action_98
action_176 (24) = happyGoto action_177
action_176 (59) = happyGoto action_55
action_176 (73) = happyGoto action_56
action_176 _ = happyFail (happyExpListPerState 176)

action_177 _ = happyReduce_35

action_178 (96) = happyShift action_183
action_178 _ = happyFail (happyExpListPerState 178)

action_179 (96) = happyShift action_182
action_179 _ = happyFail (happyExpListPerState 179)

action_180 (96) = happyShift action_181
action_180 _ = happyFail (happyExpListPerState 180)

action_181 _ = happyReduce_88

action_182 _ = happyReduce_76

action_183 _ = happyReduce_81

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_1  5 happyReduction_2
happyReduction_2 (HappyTerminal (TokenVariable _ happy_var_1))
	 =  HappyAbsSyn5
		 (tokenVariable2Variable happy_var_1
	)
happyReduction_2 _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_1  6 happyReduction_3
happyReduction_3 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn6
		 (case happy_var_1 of 
    TokenOperator _ op ->
      lexerOperator2Operator op
	)
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_3  6 happyReduction_4
happyReduction_4 _
	(HappyTerminal (TokenVariable _ happy_var_2))
	_
	 =  HappyAbsSyn6
		 (let variable = tokenVariable2Variable happy_var_2
    in
      VariableAsOperator (getRange variable) variable
	)
happyReduction_4 _ _ _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_1  7 happyReduction_5
happyReduction_5 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn7
		 (VariablePattern (getRange happy_var_1) happy_var_1
	)
happyReduction_5 _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_1  8 happyReduction_6
happyReduction_6 (HappyTerminal (Hole happy_var_1))
	 =  HappyAbsSyn7
		 (HolePattern happy_var_1
	)
happyReduction_6 _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_1  9 happyReduction_7
happyReduction_7 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn7
		 (let literal=(tokenLiteral2Literal happy_var_1) 
  in 
    LiteralPattern (getRange literal) literal
	)
happyReduction_7 _  = notHappyAtAll 

happyReduce_8 = happyReduce 5 10 happyReduction_8
happyReduction_8 ((HappyTerminal (RightParen happy_var_5)) `HappyStk`
	(HappyAbsSyn18  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_2) `HappyStk`
	(HappyTerminal (LeftParen happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (AnnotationPattern (getRange (happy_var_1,happy_var_5)) happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_9 = happySpecReduce_1  11 happyReduction_9
happyReduction_9 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_9 _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_1  11 happyReduction_10
happyReduction_10 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_10 _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_1  11 happyReduction_11
happyReduction_11 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_11 _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_1  11 happyReduction_12
happyReduction_12 (HappyAbsSyn72  happy_var_1)
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

happyReduce_14 = happySpecReduce_3  12 happyReduction_14
happyReduction_14 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn7
		 (AsPattern (getRange (happy_var_1,happy_var_3)) happy_var_1 happy_var_3
	)
happyReduction_14 _ _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_1  12 happyReduction_15
happyReduction_15 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_15 _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_2  13 happyReduction_16
happyReduction_16 (HappyAbsSyn62  happy_var_2)
	(HappyTerminal (TokenVariable _ happy_var_1))
	 =  HappyAbsSyn7
		 (let variable=(tokenVariable2Variable happy_var_1) 
  in
    ApplicationPattern (getRange(variable,happy_var_2)) variable happy_var_2
	)
happyReduction_16 _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_1  13 happyReduction_17
happyReduction_17 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_17 _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_1  14 happyReduction_18
happyReduction_18 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_18 _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_1  15 happyReduction_19
happyReduction_19 (HappyAbsSyn63  happy_var_1)
	 =  HappyAbsSyn15
		 (happy_var_1
	)
happyReduction_19 _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_3  16 happyReduction_20
happyReduction_20 (HappyAbsSyn18  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn16
		 ((getRange (happy_var_1,happy_var_3),happy_var_1,happy_var_3)
	)
happyReduction_20 _ _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_1  17 happyReduction_21
happyReduction_21 (HappyAbsSyn69  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_21 _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_1  18 happyReduction_22
happyReduction_22 (HappyAbsSyn59  happy_var_1)
	 =  HappyAbsSyn18
		 (RecordType (getRange happy_var_1) (List.reverse happy_var_1)
	)
happyReduction_22 _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_1  19 happyReduction_23
happyReduction_23 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn18
		 (VariableType (getRange happy_var_1) happy_var_1
	)
happyReduction_23 _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_1  20 happyReduction_24
happyReduction_24 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn18
		 (happy_var_1
	)
happyReduction_24 _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_1  20 happyReduction_25
happyReduction_25 (HappyAbsSyn73  happy_var_1)
	 =  HappyAbsSyn18
		 (happy_var_1
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_1  20 happyReduction_26
happyReduction_26 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn18
		 (happy_var_1
	)
happyReduction_26 _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_1  21 happyReduction_27
happyReduction_27 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn18
		 (happy_var_1
	)
happyReduction_27 _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_2  21 happyReduction_28
happyReduction_28 (HappyAbsSyn18  happy_var_2)
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn18
		 (ApplicationType (getRange (happy_var_2,happy_var_1)) happy_var_2 happy_var_1
	)
happyReduction_28 _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_1  22 happyReduction_29
happyReduction_29 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn22
		 (FirstItem happy_var_1
	)
happyReduction_29 _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_3  22 happyReduction_30
happyReduction_30 (HappyAbsSyn18  happy_var_3)
	(HappyAbsSyn6  happy_var_2)
	(HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn22
		 (IntercalatedCons happy_var_3 (IntercalatedCons happy_var_2 happy_var_1)
	)
happyReduction_30 _ _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_1  23 happyReduction_31
happyReduction_31 (HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn18
		 (MeaninglessOperatorsType (getRange happy_var_1) happy_var_1
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_1  24 happyReduction_32
happyReduction_32 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn18
		 (happy_var_1
	)
happyReduction_32 _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_3  24 happyReduction_33
happyReduction_33 (HappyAbsSyn18  happy_var_3)
	_
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn18
		 (TypeArrow (getRange (happy_var_1,happy_var_3)) happy_var_1 happy_var_3
	)
happyReduction_33 _ _ _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_1  25 happyReduction_34
happyReduction_34 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn18
		 (happy_var_1
	)
happyReduction_34 _  = notHappyAtAll 

happyReduce_35 = happyReduce 4 25 happyReduction_35
happyReduction_35 ((HappyAbsSyn18  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn26  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn18
		 (TypeForall (getRange (happy_var_2,happy_var_4)) happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_36 = happySpecReduce_1  26 happyReduction_36
happyReduction_36 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn26
		 (happy_var_1 :| []
	)
happyReduction_36 _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_2  26 happyReduction_37
happyReduction_37 (HappyAbsSyn5  happy_var_2)
	(HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn26
		 (cons happy_var_2 happy_var_1
	)
happyReduction_37 _ _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_1  27 happyReduction_38
happyReduction_38 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn27
		 ([happy_var_1]
	)
happyReduction_38 _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_3  27 happyReduction_39
happyReduction_39 (HappyAbsSyn18  happy_var_3)
	_
	(HappyAbsSyn27  happy_var_1)
	 =  HappyAbsSyn27
		 (happy_var_3:happy_var_1
	)
happyReduction_39 _ _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_1  28 happyReduction_40
happyReduction_40 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn28
		 (Constructor (getRange happy_var_1) happy_var_1 []
	)
happyReduction_40 _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_2  28 happyReduction_41
happyReduction_41 (HappyAbsSyn27  happy_var_2)
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn28
		 (Constructor (getRange happy_var_1) happy_var_1 happy_var_2
	)
happyReduction_41 _ _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_1  29 happyReduction_42
happyReduction_42 (HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn29
		 (happy_var_1:|[]
	)
happyReduction_42 _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_3  29 happyReduction_43
happyReduction_43 (HappyAbsSyn28  happy_var_3)
	_
	(HappyAbsSyn29  happy_var_1)
	 =  HappyAbsSyn29
		 (cons happy_var_3 happy_var_1
	)
happyReduction_43 _ _ _  = notHappyAtAll 

happyReduce_44 = happyReduce 4 30 happyReduction_44
happyReduction_44 ((HappyAbsSyn29  happy_var_4) `HappyStk`
	(HappyAbsSyn60  happy_var_3) `HappyStk`
	(HappyAbsSyn5  happy_var_2) `HappyStk`
	(HappyTerminal (Data happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (ModuleDataType (getRange (happy_var_1,happy_var_4)) happy_var_2 happy_var_3 happy_var_4
	) `HappyStk` happyRest

happyReduce_45 = happySpecReduce_1  31 happyReduction_45
happyReduction_45 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn4
		 (let literal=(tokenLiteral2Literal happy_var_1) 
  in 
    LiteralExpression (getRange literal) literal
	)
happyReduction_45 _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_1  32 happyReduction_46
happyReduction_46 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (VariableExpression (getRange happy_var_1) happy_var_1
	)
happyReduction_46 _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_3  33 happyReduction_47
happyReduction_47 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn33
		 (((getRange (happy_var_1,happy_var_3)),happy_var_1,Just happy_var_3)
	)
happyReduction_47 _ _ _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_1  33 happyReduction_48
happyReduction_48 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn33
		 (((getRange happy_var_1),happy_var_1,Nothing)
	)
happyReduction_48 _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_1  34 happyReduction_49
happyReduction_49 (HappyAbsSyn66  happy_var_1)
	 =  HappyAbsSyn34
		 (happy_var_1
	)
happyReduction_49 _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_1  35 happyReduction_50
happyReduction_50 (HappyAbsSyn57  happy_var_1)
	 =  HappyAbsSyn4
		 (RecordExpression (getRange happy_var_1) (NonEmptyRecord (getRange happy_var_1) happy_var_1)
	)
happyReduction_50 _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_2  35 happyReduction_51
happyReduction_51 (HappyTerminal (RightBrace happy_var_2))
	(HappyTerminal (LeftBrace happy_var_1))
	 =  HappyAbsSyn4
		 (RecordExpression (getRange (happy_var_1,happy_var_2)) (EmptyRecord (getRange (happy_var_1,happy_var_2)))
	)
happyReduction_51 _ _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_3  36 happyReduction_52
happyReduction_52 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn36
		 ((getRange (happy_var_1,happy_var_3),happy_var_1,happy_var_3)
	)
happyReduction_52 _ _ _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_1  37 happyReduction_53
happyReduction_53 (HappyAbsSyn67  happy_var_1)
	 =  HappyAbsSyn37
		 (happy_var_1
	)
happyReduction_53 _  = notHappyAtAll 

happyReduce_54 = happySpecReduce_1  38 happyReduction_54
happyReduction_54 (HappyAbsSyn58  happy_var_1)
	 =  HappyAbsSyn4
		 (RecordUpdate (getRange happy_var_1) (NonEmptyRecord (getRange happy_var_1) happy_var_1
	)
happyReduction_54 _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_1  39 happyReduction_55
happyReduction_55 (HappyAbsSyn71  happy_var_1)
	 =  HappyAbsSyn4
		 (OperatorInParens (getRange happy_var_1) happy_var_1
	)
happyReduction_55 _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_1  40 happyReduction_56
happyReduction_56 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_56 _  = notHappyAtAll 

happyReduce_57 = happySpecReduce_3  40 happyReduction_57
happyReduction_57 (HappyAbsSyn18  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (AnnotationExpression (getRange (happy_var_1,happy_var_3)) happy_var_1 happy_var_3
	)
happyReduction_57 _ _ _  = notHappyAtAll 

happyReduce_58 = happySpecReduce_2  41 happyReduction_58
happyReduction_58 (HappyAbsSyn18  happy_var_2)
	(HappyTerminal (At happy_var_1))
	 =  HappyAbsSyn4
		 (TypeArgumentExpression (getRange (happy_var_1,happy_var_2)) happy_var_2
	)
happyReduction_58 _ _  = notHappyAtAll 

happyReduce_59 = happySpecReduce_3  42 happyReduction_59
happyReduction_59 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (Accessor (getRange (happy_var_1,happy_var_3)) happy_var_1 happy_var_3
	)
happyReduction_59 _ _ _  = notHappyAtAll 

happyReduce_60 = happySpecReduce_3  43 happyReduction_60
happyReduction_60 (HappyAbsSyn5  happy_var_3)
	_
	(HappyTerminal (Hole happy_var_1))
	 =  HappyAbsSyn4
		 (AccessorFunction (getRange (happy_var_1,happy_var_3)) happy_var_3
	)
happyReduction_60 _ _ _  = notHappyAtAll 

happyReduce_61 = happySpecReduce_1  44 happyReduction_61
happyReduction_61 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_61 _  = notHappyAtAll 

happyReduce_62 = happySpecReduce_1  44 happyReduction_62
happyReduction_62 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_62 _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_1  45 happyReduction_63
happyReduction_63 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_63 _  = notHappyAtAll 

happyReduce_64 = happySpecReduce_1  45 happyReduction_64
happyReduction_64 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_64 _  = notHappyAtAll 

happyReduce_65 = happySpecReduce_1  45 happyReduction_65
happyReduction_65 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_65 _  = notHappyAtAll 

happyReduce_66 = happySpecReduce_1  45 happyReduction_66
happyReduction_66 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_66 _  = notHappyAtAll 

happyReduce_67 = happySpecReduce_1  45 happyReduction_67
happyReduction_67 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_67 _  = notHappyAtAll 

happyReduce_68 = happySpecReduce_1  45 happyReduction_68
happyReduction_68 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_68 _  = notHappyAtAll 

happyReduce_69 = happySpecReduce_1  45 happyReduction_69
happyReduction_69 (HappyAbsSyn70  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_69 _  = notHappyAtAll 

happyReduce_70 = happySpecReduce_2  46 happyReduction_70
happyReduction_70 (HappyAbsSyn61  happy_var_2)
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (ApplicationExpression (getRange (happy_var_1,happy_var_2)) happy_var_1 happy_var_2
	)
happyReduction_70 _ _  = notHappyAtAll 

happyReduce_71 = happySpecReduce_1  46 happyReduction_71
happyReduction_71 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_71 _  = notHappyAtAll 

happyReduce_72 = happySpecReduce_1  47 happyReduction_72
happyReduction_72 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn47
		 (FirstItem happy_var_1
	)
happyReduction_72 _  = notHappyAtAll 

happyReduce_73 = happySpecReduce_3  47 happyReduction_73
happyReduction_73 (HappyAbsSyn4  happy_var_3)
	(HappyAbsSyn6  happy_var_2)
	(HappyAbsSyn47  happy_var_1)
	 =  HappyAbsSyn47
		 (IntercalatedCons happy_var_3 (IntercalatedCons happy_var_2 happy_var_1)
	)
happyReduction_73 _ _ _  = notHappyAtAll 

happyReduce_74 = happySpecReduce_1  48 happyReduction_74
happyReduction_74 (HappyAbsSyn47  happy_var_1)
	 =  HappyAbsSyn4
		 (MeaninglessOperatorsExpression (trace (show happy_var_1) (getRange happy_var_1)) happy_var_1
	)
happyReduction_74 _  = notHappyAtAll 

happyReduce_75 = happySpecReduce_3  49 happyReduction_75
happyReduction_75 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn49
		 (CaseCase (getRange (happy_var_1,happy_var_3)) happy_var_1 happy_var_3
	)
happyReduction_75 _ _ _  = notHappyAtAll 

happyReduce_76 = happyReduce 5 49 happyReduction_76
happyReduction_76 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn49
		 (CaseCase (getRange (happy_var_1,happy_var_4)) happy_var_1 happy_var_4
	) `HappyStk` happyRest

happyReduce_77 = happySpecReduce_1  50 happyReduction_77
happyReduction_77 (HappyAbsSyn64  happy_var_1)
	 =  HappyAbsSyn50
		 (happy_var_1
	)
happyReduction_77 _  = notHappyAtAll 

happyReduce_78 = happyReduce 4 51 happyReduction_78
happyReduction_78 ((HappyAbsSyn50  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	(HappyTerminal (Case happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (SST.Case (getRange (happy_var_1,happy_var_4)) happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_79 = happyReduce 6 51 happyReduction_79
happyReduction_79 ((HappyAbsSyn50  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Case happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (SST.Case (getRange (happy_var_1,happy_var_6)) happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_80 = happyReduce 6 51 happyReduction_80
happyReduction_80 (_ `HappyStk`
	(HappyAbsSyn50  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	(HappyTerminal (Case happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (SST.Case (getRange (happy_var_1,happy_var_5)) happy_var_2 happy_var_5
	) `HappyStk` happyRest

happyReduce_81 = happyReduce 8 51 happyReduction_81
happyReduction_81 (_ `HappyStk`
	(HappyAbsSyn50  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Case happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (SST.Case (getRange (happy_var_1,happy_var_7)) happy_var_3 happy_var_7
	) `HappyStk` happyRest

happyReduce_82 = happySpecReduce_1  51 happyReduction_82
happyReduction_82 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_82 _  = notHappyAtAll 

happyReduce_83 = happySpecReduce_1  52 happyReduction_83
happyReduction_83 (HappyAbsSyn68  happy_var_1)
	 =  HappyAbsSyn15
		 (happy_var_1
	)
happyReduction_83 _  = notHappyAtAll 

happyReduce_84 = happyReduce 4 53 happyReduction_84
happyReduction_84 ((HappyAbsSyn4  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn15  happy_var_2) `HappyStk`
	(HappyTerminal (LambdaStart happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Lambda (getRange (happy_var_1,happy_var_4)) happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_85 = happySpecReduce_1  53 happyReduction_85
happyReduction_85 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_85 _  = notHappyAtAll 

happyReduce_86 = happySpecReduce_3  54 happyReduction_86
happyReduction_86 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn68  happy_var_1)
	 =  HappyAbsSyn54
		 (LetBinding (getRange (happy_var_1,happy_var_3)) happy_var_1 happy_var_3
	)
happyReduction_86 _ _ _  = notHappyAtAll 

happyReduce_87 = happySpecReduce_1  55 happyReduction_87
happyReduction_87 (HappyAbsSyn65  happy_var_1)
	 =  HappyAbsSyn55
		 (happy_var_1
	)
happyReduction_87 _  = notHappyAtAll 

happyReduce_88 = happyReduce 8 56 happyReduction_88
happyReduction_88 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn55  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Let happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (SST.Let (getRange (happy_var_1,happy_var_7)) happy_var_3 happy_var_7
	) `HappyStk` happyRest

happyReduce_89 = happyReduce 6 56 happyReduction_89
happyReduction_89 ((HappyAbsSyn4  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn55  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Let happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (SST.Let (getRange (happy_var_1,happy_var_6)) happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_90 = happyReduce 6 56 happyReduction_90
happyReduction_90 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn54  happy_var_2) `HappyStk`
	(HappyTerminal (Let happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (SST.Let (getRange (happy_var_1,happy_var_5)) (happy_var_2 :|[]) happy_var_5
	) `HappyStk` happyRest

happyReduce_91 = happyReduce 4 56 happyReduction_91
happyReduction_91 ((HappyAbsSyn4  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn54  happy_var_2) `HappyStk`
	(HappyTerminal (Let happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (SST.Let (getRange (happy_var_1,happy_var_4)) (happy_var_2 :| []) happy_var_4
	) `HappyStk` happyRest

happyReduce_92 = happySpecReduce_1  56 happyReduction_92
happyReduction_92 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_92 _  = notHappyAtAll 

happyReduce_93 = happySpecReduce_3  57 happyReduction_93
happyReduction_93 _
	(HappyAbsSyn34  happy_var_2)
	_
	 =  HappyAbsSyn57
		 (happy_var_2
	)
happyReduction_93 _ _ _  = notHappyAtAll 

happyReduce_94 = happySpecReduce_3  58 happyReduction_94
happyReduction_94 _
	(HappyAbsSyn37  happy_var_2)
	_
	 =  HappyAbsSyn58
		 (happy_var_2
	)
happyReduction_94 _ _ _  = notHappyAtAll 

happyReduce_95 = happySpecReduce_3  59 happyReduction_95
happyReduction_95 _
	(HappyAbsSyn17  happy_var_2)
	_
	 =  HappyAbsSyn59
		 (happy_var_2
	)
happyReduction_95 _ _ _  = notHappyAtAll 

happyReduce_96 = happySpecReduce_1  60 happyReduction_96
happyReduction_96 (HappyAbsSyn83  happy_var_1)
	 =  HappyAbsSyn60
		 (List.reverse happy_var_1
	)
happyReduction_96 _  = notHappyAtAll 

happyReduce_97 = happySpecReduce_1  61 happyReduction_97
happyReduction_97 (HappyAbsSyn74  happy_var_1)
	 =  HappyAbsSyn61
		 (reverse happy_var_1
	)
happyReduction_97 _  = notHappyAtAll 

happyReduce_98 = happySpecReduce_1  62 happyReduction_98
happyReduction_98 (HappyAbsSyn75  happy_var_1)
	 =  HappyAbsSyn62
		 (reverse happy_var_1
	)
happyReduction_98 _  = notHappyAtAll 

happyReduce_99 = happySpecReduce_1  63 happyReduction_99
happyReduction_99 (HappyAbsSyn76  happy_var_1)
	 =  HappyAbsSyn63
		 (reverse happy_var_1
	)
happyReduction_99 _  = notHappyAtAll 

happyReduce_100 = happySpecReduce_1  64 happyReduction_100
happyReduction_100 (HappyAbsSyn77  happy_var_1)
	 =  HappyAbsSyn64
		 (reverse happy_var_1
	)
happyReduction_100 _  = notHappyAtAll 

happyReduce_101 = happySpecReduce_1  65 happyReduction_101
happyReduction_101 (HappyAbsSyn78  happy_var_1)
	 =  HappyAbsSyn65
		 (reverse happy_var_1
	)
happyReduction_101 _  = notHappyAtAll 

happyReduce_102 = happySpecReduce_1  66 happyReduction_102
happyReduction_102 (HappyAbsSyn79  happy_var_1)
	 =  HappyAbsSyn66
		 (reverse happy_var_1
	)
happyReduction_102 _  = notHappyAtAll 

happyReduce_103 = happySpecReduce_1  67 happyReduction_103
happyReduction_103 (HappyAbsSyn80  happy_var_1)
	 =  HappyAbsSyn67
		 (reverse happy_var_1
	)
happyReduction_103 _  = notHappyAtAll 

happyReduce_104 = happySpecReduce_1  68 happyReduction_104
happyReduction_104 (HappyAbsSyn81  happy_var_1)
	 =  HappyAbsSyn68
		 (reverse happy_var_1
	)
happyReduction_104 _  = notHappyAtAll 

happyReduce_105 = happySpecReduce_1  69 happyReduction_105
happyReduction_105 (HappyAbsSyn82  happy_var_1)
	 =  HappyAbsSyn69
		 (reverse happy_var_1
	)
happyReduction_105 _  = notHappyAtAll 

happyReduce_106 = happySpecReduce_3  70 happyReduction_106
happyReduction_106 _
	(HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn70
		 (happy_var_2
	)
happyReduction_106 _ _ _  = notHappyAtAll 

happyReduce_107 = happySpecReduce_3  71 happyReduction_107
happyReduction_107 _
	(HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn71
		 (happy_var_2
	)
happyReduction_107 _ _ _  = notHappyAtAll 

happyReduce_108 = happySpecReduce_3  72 happyReduction_108
happyReduction_108 _
	(HappyAbsSyn7  happy_var_2)
	_
	 =  HappyAbsSyn72
		 (happy_var_2
	)
happyReduction_108 _ _ _  = notHappyAtAll 

happyReduce_109 = happySpecReduce_3  73 happyReduction_109
happyReduction_109 _
	(HappyAbsSyn18  happy_var_2)
	_
	 =  HappyAbsSyn73
		 (happy_var_2
	)
happyReduction_109 _ _ _  = notHappyAtAll 

happyReduce_110 = happySpecReduce_1  74 happyReduction_110
happyReduction_110 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn74
		 (happy_var_1 :| []
	)
happyReduction_110 _  = notHappyAtAll 

happyReduce_111 = happySpecReduce_2  74 happyReduction_111
happyReduction_111 (HappyAbsSyn4  happy_var_2)
	(HappyAbsSyn74  happy_var_1)
	 =  HappyAbsSyn74
		 (cons happy_var_2 happy_var_1
	)
happyReduction_111 _ _  = notHappyAtAll 

happyReduce_112 = happySpecReduce_1  75 happyReduction_112
happyReduction_112 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn75
		 (happy_var_1 :| []
	)
happyReduction_112 _  = notHappyAtAll 

happyReduce_113 = happySpecReduce_2  75 happyReduction_113
happyReduction_113 (HappyAbsSyn7  happy_var_2)
	(HappyAbsSyn75  happy_var_1)
	 =  HappyAbsSyn75
		 (cons happy_var_2 happy_var_1
	)
happyReduction_113 _ _  = notHappyAtAll 

happyReduce_114 = happySpecReduce_1  76 happyReduction_114
happyReduction_114 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn76
		 (happy_var_1 :| []
	)
happyReduction_114 _  = notHappyAtAll 

happyReduce_115 = happySpecReduce_2  76 happyReduction_115
happyReduction_115 (HappyAbsSyn7  happy_var_2)
	(HappyAbsSyn76  happy_var_1)
	 =  HappyAbsSyn76
		 (cons happy_var_2 happy_var_1
	)
happyReduction_115 _ _  = notHappyAtAll 

happyReduce_116 = happySpecReduce_1  77 happyReduction_116
happyReduction_116 (HappyAbsSyn49  happy_var_1)
	 =  HappyAbsSyn77
		 (happy_var_1 :| []
	)
happyReduction_116 _  = notHappyAtAll 

happyReduce_117 = happySpecReduce_3  77 happyReduction_117
happyReduction_117 (HappyAbsSyn49  happy_var_3)
	_
	(HappyAbsSyn77  happy_var_1)
	 =  HappyAbsSyn77
		 (cons happy_var_3 happy_var_1
	)
happyReduction_117 _ _ _  = notHappyAtAll 

happyReduce_118 = happySpecReduce_1  78 happyReduction_118
happyReduction_118 (HappyAbsSyn54  happy_var_1)
	 =  HappyAbsSyn78
		 (happy_var_1 :| []
	)
happyReduction_118 _  = notHappyAtAll 

happyReduce_119 = happySpecReduce_3  78 happyReduction_119
happyReduction_119 (HappyAbsSyn54  happy_var_3)
	_
	(HappyAbsSyn78  happy_var_1)
	 =  HappyAbsSyn78
		 (cons happy_var_3 happy_var_1
	)
happyReduction_119 _ _ _  = notHappyAtAll 

happyReduce_120 = happySpecReduce_1  79 happyReduction_120
happyReduction_120 (HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn79
		 (happy_var_1 :| []
	)
happyReduction_120 _  = notHappyAtAll 

happyReduce_121 = happySpecReduce_3  79 happyReduction_121
happyReduction_121 (HappyAbsSyn33  happy_var_3)
	_
	(HappyAbsSyn79  happy_var_1)
	 =  HappyAbsSyn79
		 (cons happy_var_3 happy_var_1
	)
happyReduction_121 _ _ _  = notHappyAtAll 

happyReduce_122 = happySpecReduce_1  80 happyReduction_122
happyReduction_122 (HappyAbsSyn36  happy_var_1)
	 =  HappyAbsSyn80
		 (happy_var_1 :| []
	)
happyReduction_122 _  = notHappyAtAll 

happyReduce_123 = happySpecReduce_3  80 happyReduction_123
happyReduction_123 (HappyAbsSyn36  happy_var_3)
	_
	(HappyAbsSyn80  happy_var_1)
	 =  HappyAbsSyn80
		 (cons happy_var_3 happy_var_1
	)
happyReduction_123 _ _ _  = notHappyAtAll 

happyReduce_124 = happySpecReduce_1  81 happyReduction_124
happyReduction_124 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn81
		 (happy_var_1 :| []
	)
happyReduction_124 _  = notHappyAtAll 

happyReduce_125 = happySpecReduce_3  81 happyReduction_125
happyReduction_125 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn81  happy_var_1)
	 =  HappyAbsSyn81
		 (cons happy_var_3 happy_var_1
	)
happyReduction_125 _ _ _  = notHappyAtAll 

happyReduce_126 = happySpecReduce_1  82 happyReduction_126
happyReduction_126 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn82
		 (happy_var_1 :| []
	)
happyReduction_126 _  = notHappyAtAll 

happyReduce_127 = happySpecReduce_3  82 happyReduction_127
happyReduction_127 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn82  happy_var_1)
	 =  HappyAbsSyn82
		 (cons happy_var_3 happy_var_1
	)
happyReduction_127 _ _ _  = notHappyAtAll 

happyReduce_128 = happySpecReduce_0  83 happyReduction_128
happyReduction_128  =  HappyAbsSyn83
		 ([]
	)

happyReduce_129 = happySpecReduce_2  83 happyReduction_129
happyReduction_129 (HappyAbsSyn5  happy_var_2)
	(HappyAbsSyn83  happy_var_1)
	 =  HappyAbsSyn83
		 (happy_var_2:happy_var_1
	)
happyReduction_129 _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 109 109 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenVariable _ happy_dollar_dollar -> cont 84;
	Hole happy_dollar_dollar -> cont 85;
	LiteralUint _ _ -> cont 86;
	LeftParen happy_dollar_dollar -> cont 87;
	RightParen happy_dollar_dollar -> cont 88;
	LeftBrace happy_dollar_dollar -> cont 89;
	RightBrace happy_dollar_dollar -> cont 90;
	Colon happy_dollar_dollar -> cont 91;
	Comma happy_dollar_dollar -> cont 92;
	BackTick happy_dollar_dollar -> cont 93;
	LayoutStart happy_dollar_dollar -> cont 94;
	LayoutSeparator happy_dollar_dollar -> cont 95;
	LayoutEnd happy_dollar_dollar -> cont 96;
	RightArrow happy_dollar_dollar -> cont 97;
	TokenOperator _ _ -> cont 98;
	Forall happy_dollar_dollar -> cont 99;
	Dot happy_dollar_dollar -> cont 100;
	Data happy_dollar_dollar -> cont 101;
	Equal happy_dollar_dollar -> cont 102;
	At happy_dollar_dollar -> cont 103;
	Case happy_dollar_dollar -> cont 104;
	Of happy_dollar_dollar -> cont 105;
	LambdaStart happy_dollar_dollar -> cont 106;
	Let happy_dollar_dollar -> cont 107;
	In happy_dollar_dollar -> cont 108;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 109 tk tks = happyError' (tks, explist)
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
