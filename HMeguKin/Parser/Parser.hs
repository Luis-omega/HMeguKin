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

data HappyAbsSyn t57 t58 t59 t60 t61 t62 t63 t64 t65 t66 t67 t68 t69 t70 t71 t72 t73 t74 t75 t76 t77 t78 t79
	= HappyTerminal (Token)
	| HappyErrorToken Prelude.Int
	| HappyAbsSyn4 (Expression)
	| HappyAbsSyn5 (Variable)
	| HappyAbsSyn6 (Operator)
	| HappyAbsSyn7 (Pattern)
	| HappyAbsSyn14 (NonEmpty Pattern)
	| HappyAbsSyn15 ((Range,Variable,Type))
	| HappyAbsSyn16 ([(Range,Variable,Type)])
	| HappyAbsSyn17 (Type)
	| HappyAbsSyn21 (IntercalatedList Type Operator)
	| HappyAbsSyn25 (NonEmpty Variable)
	| HappyAbsSyn26 ([Type])
	| HappyAbsSyn27 (Constructor)
	| HappyAbsSyn28 (NonEmpty Constructor)
	| HappyAbsSyn29 (DataType)
	| HappyAbsSyn32 ((Range,Variable,Maybe Expression))
	| HappyAbsSyn33 ([(Range,Variable,Maybe Expression)])
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

happyExpList :: Happy_Data_Array.Array Prelude.Int Prelude.Int
happyExpList = Happy_Data_Array.listArray (0,1104) ([0,0,0,0,32768,22,108,0,0,0,0,11520,55296,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17824,6920,0,0,0,0,16384,16,0,0,0,0,0,5248,0,0,0,0,0,0,1069,216,0,0,0,0,7680,0,0,0,0,0,0,4156,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,15,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,30720,0,0,0,0,0,0,240,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,11520,55296,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5248,0,0,0,0,0,0,1,0,0,0,0,0,0,2049,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5120,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,128,0,0,0,0,0,0,1,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,5760,1024,0,0,0,0,0,0,0,0,0,0,0,23040,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,16404,0,0,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,53248,32770,13,0,0,0,0,1440,6912,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,320,0,0,0,0,0,0,0,0,0,0,0,0,164,0,0,0,0,0,0,528,0,0,0,0,0,0,2,0,0,0,0,0,2,0,0,0,0,0,0,4,0,0,0,0,32768,519,0,0,0,0,0,11520,55296,0,0,0,0,0,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,128,0,0,0,0,0,4608,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,15,0,0,0,0,0,7680,0,0,0,0,0,0,180,864,0,0,0,0,26624,49185,6,0,0,0,0,0,0,0,0,0,0,40960,5,27,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,41984,512,0,0,0,0,0,120,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,30720,0,0,0,0,0,0,0,512,0,0,0,0,0,0,0,0,0,0,0,2624,0,0,0,0,0,32768,20,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1024,0,0,0,0,0,0,328,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,41984,0,0,0,0,0,0,0,0,0,0,0,0,61440,64,0,0,0,0,0,0,2,0,0,0,0,49152,3,0,0,0,0,0,5760,27650,0,0,0,0,0,1069,216,0,0,0,0,0,0,0,0,0,0,0,64,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,22,108,0,0,0,0,0,0,0,0,0,0,0,90,432,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,480,0,0,0,0,0,0,0,0,0,0,0,0,5248,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,0,0,16384,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","expression","meta_variable","meta_operator","pattern_match_variable","pattern_match_hole","pattern_match_literal","pattern_annotation","pattern_match_atom","pattern_match_application","pattern_match","pattern_match_function_args","type_record_item","type_record_inner","type_record","type_variable","type_atom","type_application","type_operators_plus","type_operators","type_expression_inner","type_scheme","type_data_type_args","type_expression_inner_sep_comma","data_type_constructor","data_type_constructor_plus","data_type","expression_literal","expression_variable","expression_record_item","expression_record_inner_plus","expression_record_inner","expression_record","expression_record_update_item","expression_record_update_inner","expression_record_update","expression_operator_parens","expression_annotation","expression_type_arg","expression_accessor_field","expression_accessor_funtion","expression_accessor","expression_atom","expression_application","expression_operators_plus","expression_operators","expression_case_single","expression_case_cases","expression_case","expression_lambda_arguments","expression_lambda","expression_let_binding","expression_let_inside","expression_let","braces__expression_record_inner__","braces__expression_record_update_inner__","braces__type_record_inner__","list__expression_atom__","list__meta_variable__","list1__pattern_match__","list1__pattern_match_atom__","listSepBy1__expression_case_single__LayoutSeparator__","listSepBy1__expression_let_binding__LayoutSeparator__","listSepBy1__expression_record_update_item__Comma__","listSepBy1__pattern_match__Comma__","parens__expression_annotation__","parens__meta_operator__","parens__pattern_match__","parens__type_expression_inner__","plus__pattern_match__","plus__pattern_match_atom__","sepBy1__expression_case_single__LayoutSeparator__","sepBy1__expression_let_binding__LayoutSeparator__","sepBy1__expression_record_update_item__Comma__","sepBy1__pattern_match__Comma__","star__expression_atom__","star__meta_variable__","Variable","Hole","Int","LParen","RParen","LBrace","RBrace","Colon","Comma","BackTick","LayoutStart","LayoutSeparator","LayoutEnd","RightArrow","TokenOperator","Forall","Dot","Data","Equal","At","Case","Of","Lambda","Let","In","%eof"]
        bit_start = st Prelude.* 105
        bit_end = (st Prelude.+ 1) Prelude.* 105
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..104]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

action_0 (80) = happyShift action_20
action_0 (82) = happyShift action_21
action_0 (83) = happyShift action_22
action_0 (85) = happyShift action_23
action_0 (99) = happyShift action_24
action_0 (100) = happyShift action_25
action_0 (102) = happyShift action_26
action_0 (103) = happyShift action_27
action_0 (4) = happyGoto action_28
action_0 (5) = happyGoto action_2
action_0 (30) = happyGoto action_3
action_0 (31) = happyGoto action_4
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
action_0 (68) = happyGoto action_18
action_0 (69) = happyGoto action_19
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (80) = happyShift action_20
action_1 (82) = happyShift action_21
action_1 (83) = happyShift action_22
action_1 (85) = happyShift action_23
action_1 (99) = happyShift action_24
action_1 (100) = happyShift action_25
action_1 (102) = happyShift action_26
action_1 (103) = happyShift action_27
action_1 (5) = happyGoto action_2
action_1 (30) = happyGoto action_3
action_1 (31) = happyGoto action_4
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
action_1 (68) = happyGoto action_18
action_1 (69) = happyGoto action_19
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyReduce_45

action_3 _ = happyReduce_65

action_4 _ = happyReduce_64

action_5 _ = happyReduce_66

action_6 _ = happyReduce_67

action_7 _ = happyReduce_68

action_8 _ = happyReduce_69

action_9 (60) = happyGoto action_73
action_9 (78) = happyGoto action_74
action_9 _ = happyReduce_120

action_10 _ = happyReduce_72

action_11 (89) = happyShift action_70
action_11 (94) = happyShift action_71
action_11 (6) = happyGoto action_72
action_11 _ = happyReduce_74

action_12 _ = happyReduce_82

action_13 _ = happyReduce_85

action_14 _ = happyReduce_92

action_15 _ = happyReduce_1

action_16 _ = happyReduce_51

action_17 _ = happyReduce_55

action_18 _ = happyReduce_70

action_19 _ = happyReduce_56

action_20 _ = happyReduce_2

action_21 _ = happyReduce_44

action_22 (80) = happyShift action_20
action_22 (82) = happyShift action_21
action_22 (83) = happyShift action_22
action_22 (85) = happyShift action_23
action_22 (89) = happyShift action_70
action_22 (94) = happyShift action_71
action_22 (99) = happyShift action_24
action_22 (100) = happyShift action_25
action_22 (102) = happyShift action_26
action_22 (103) = happyShift action_27
action_22 (4) = happyGoto action_67
action_22 (5) = happyGoto action_2
action_22 (6) = happyGoto action_68
action_22 (30) = happyGoto action_3
action_22 (31) = happyGoto action_4
action_22 (35) = happyGoto action_5
action_22 (38) = happyGoto action_6
action_22 (39) = happyGoto action_7
action_22 (40) = happyGoto action_69
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
action_22 (68) = happyGoto action_18
action_22 (69) = happyGoto action_19
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (80) = happyShift action_20
action_23 (86) = happyShift action_66
action_23 (5) = happyGoto action_58
action_23 (32) = happyGoto action_59
action_23 (33) = happyGoto action_60
action_23 (34) = happyGoto action_61
action_23 (36) = happyGoto action_62
action_23 (37) = happyGoto action_63
action_23 (66) = happyGoto action_64
action_23 (76) = happyGoto action_65
action_23 _ = happyFail (happyExpListPerState 23)

action_24 (80) = happyShift action_20
action_24 (83) = happyShift action_56
action_24 (85) = happyShift action_57
action_24 (5) = happyGoto action_50
action_24 (17) = happyGoto action_51
action_24 (18) = happyGoto action_52
action_24 (19) = happyGoto action_53
action_24 (59) = happyGoto action_54
action_24 (71) = happyGoto action_55
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (80) = happyShift action_20
action_25 (82) = happyShift action_21
action_25 (83) = happyShift action_22
action_25 (85) = happyShift action_23
action_25 (90) = happyShift action_49
action_25 (99) = happyShift action_24
action_25 (100) = happyShift action_25
action_25 (102) = happyShift action_26
action_25 (103) = happyShift action_27
action_25 (4) = happyGoto action_48
action_25 (5) = happyGoto action_2
action_25 (30) = happyGoto action_3
action_25 (31) = happyGoto action_4
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
action_25 (68) = happyGoto action_18
action_25 (69) = happyGoto action_19
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (80) = happyShift action_41
action_26 (81) = happyShift action_42
action_26 (82) = happyShift action_43
action_26 (83) = happyShift action_44
action_26 (5) = happyGoto action_29
action_26 (7) = happyGoto action_30
action_26 (8) = happyGoto action_31
action_26 (9) = happyGoto action_32
action_26 (10) = happyGoto action_33
action_26 (11) = happyGoto action_34
action_26 (12) = happyGoto action_35
action_26 (13) = happyGoto action_36
action_26 (52) = happyGoto action_46
action_26 (67) = happyGoto action_47
action_26 (70) = happyGoto action_39
action_26 (77) = happyGoto action_40
action_26 _ = happyFail (happyExpListPerState 26)

action_27 (80) = happyShift action_41
action_27 (81) = happyShift action_42
action_27 (82) = happyShift action_43
action_27 (83) = happyShift action_44
action_27 (90) = happyShift action_45
action_27 (5) = happyGoto action_29
action_27 (7) = happyGoto action_30
action_27 (8) = happyGoto action_31
action_27 (9) = happyGoto action_32
action_27 (10) = happyGoto action_33
action_27 (11) = happyGoto action_34
action_27 (12) = happyGoto action_35
action_27 (13) = happyGoto action_36
action_27 (54) = happyGoto action_37
action_27 (67) = happyGoto action_38
action_27 (70) = happyGoto action_39
action_27 (77) = happyGoto action_40
action_27 _ = happyFail (happyExpListPerState 27)

action_28 (105) = happyAccept
action_28 _ = happyFail (happyExpListPerState 28)

action_29 _ = happyReduce_5

action_30 _ = happyReduce_10

action_31 _ = happyReduce_11

action_32 _ = happyReduce_9

action_33 _ = happyReduce_13

action_34 _ = happyReduce_15

action_35 _ = happyReduce_16

action_36 _ = happyReduce_118

action_37 (104) = happyShift action_108
action_37 _ = happyFail (happyExpListPerState 37)

action_38 (98) = happyShift action_107
action_38 _ = happyFail (happyExpListPerState 38)

action_39 _ = happyReduce_12

action_40 (88) = happyShift action_106
action_40 _ = happyReduce_103

action_41 (80) = happyShift action_20
action_41 (81) = happyShift action_42
action_41 (82) = happyShift action_43
action_41 (83) = happyShift action_44
action_41 (5) = happyGoto action_29
action_41 (7) = happyGoto action_30
action_41 (8) = happyGoto action_31
action_41 (9) = happyGoto action_32
action_41 (10) = happyGoto action_33
action_41 (11) = happyGoto action_103
action_41 (63) = happyGoto action_104
action_41 (70) = happyGoto action_39
action_41 (73) = happyGoto action_105
action_41 _ = happyReduce_2

action_42 _ = happyReduce_6

action_43 _ = happyReduce_7

action_44 (80) = happyShift action_41
action_44 (81) = happyShift action_42
action_44 (82) = happyShift action_43
action_44 (83) = happyShift action_44
action_44 (5) = happyGoto action_29
action_44 (7) = happyGoto action_30
action_44 (8) = happyGoto action_31
action_44 (9) = happyGoto action_32
action_44 (10) = happyGoto action_33
action_44 (11) = happyGoto action_34
action_44 (12) = happyGoto action_35
action_44 (13) = happyGoto action_102
action_44 (70) = happyGoto action_39
action_44 _ = happyFail (happyExpListPerState 44)

action_45 (80) = happyShift action_41
action_45 (81) = happyShift action_42
action_45 (82) = happyShift action_43
action_45 (83) = happyShift action_44
action_45 (5) = happyGoto action_29
action_45 (7) = happyGoto action_30
action_45 (8) = happyGoto action_31
action_45 (9) = happyGoto action_32
action_45 (10) = happyGoto action_33
action_45 (11) = happyGoto action_34
action_45 (12) = happyGoto action_35
action_45 (13) = happyGoto action_36
action_45 (54) = happyGoto action_98
action_45 (55) = happyGoto action_99
action_45 (65) = happyGoto action_100
action_45 (67) = happyGoto action_38
action_45 (70) = happyGoto action_39
action_45 (75) = happyGoto action_101
action_45 (77) = happyGoto action_40
action_45 _ = happyFail (happyExpListPerState 45)

action_46 (93) = happyShift action_97
action_46 _ = happyFail (happyExpListPerState 46)

action_47 _ = happyReduce_83

action_48 (101) = happyShift action_96
action_48 _ = happyFail (happyExpListPerState 48)

action_49 (80) = happyShift action_20
action_49 (82) = happyShift action_21
action_49 (83) = happyShift action_22
action_49 (85) = happyShift action_23
action_49 (99) = happyShift action_24
action_49 (100) = happyShift action_25
action_49 (102) = happyShift action_26
action_49 (103) = happyShift action_27
action_49 (4) = happyGoto action_95
action_49 (5) = happyGoto action_2
action_49 (30) = happyGoto action_3
action_49 (31) = happyGoto action_4
action_49 (35) = happyGoto action_5
action_49 (38) = happyGoto action_6
action_49 (39) = happyGoto action_7
action_49 (41) = happyGoto action_8
action_49 (45) = happyGoto action_9
action_49 (46) = happyGoto action_10
action_49 (47) = happyGoto action_11
action_49 (48) = happyGoto action_12
action_49 (51) = happyGoto action_13
action_49 (53) = happyGoto action_14
action_49 (56) = happyGoto action_15
action_49 (57) = happyGoto action_16
action_49 (58) = happyGoto action_17
action_49 (68) = happyGoto action_18
action_49 (69) = happyGoto action_19
action_49 _ = happyFail (happyExpListPerState 49)

action_50 _ = happyReduce_22

action_51 _ = happyReduce_25

action_52 _ = happyReduce_23

action_53 _ = happyReduce_59

action_54 _ = happyReduce_21

action_55 _ = happyReduce_24

action_56 (80) = happyShift action_20
action_56 (83) = happyShift action_56
action_56 (85) = happyShift action_57
action_56 (5) = happyGoto action_50
action_56 (17) = happyGoto action_51
action_56 (18) = happyGoto action_52
action_56 (19) = happyGoto action_90
action_56 (20) = happyGoto action_91
action_56 (21) = happyGoto action_92
action_56 (22) = happyGoto action_93
action_56 (23) = happyGoto action_94
action_56 (59) = happyGoto action_54
action_56 (71) = happyGoto action_55
action_56 _ = happyFail (happyExpListPerState 56)

action_57 (80) = happyShift action_20
action_57 (5) = happyGoto action_87
action_57 (15) = happyGoto action_88
action_57 (16) = happyGoto action_89
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (87) = happyShift action_85
action_58 (98) = happyShift action_86
action_58 _ = happyReduce_47

action_59 _ = happyReduce_48

action_60 _ = happyReduce_50

action_61 (86) = happyShift action_83
action_61 (88) = happyShift action_84
action_61 _ = happyFail (happyExpListPerState 61)

action_62 _ = happyReduce_116

action_63 (86) = happyShift action_82
action_63 _ = happyFail (happyExpListPerState 63)

action_64 _ = happyReduce_54

action_65 (88) = happyShift action_81
action_65 _ = happyReduce_102

action_66 _ = happyReduce_52

action_67 (87) = happyShift action_80
action_67 _ = happyReduce_57

action_68 (84) = happyShift action_79
action_68 _ = happyFail (happyExpListPerState 68)

action_69 (84) = happyShift action_78
action_69 _ = happyFail (happyExpListPerState 69)

action_70 (80) = happyShift action_77
action_70 _ = happyFail (happyExpListPerState 70)

action_71 _ = happyReduce_3

action_72 (80) = happyShift action_20
action_72 (82) = happyShift action_21
action_72 (83) = happyShift action_22
action_72 (85) = happyShift action_23
action_72 (99) = happyShift action_24
action_72 (5) = happyGoto action_2
action_72 (30) = happyGoto action_3
action_72 (31) = happyGoto action_4
action_72 (35) = happyGoto action_5
action_72 (38) = happyGoto action_6
action_72 (39) = happyGoto action_7
action_72 (41) = happyGoto action_8
action_72 (45) = happyGoto action_9
action_72 (46) = happyGoto action_76
action_72 (57) = happyGoto action_16
action_72 (58) = happyGoto action_17
action_72 (68) = happyGoto action_18
action_72 (69) = happyGoto action_19
action_72 _ = happyFail (happyExpListPerState 72)

action_73 _ = happyReduce_71

action_74 (80) = happyShift action_20
action_74 (82) = happyShift action_21
action_74 (83) = happyShift action_22
action_74 (85) = happyShift action_23
action_74 (99) = happyShift action_24
action_74 (5) = happyGoto action_2
action_74 (30) = happyGoto action_3
action_74 (31) = happyGoto action_4
action_74 (35) = happyGoto action_5
action_74 (38) = happyGoto action_6
action_74 (39) = happyGoto action_7
action_74 (41) = happyGoto action_8
action_74 (45) = happyGoto action_75
action_74 (57) = happyGoto action_16
action_74 (58) = happyGoto action_17
action_74 (68) = happyGoto action_18
action_74 (69) = happyGoto action_19
action_74 _ = happyReduce_96

action_75 _ = happyReduce_121

action_76 _ = happyReduce_73

action_77 (89) = happyShift action_142
action_77 _ = happyFail (happyExpListPerState 77)

action_78 _ = happyReduce_104

action_79 _ = happyReduce_105

action_80 (80) = happyShift action_20
action_80 (83) = happyShift action_56
action_80 (85) = happyShift action_57
action_80 (95) = happyShift action_141
action_80 (5) = happyGoto action_50
action_80 (17) = happyGoto action_51
action_80 (18) = happyGoto action_52
action_80 (19) = happyGoto action_90
action_80 (20) = happyGoto action_91
action_80 (21) = happyGoto action_92
action_80 (22) = happyGoto action_93
action_80 (23) = happyGoto action_139
action_80 (24) = happyGoto action_140
action_80 (59) = happyGoto action_54
action_80 (71) = happyGoto action_55
action_80 _ = happyFail (happyExpListPerState 80)

action_81 (80) = happyShift action_20
action_81 (5) = happyGoto action_137
action_81 (36) = happyGoto action_138
action_81 _ = happyFail (happyExpListPerState 81)

action_82 _ = happyReduce_94

action_83 _ = happyReduce_93

action_84 (80) = happyShift action_20
action_84 (5) = happyGoto action_135
action_84 (32) = happyGoto action_136
action_84 _ = happyFail (happyExpListPerState 84)

action_85 (80) = happyShift action_20
action_85 (82) = happyShift action_21
action_85 (83) = happyShift action_22
action_85 (85) = happyShift action_23
action_85 (99) = happyShift action_24
action_85 (100) = happyShift action_25
action_85 (102) = happyShift action_26
action_85 (103) = happyShift action_27
action_85 (4) = happyGoto action_134
action_85 (5) = happyGoto action_2
action_85 (30) = happyGoto action_3
action_85 (31) = happyGoto action_4
action_85 (35) = happyGoto action_5
action_85 (38) = happyGoto action_6
action_85 (39) = happyGoto action_7
action_85 (41) = happyGoto action_8
action_85 (45) = happyGoto action_9
action_85 (46) = happyGoto action_10
action_85 (47) = happyGoto action_11
action_85 (48) = happyGoto action_12
action_85 (51) = happyGoto action_13
action_85 (53) = happyGoto action_14
action_85 (56) = happyGoto action_15
action_85 (57) = happyGoto action_16
action_85 (58) = happyGoto action_17
action_85 (68) = happyGoto action_18
action_85 (69) = happyGoto action_19
action_85 _ = happyFail (happyExpListPerState 85)

action_86 (80) = happyShift action_20
action_86 (82) = happyShift action_21
action_86 (83) = happyShift action_22
action_86 (85) = happyShift action_23
action_86 (99) = happyShift action_24
action_86 (100) = happyShift action_25
action_86 (102) = happyShift action_26
action_86 (103) = happyShift action_27
action_86 (4) = happyGoto action_133
action_86 (5) = happyGoto action_2
action_86 (30) = happyGoto action_3
action_86 (31) = happyGoto action_4
action_86 (35) = happyGoto action_5
action_86 (38) = happyGoto action_6
action_86 (39) = happyGoto action_7
action_86 (41) = happyGoto action_8
action_86 (45) = happyGoto action_9
action_86 (46) = happyGoto action_10
action_86 (47) = happyGoto action_11
action_86 (48) = happyGoto action_12
action_86 (51) = happyGoto action_13
action_86 (53) = happyGoto action_14
action_86 (56) = happyGoto action_15
action_86 (57) = happyGoto action_16
action_86 (58) = happyGoto action_17
action_86 (68) = happyGoto action_18
action_86 (69) = happyGoto action_19
action_86 _ = happyFail (happyExpListPerState 86)

action_87 (87) = happyShift action_132
action_87 _ = happyFail (happyExpListPerState 87)

action_88 _ = happyReduce_19

action_89 (86) = happyShift action_130
action_89 (88) = happyShift action_131
action_89 _ = happyFail (happyExpListPerState 89)

action_90 _ = happyReduce_26

action_91 (80) = happyShift action_20
action_91 (83) = happyShift action_56
action_91 (85) = happyShift action_57
action_91 (5) = happyGoto action_50
action_91 (17) = happyGoto action_51
action_91 (18) = happyGoto action_52
action_91 (19) = happyGoto action_129
action_91 (59) = happyGoto action_54
action_91 (71) = happyGoto action_55
action_91 _ = happyReduce_28

action_92 (89) = happyShift action_70
action_92 (94) = happyShift action_71
action_92 (6) = happyGoto action_128
action_92 _ = happyReduce_30

action_93 (93) = happyShift action_127
action_93 _ = happyReduce_31

action_94 (84) = happyShift action_126
action_94 _ = happyFail (happyExpListPerState 94)

action_95 (92) = happyShift action_125
action_95 _ = happyFail (happyExpListPerState 95)

action_96 (80) = happyShift action_41
action_96 (81) = happyShift action_42
action_96 (82) = happyShift action_43
action_96 (83) = happyShift action_44
action_96 (90) = happyShift action_124
action_96 (5) = happyGoto action_29
action_96 (7) = happyGoto action_30
action_96 (8) = happyGoto action_31
action_96 (9) = happyGoto action_32
action_96 (10) = happyGoto action_33
action_96 (11) = happyGoto action_34
action_96 (12) = happyGoto action_35
action_96 (13) = happyGoto action_119
action_96 (49) = happyGoto action_120
action_96 (50) = happyGoto action_121
action_96 (64) = happyGoto action_122
action_96 (70) = happyGoto action_39
action_96 (74) = happyGoto action_123
action_96 _ = happyFail (happyExpListPerState 96)

action_97 (80) = happyShift action_20
action_97 (82) = happyShift action_21
action_97 (83) = happyShift action_22
action_97 (85) = happyShift action_23
action_97 (99) = happyShift action_24
action_97 (100) = happyShift action_25
action_97 (102) = happyShift action_26
action_97 (103) = happyShift action_27
action_97 (4) = happyGoto action_118
action_97 (5) = happyGoto action_2
action_97 (30) = happyGoto action_3
action_97 (31) = happyGoto action_4
action_97 (35) = happyGoto action_5
action_97 (38) = happyGoto action_6
action_97 (39) = happyGoto action_7
action_97 (41) = happyGoto action_8
action_97 (45) = happyGoto action_9
action_97 (46) = happyGoto action_10
action_97 (47) = happyGoto action_11
action_97 (48) = happyGoto action_12
action_97 (51) = happyGoto action_13
action_97 (53) = happyGoto action_14
action_97 (56) = happyGoto action_15
action_97 (57) = happyGoto action_16
action_97 (58) = happyGoto action_17
action_97 (68) = happyGoto action_18
action_97 (69) = happyGoto action_19
action_97 _ = happyFail (happyExpListPerState 97)

action_98 _ = happyReduce_114

action_99 (92) = happyShift action_117
action_99 _ = happyFail (happyExpListPerState 99)

action_100 _ = happyReduce_87

action_101 (91) = happyShift action_116
action_101 _ = happyReduce_101

action_102 (84) = happyShift action_114
action_102 (87) = happyShift action_115
action_102 _ = happyFail (happyExpListPerState 102)

action_103 _ = happyReduce_110

action_104 _ = happyReduce_14

action_105 (80) = happyShift action_20
action_105 (81) = happyShift action_42
action_105 (82) = happyShift action_43
action_105 (83) = happyShift action_44
action_105 (5) = happyGoto action_29
action_105 (7) = happyGoto action_30
action_105 (8) = happyGoto action_31
action_105 (9) = happyGoto action_32
action_105 (10) = happyGoto action_33
action_105 (11) = happyGoto action_113
action_105 (70) = happyGoto action_39
action_105 _ = happyReduce_99

action_106 (80) = happyShift action_41
action_106 (81) = happyShift action_42
action_106 (82) = happyShift action_43
action_106 (83) = happyShift action_44
action_106 (5) = happyGoto action_29
action_106 (7) = happyGoto action_30
action_106 (8) = happyGoto action_31
action_106 (9) = happyGoto action_32
action_106 (10) = happyGoto action_33
action_106 (11) = happyGoto action_34
action_106 (12) = happyGoto action_35
action_106 (13) = happyGoto action_112
action_106 (70) = happyGoto action_39
action_106 _ = happyFail (happyExpListPerState 106)

action_107 (80) = happyShift action_20
action_107 (82) = happyShift action_21
action_107 (83) = happyShift action_22
action_107 (85) = happyShift action_23
action_107 (99) = happyShift action_24
action_107 (100) = happyShift action_25
action_107 (102) = happyShift action_26
action_107 (103) = happyShift action_27
action_107 (4) = happyGoto action_111
action_107 (5) = happyGoto action_2
action_107 (30) = happyGoto action_3
action_107 (31) = happyGoto action_4
action_107 (35) = happyGoto action_5
action_107 (38) = happyGoto action_6
action_107 (39) = happyGoto action_7
action_107 (41) = happyGoto action_8
action_107 (45) = happyGoto action_9
action_107 (46) = happyGoto action_10
action_107 (47) = happyGoto action_11
action_107 (48) = happyGoto action_12
action_107 (51) = happyGoto action_13
action_107 (53) = happyGoto action_14
action_107 (56) = happyGoto action_15
action_107 (57) = happyGoto action_16
action_107 (58) = happyGoto action_17
action_107 (68) = happyGoto action_18
action_107 (69) = happyGoto action_19
action_107 _ = happyFail (happyExpListPerState 107)

action_108 (80) = happyShift action_20
action_108 (82) = happyShift action_21
action_108 (83) = happyShift action_22
action_108 (85) = happyShift action_23
action_108 (90) = happyShift action_110
action_108 (99) = happyShift action_24
action_108 (100) = happyShift action_25
action_108 (102) = happyShift action_26
action_108 (103) = happyShift action_27
action_108 (4) = happyGoto action_109
action_108 (5) = happyGoto action_2
action_108 (30) = happyGoto action_3
action_108 (31) = happyGoto action_4
action_108 (35) = happyGoto action_5
action_108 (38) = happyGoto action_6
action_108 (39) = happyGoto action_7
action_108 (41) = happyGoto action_8
action_108 (45) = happyGoto action_9
action_108 (46) = happyGoto action_10
action_108 (47) = happyGoto action_11
action_108 (48) = happyGoto action_12
action_108 (51) = happyGoto action_13
action_108 (53) = happyGoto action_14
action_108 (56) = happyGoto action_15
action_108 (57) = happyGoto action_16
action_108 (58) = happyGoto action_17
action_108 (68) = happyGoto action_18
action_108 (69) = happyGoto action_19
action_108 _ = happyFail (happyExpListPerState 108)

action_109 _ = happyReduce_91

action_110 (80) = happyShift action_20
action_110 (82) = happyShift action_21
action_110 (83) = happyShift action_22
action_110 (85) = happyShift action_23
action_110 (99) = happyShift action_24
action_110 (100) = happyShift action_25
action_110 (102) = happyShift action_26
action_110 (103) = happyShift action_27
action_110 (4) = happyGoto action_156
action_110 (5) = happyGoto action_2
action_110 (30) = happyGoto action_3
action_110 (31) = happyGoto action_4
action_110 (35) = happyGoto action_5
action_110 (38) = happyGoto action_6
action_110 (39) = happyGoto action_7
action_110 (41) = happyGoto action_8
action_110 (45) = happyGoto action_9
action_110 (46) = happyGoto action_10
action_110 (47) = happyGoto action_11
action_110 (48) = happyGoto action_12
action_110 (51) = happyGoto action_13
action_110 (53) = happyGoto action_14
action_110 (56) = happyGoto action_15
action_110 (57) = happyGoto action_16
action_110 (58) = happyGoto action_17
action_110 (68) = happyGoto action_18
action_110 (69) = happyGoto action_19
action_110 _ = happyFail (happyExpListPerState 110)

action_111 _ = happyReduce_86

action_112 _ = happyReduce_119

action_113 _ = happyReduce_111

action_114 _ = happyReduce_106

action_115 (80) = happyShift action_20
action_115 (83) = happyShift action_56
action_115 (85) = happyShift action_57
action_115 (95) = happyShift action_141
action_115 (5) = happyGoto action_50
action_115 (17) = happyGoto action_51
action_115 (18) = happyGoto action_52
action_115 (19) = happyGoto action_90
action_115 (20) = happyGoto action_91
action_115 (21) = happyGoto action_92
action_115 (22) = happyGoto action_93
action_115 (23) = happyGoto action_139
action_115 (24) = happyGoto action_155
action_115 (59) = happyGoto action_54
action_115 (71) = happyGoto action_55
action_115 _ = happyFail (happyExpListPerState 115)

action_116 (80) = happyShift action_41
action_116 (81) = happyShift action_42
action_116 (82) = happyShift action_43
action_116 (83) = happyShift action_44
action_116 (5) = happyGoto action_29
action_116 (7) = happyGoto action_30
action_116 (8) = happyGoto action_31
action_116 (9) = happyGoto action_32
action_116 (10) = happyGoto action_33
action_116 (11) = happyGoto action_34
action_116 (12) = happyGoto action_35
action_116 (13) = happyGoto action_36
action_116 (54) = happyGoto action_154
action_116 (67) = happyGoto action_38
action_116 (70) = happyGoto action_39
action_116 (77) = happyGoto action_40
action_116 _ = happyFail (happyExpListPerState 116)

action_117 (104) = happyShift action_153
action_117 _ = happyFail (happyExpListPerState 117)

action_118 _ = happyReduce_84

action_119 (93) = happyShift action_152
action_119 _ = happyFail (happyExpListPerState 119)

action_120 _ = happyReduce_112

action_121 _ = happyReduce_78

action_122 _ = happyReduce_77

action_123 (91) = happyShift action_151
action_123 _ = happyReduce_100

action_124 (80) = happyShift action_41
action_124 (81) = happyShift action_42
action_124 (82) = happyShift action_43
action_124 (83) = happyShift action_44
action_124 (5) = happyGoto action_29
action_124 (7) = happyGoto action_30
action_124 (8) = happyGoto action_31
action_124 (9) = happyGoto action_32
action_124 (10) = happyGoto action_33
action_124 (11) = happyGoto action_34
action_124 (12) = happyGoto action_35
action_124 (13) = happyGoto action_119
action_124 (49) = happyGoto action_120
action_124 (50) = happyGoto action_150
action_124 (64) = happyGoto action_122
action_124 (70) = happyGoto action_39
action_124 (74) = happyGoto action_123
action_124 _ = happyFail (happyExpListPerState 124)

action_125 (101) = happyShift action_149
action_125 _ = happyFail (happyExpListPerState 125)

action_126 _ = happyReduce_107

action_127 (80) = happyShift action_20
action_127 (83) = happyShift action_56
action_127 (85) = happyShift action_57
action_127 (5) = happyGoto action_50
action_127 (17) = happyGoto action_51
action_127 (18) = happyGoto action_52
action_127 (19) = happyGoto action_90
action_127 (20) = happyGoto action_91
action_127 (21) = happyGoto action_92
action_127 (22) = happyGoto action_93
action_127 (23) = happyGoto action_148
action_127 (59) = happyGoto action_54
action_127 (71) = happyGoto action_55
action_127 _ = happyFail (happyExpListPerState 127)

action_128 (80) = happyShift action_20
action_128 (83) = happyShift action_56
action_128 (85) = happyShift action_57
action_128 (5) = happyGoto action_50
action_128 (17) = happyGoto action_51
action_128 (18) = happyGoto action_52
action_128 (19) = happyGoto action_90
action_128 (20) = happyGoto action_147
action_128 (59) = happyGoto action_54
action_128 (71) = happyGoto action_55
action_128 _ = happyFail (happyExpListPerState 128)

action_129 _ = happyReduce_27

action_130 _ = happyReduce_95

action_131 (80) = happyShift action_20
action_131 (5) = happyGoto action_87
action_131 (15) = happyGoto action_146
action_131 _ = happyFail (happyExpListPerState 131)

action_132 (80) = happyShift action_20
action_132 (83) = happyShift action_56
action_132 (85) = happyShift action_57
action_132 (5) = happyGoto action_50
action_132 (17) = happyGoto action_51
action_132 (18) = happyGoto action_52
action_132 (19) = happyGoto action_90
action_132 (20) = happyGoto action_91
action_132 (21) = happyGoto action_92
action_132 (22) = happyGoto action_93
action_132 (23) = happyGoto action_145
action_132 (59) = happyGoto action_54
action_132 (71) = happyGoto action_55
action_132 _ = happyFail (happyExpListPerState 132)

action_133 _ = happyReduce_53

action_134 _ = happyReduce_46

action_135 (87) = happyShift action_85
action_135 _ = happyReduce_47

action_136 _ = happyReduce_49

action_137 (98) = happyShift action_86
action_137 _ = happyFail (happyExpListPerState 137)

action_138 _ = happyReduce_117

action_139 _ = happyReduce_33

action_140 _ = happyReduce_58

action_141 (80) = happyShift action_20
action_141 (5) = happyGoto action_143
action_141 (25) = happyGoto action_144
action_141 _ = happyFail (happyExpListPerState 141)

action_142 _ = happyReduce_4

action_143 _ = happyReduce_35

action_144 (80) = happyShift action_20
action_144 (96) = happyShift action_168
action_144 (5) = happyGoto action_167
action_144 _ = happyFail (happyExpListPerState 144)

action_145 _ = happyReduce_18

action_146 _ = happyReduce_20

action_147 (80) = happyShift action_20
action_147 (83) = happyShift action_56
action_147 (85) = happyShift action_57
action_147 (5) = happyGoto action_50
action_147 (17) = happyGoto action_51
action_147 (18) = happyGoto action_52
action_147 (19) = happyGoto action_129
action_147 (59) = happyGoto action_54
action_147 (71) = happyGoto action_55
action_147 _ = happyReduce_29

action_148 _ = happyReduce_32

action_149 (80) = happyShift action_41
action_149 (81) = happyShift action_42
action_149 (82) = happyShift action_43
action_149 (83) = happyShift action_44
action_149 (90) = happyShift action_166
action_149 (5) = happyGoto action_29
action_149 (7) = happyGoto action_30
action_149 (8) = happyGoto action_31
action_149 (9) = happyGoto action_32
action_149 (10) = happyGoto action_33
action_149 (11) = happyGoto action_34
action_149 (12) = happyGoto action_35
action_149 (13) = happyGoto action_119
action_149 (49) = happyGoto action_120
action_149 (50) = happyGoto action_165
action_149 (64) = happyGoto action_122
action_149 (70) = happyGoto action_39
action_149 (74) = happyGoto action_123
action_149 _ = happyFail (happyExpListPerState 149)

action_150 (92) = happyShift action_164
action_150 _ = happyFail (happyExpListPerState 150)

action_151 (80) = happyShift action_41
action_151 (81) = happyShift action_42
action_151 (82) = happyShift action_43
action_151 (83) = happyShift action_44
action_151 (5) = happyGoto action_29
action_151 (7) = happyGoto action_30
action_151 (8) = happyGoto action_31
action_151 (9) = happyGoto action_32
action_151 (10) = happyGoto action_33
action_151 (11) = happyGoto action_34
action_151 (12) = happyGoto action_35
action_151 (13) = happyGoto action_119
action_151 (49) = happyGoto action_163
action_151 (70) = happyGoto action_39
action_151 _ = happyFail (happyExpListPerState 151)

action_152 (80) = happyShift action_20
action_152 (82) = happyShift action_21
action_152 (83) = happyShift action_22
action_152 (85) = happyShift action_23
action_152 (90) = happyShift action_162
action_152 (99) = happyShift action_24
action_152 (100) = happyShift action_25
action_152 (102) = happyShift action_26
action_152 (103) = happyShift action_27
action_152 (4) = happyGoto action_161
action_152 (5) = happyGoto action_2
action_152 (30) = happyGoto action_3
action_152 (31) = happyGoto action_4
action_152 (35) = happyGoto action_5
action_152 (38) = happyGoto action_6
action_152 (39) = happyGoto action_7
action_152 (41) = happyGoto action_8
action_152 (45) = happyGoto action_9
action_152 (46) = happyGoto action_10
action_152 (47) = happyGoto action_11
action_152 (48) = happyGoto action_12
action_152 (51) = happyGoto action_13
action_152 (53) = happyGoto action_14
action_152 (56) = happyGoto action_15
action_152 (57) = happyGoto action_16
action_152 (58) = happyGoto action_17
action_152 (68) = happyGoto action_18
action_152 (69) = happyGoto action_19
action_152 _ = happyFail (happyExpListPerState 152)

action_153 (80) = happyShift action_20
action_153 (82) = happyShift action_21
action_153 (83) = happyShift action_22
action_153 (85) = happyShift action_23
action_153 (90) = happyShift action_160
action_153 (99) = happyShift action_24
action_153 (100) = happyShift action_25
action_153 (102) = happyShift action_26
action_153 (103) = happyShift action_27
action_153 (4) = happyGoto action_159
action_153 (5) = happyGoto action_2
action_153 (30) = happyGoto action_3
action_153 (31) = happyGoto action_4
action_153 (35) = happyGoto action_5
action_153 (38) = happyGoto action_6
action_153 (39) = happyGoto action_7
action_153 (41) = happyGoto action_8
action_153 (45) = happyGoto action_9
action_153 (46) = happyGoto action_10
action_153 (47) = happyGoto action_11
action_153 (48) = happyGoto action_12
action_153 (51) = happyGoto action_13
action_153 (53) = happyGoto action_14
action_153 (56) = happyGoto action_15
action_153 (57) = happyGoto action_16
action_153 (58) = happyGoto action_17
action_153 (68) = happyGoto action_18
action_153 (69) = happyGoto action_19
action_153 _ = happyFail (happyExpListPerState 153)

action_154 _ = happyReduce_115

action_155 (84) = happyShift action_158
action_155 _ = happyFail (happyExpListPerState 155)

action_156 (92) = happyShift action_157
action_156 _ = happyFail (happyExpListPerState 156)

action_157 _ = happyReduce_90

action_158 _ = happyReduce_8

action_159 _ = happyReduce_89

action_160 (80) = happyShift action_20
action_160 (82) = happyShift action_21
action_160 (83) = happyShift action_22
action_160 (85) = happyShift action_23
action_160 (99) = happyShift action_24
action_160 (100) = happyShift action_25
action_160 (102) = happyShift action_26
action_160 (103) = happyShift action_27
action_160 (4) = happyGoto action_172
action_160 (5) = happyGoto action_2
action_160 (30) = happyGoto action_3
action_160 (31) = happyGoto action_4
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
action_160 (68) = happyGoto action_18
action_160 (69) = happyGoto action_19
action_160 _ = happyFail (happyExpListPerState 160)

action_161 _ = happyReduce_75

action_162 (80) = happyShift action_20
action_162 (82) = happyShift action_21
action_162 (83) = happyShift action_22
action_162 (85) = happyShift action_23
action_162 (99) = happyShift action_24
action_162 (100) = happyShift action_25
action_162 (102) = happyShift action_26
action_162 (103) = happyShift action_27
action_162 (4) = happyGoto action_171
action_162 (5) = happyGoto action_2
action_162 (30) = happyGoto action_3
action_162 (31) = happyGoto action_4
action_162 (35) = happyGoto action_5
action_162 (38) = happyGoto action_6
action_162 (39) = happyGoto action_7
action_162 (41) = happyGoto action_8
action_162 (45) = happyGoto action_9
action_162 (46) = happyGoto action_10
action_162 (47) = happyGoto action_11
action_162 (48) = happyGoto action_12
action_162 (51) = happyGoto action_13
action_162 (53) = happyGoto action_14
action_162 (56) = happyGoto action_15
action_162 (57) = happyGoto action_16
action_162 (58) = happyGoto action_17
action_162 (68) = happyGoto action_18
action_162 (69) = happyGoto action_19
action_162 _ = happyFail (happyExpListPerState 162)

action_163 _ = happyReduce_113

action_164 _ = happyReduce_80

action_165 _ = happyReduce_79

action_166 (80) = happyShift action_41
action_166 (81) = happyShift action_42
action_166 (82) = happyShift action_43
action_166 (83) = happyShift action_44
action_166 (5) = happyGoto action_29
action_166 (7) = happyGoto action_30
action_166 (8) = happyGoto action_31
action_166 (9) = happyGoto action_32
action_166 (10) = happyGoto action_33
action_166 (11) = happyGoto action_34
action_166 (12) = happyGoto action_35
action_166 (13) = happyGoto action_119
action_166 (49) = happyGoto action_120
action_166 (50) = happyGoto action_170
action_166 (64) = happyGoto action_122
action_166 (70) = happyGoto action_39
action_166 (74) = happyGoto action_123
action_166 _ = happyFail (happyExpListPerState 166)

action_167 _ = happyReduce_36

action_168 (80) = happyShift action_20
action_168 (83) = happyShift action_56
action_168 (85) = happyShift action_57
action_168 (5) = happyGoto action_50
action_168 (17) = happyGoto action_51
action_168 (18) = happyGoto action_52
action_168 (19) = happyGoto action_90
action_168 (20) = happyGoto action_91
action_168 (21) = happyGoto action_92
action_168 (22) = happyGoto action_93
action_168 (23) = happyGoto action_169
action_168 (59) = happyGoto action_54
action_168 (71) = happyGoto action_55
action_168 _ = happyFail (happyExpListPerState 168)

action_169 _ = happyReduce_34

action_170 (92) = happyShift action_175
action_170 _ = happyFail (happyExpListPerState 170)

action_171 (92) = happyShift action_174
action_171 _ = happyFail (happyExpListPerState 171)

action_172 (92) = happyShift action_173
action_172 _ = happyFail (happyExpListPerState 172)

action_173 _ = happyReduce_88

action_174 _ = happyReduce_76

action_175 _ = happyReduce_81

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
	(HappyAbsSyn17  happy_var_4) `HappyStk`
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
happyReduction_12 (HappyAbsSyn70  happy_var_1)
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

happyReduce_14 = happySpecReduce_2  12 happyReduction_14
happyReduction_14 (HappyAbsSyn63  happy_var_2)
	(HappyTerminal (TokenVariable _ happy_var_1))
	 =  HappyAbsSyn7
		 (let variable=(tokenVariable2Variable happy_var_1) 
  in
    ApplicationPattern (getRange(variable,happy_var_2)) variable happy_var_2
	)
happyReduction_14 _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_1  12 happyReduction_15
happyReduction_15 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_15 _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_1  13 happyReduction_16
happyReduction_16 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_16 _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_1  14 happyReduction_17
happyReduction_17 (HappyAbsSyn62  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_1
	)
happyReduction_17 _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_3  15 happyReduction_18
happyReduction_18 (HappyAbsSyn17  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn15
		 ((getRange (happy_var_1,happy_var_3),happy_var_1,happy_var_3)
	)
happyReduction_18 _ _ _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_1  16 happyReduction_19
happyReduction_19 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn16
		 ([happy_var_1]
	)
happyReduction_19 _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_3  16 happyReduction_20
happyReduction_20 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 (happy_var_3:happy_var_1
	)
happyReduction_20 _ _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_1  17 happyReduction_21
happyReduction_21 (HappyAbsSyn59  happy_var_1)
	 =  HappyAbsSyn17
		 (RecordType (getRange happy_var_1) (List.reverse happy_var_1)
	)
happyReduction_21 _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_1  18 happyReduction_22
happyReduction_22 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn17
		 (VariableType (getRange happy_var_1) happy_var_1
	)
happyReduction_22 _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_1  19 happyReduction_23
happyReduction_23 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_23 _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_1  19 happyReduction_24
happyReduction_24 (HappyAbsSyn71  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_24 _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_1  19 happyReduction_25
happyReduction_25 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_1  20 happyReduction_26
happyReduction_26 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_26 _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_2  20 happyReduction_27
happyReduction_27 (HappyAbsSyn17  happy_var_2)
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (ApplicationType (getRange (happy_var_2,happy_var_1)) happy_var_2 happy_var_1
	)
happyReduction_27 _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_1  21 happyReduction_28
happyReduction_28 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn21
		 (FirstItem happy_var_1
	)
happyReduction_28 _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_3  21 happyReduction_29
happyReduction_29 (HappyAbsSyn17  happy_var_3)
	(HappyAbsSyn6  happy_var_2)
	(HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn21
		 (IntercalatedCons happy_var_3 (IntercalatedCons happy_var_2 happy_var_1)
	)
happyReduction_29 _ _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_1  22 happyReduction_30
happyReduction_30 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn17
		 (MeaninglessOperatorsType (getRange happy_var_1) happy_var_1
	)
happyReduction_30 _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_1  23 happyReduction_31
happyReduction_31 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_3  23 happyReduction_32
happyReduction_32 (HappyAbsSyn17  happy_var_3)
	_
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (TypeArrow (getRange (happy_var_1,happy_var_3)) happy_var_1 happy_var_3
	)
happyReduction_32 _ _ _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_1  24 happyReduction_33
happyReduction_33 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_33 _  = notHappyAtAll 

happyReduce_34 = happyReduce 4 24 happyReduction_34
happyReduction_34 ((HappyAbsSyn17  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn25  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn17
		 (TypeForall (getRange (happy_var_2,happy_var_4)) happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_35 = happySpecReduce_1  25 happyReduction_35
happyReduction_35 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn25
		 (happy_var_1 :| []
	)
happyReduction_35 _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_2  25 happyReduction_36
happyReduction_36 (HappyAbsSyn5  happy_var_2)
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (cons happy_var_2 happy_var_1
	)
happyReduction_36 _ _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_1  26 happyReduction_37
happyReduction_37 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn26
		 ([happy_var_1]
	)
happyReduction_37 _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_3  26 happyReduction_38
happyReduction_38 (HappyAbsSyn17  happy_var_3)
	_
	(HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn26
		 (happy_var_3:happy_var_1
	)
happyReduction_38 _ _ _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_1  27 happyReduction_39
happyReduction_39 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn27
		 (Constructor (getRange happy_var_1) happy_var_1 []
	)
happyReduction_39 _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_2  27 happyReduction_40
happyReduction_40 (HappyAbsSyn26  happy_var_2)
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn27
		 (Constructor (getRange happy_var_1) happy_var_1 happy_var_2
	)
happyReduction_40 _ _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_1  28 happyReduction_41
happyReduction_41 (HappyAbsSyn27  happy_var_1)
	 =  HappyAbsSyn28
		 (happy_var_1:|[]
	)
happyReduction_41 _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_3  28 happyReduction_42
happyReduction_42 (HappyAbsSyn27  happy_var_3)
	_
	(HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (cons happy_var_3 happy_var_1
	)
happyReduction_42 _ _ _  = notHappyAtAll 

happyReduce_43 = happyReduce 4 29 happyReduction_43
happyReduction_43 ((HappyAbsSyn28  happy_var_4) `HappyStk`
	(HappyAbsSyn61  happy_var_3) `HappyStk`
	(HappyAbsSyn5  happy_var_2) `HappyStk`
	(HappyTerminal (Data happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn29
		 (DataType (getRange (happy_var_1,happy_var_4)) happy_var_2 happy_var_3 happy_var_4
	) `HappyStk` happyRest

happyReduce_44 = happySpecReduce_1  30 happyReduction_44
happyReduction_44 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn4
		 (let literal=(tokenLiteral2Literal happy_var_1) 
  in 
    LiteralExpression (getRange literal) literal
	)
happyReduction_44 _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_1  31 happyReduction_45
happyReduction_45 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (VariableExpression (getRange happy_var_1) happy_var_1
	)
happyReduction_45 _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_3  32 happyReduction_46
happyReduction_46 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn32
		 (((getRange (happy_var_1,happy_var_3)),happy_var_1,Just happy_var_3)
	)
happyReduction_46 _ _ _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_1  32 happyReduction_47
happyReduction_47 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn32
		 (((getRange happy_var_1),happy_var_1,Nothing)
	)
happyReduction_47 _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_1  33 happyReduction_48
happyReduction_48 (HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn33
		 ([happy_var_1]
	)
happyReduction_48 _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_3  33 happyReduction_49
happyReduction_49 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn33
		 (happy_var_3:happy_var_1
	)
happyReduction_49 _ _ _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_1  34 happyReduction_50
happyReduction_50 (HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn33
		 (List.reverse happy_var_1
	)
happyReduction_50 _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_1  35 happyReduction_51
happyReduction_51 (HappyAbsSyn57  happy_var_1)
	 =  HappyAbsSyn4
		 (let (range::Range) =  getRange ((\ (r,_,_)->r) <$> happy_var_1)
  in
    RecordExpression range happy_var_1
	)
happyReduction_51 _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_2  35 happyReduction_52
happyReduction_52 (HappyTerminal (RightBrace happy_var_2))
	(HappyTerminal (LeftBrace happy_var_1))
	 =  HappyAbsSyn4
		 (RecordExpression (getRange (happy_var_1,happy_var_2)) []
	)
happyReduction_52 _ _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_3  36 happyReduction_53
happyReduction_53 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn36
		 ((getRange (happy_var_1,happy_var_3),happy_var_1,happy_var_3)
	)
happyReduction_53 _ _ _  = notHappyAtAll 

happyReduce_54 = happySpecReduce_1  37 happyReduction_54
happyReduction_54 (HappyAbsSyn66  happy_var_1)
	 =  HappyAbsSyn37
		 (happy_var_1
	)
happyReduction_54 _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_1  38 happyReduction_55
happyReduction_55 (HappyAbsSyn58  happy_var_1)
	 =  HappyAbsSyn4
		 (RecordUpdate (getRange happy_var_1) happy_var_1
	)
happyReduction_55 _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_1  39 happyReduction_56
happyReduction_56 (HappyAbsSyn69  happy_var_1)
	 =  HappyAbsSyn4
		 (OperatorInParens (getRange happy_var_1) happy_var_1
	)
happyReduction_56 _  = notHappyAtAll 

happyReduce_57 = happySpecReduce_1  40 happyReduction_57
happyReduction_57 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_57 _  = notHappyAtAll 

happyReduce_58 = happySpecReduce_3  40 happyReduction_58
happyReduction_58 (HappyAbsSyn17  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (AnnotationExpression (getRange (happy_var_1,happy_var_3)) happy_var_1 happy_var_3
	)
happyReduction_58 _ _ _  = notHappyAtAll 

happyReduce_59 = happySpecReduce_2  41 happyReduction_59
happyReduction_59 (HappyAbsSyn17  happy_var_2)
	(HappyTerminal (At happy_var_1))
	 =  HappyAbsSyn4
		 (TypeArgumentExpression (getRange (happy_var_1,happy_var_2)) happy_var_2
	)
happyReduction_59 _ _  = notHappyAtAll 

happyReduce_60 = happySpecReduce_3  42 happyReduction_60
happyReduction_60 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (Accessor (getRange (happy_var_1,happy_var_3)) happy_var_1 happy_var_3
	)
happyReduction_60 _ _ _  = notHappyAtAll 

happyReduce_61 = happySpecReduce_3  43 happyReduction_61
happyReduction_61 (HappyAbsSyn5  happy_var_3)
	_
	(HappyTerminal (Hole happy_var_1))
	 =  HappyAbsSyn4
		 (AccessorFunction (getRange (happy_var_1,happy_var_3)) happy_var_3
	)
happyReduction_61 _ _ _  = notHappyAtAll 

happyReduce_62 = happySpecReduce_1  44 happyReduction_62
happyReduction_62 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_62 _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_1  44 happyReduction_63
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
happyReduction_69 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_69 _  = notHappyAtAll 

happyReduce_70 = happySpecReduce_1  45 happyReduction_70
happyReduction_70 (HappyAbsSyn68  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_70 _  = notHappyAtAll 

happyReduce_71 = happySpecReduce_2  46 happyReduction_71
happyReduction_71 (HappyAbsSyn60  happy_var_2)
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (ApplicationExpression (getRange (happy_var_1,happy_var_2)) happy_var_1 happy_var_2
	)
happyReduction_71 _ _  = notHappyAtAll 

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
		 (MeaninglessOperatorsExpression (getRange happy_var_1) happy_var_1
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
happyReduction_83 (HappyAbsSyn67  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_1
	)
happyReduction_83 _  = notHappyAtAll 

happyReduce_84 = happyReduce 4 53 happyReduction_84
happyReduction_84 ((HappyAbsSyn4  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_2) `HappyStk`
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
	(HappyAbsSyn67  happy_var_1)
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
	(HappyAbsSyn33  happy_var_2)
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
	(HappyAbsSyn16  happy_var_2)
	_
	 =  HappyAbsSyn59
		 (happy_var_2
	)
happyReduction_95 _ _ _  = notHappyAtAll 

happyReduce_96 = happySpecReduce_1  60 happyReduction_96
happyReduction_96 (HappyAbsSyn78  happy_var_1)
	 =  HappyAbsSyn60
		 (List.reverse happy_var_1
	)
happyReduction_96 _  = notHappyAtAll 

happyReduce_97 = happySpecReduce_1  61 happyReduction_97
happyReduction_97 (HappyAbsSyn79  happy_var_1)
	 =  HappyAbsSyn61
		 (List.reverse happy_var_1
	)
happyReduction_97 _  = notHappyAtAll 

happyReduce_98 = happySpecReduce_1  62 happyReduction_98
happyReduction_98 (HappyAbsSyn72  happy_var_1)
	 =  HappyAbsSyn62
		 (reverse happy_var_1
	)
happyReduction_98 _  = notHappyAtAll 

happyReduce_99 = happySpecReduce_1  63 happyReduction_99
happyReduction_99 (HappyAbsSyn73  happy_var_1)
	 =  HappyAbsSyn63
		 (reverse happy_var_1
	)
happyReduction_99 _  = notHappyAtAll 

happyReduce_100 = happySpecReduce_1  64 happyReduction_100
happyReduction_100 (HappyAbsSyn74  happy_var_1)
	 =  HappyAbsSyn64
		 (reverse happy_var_1
	)
happyReduction_100 _  = notHappyAtAll 

happyReduce_101 = happySpecReduce_1  65 happyReduction_101
happyReduction_101 (HappyAbsSyn75  happy_var_1)
	 =  HappyAbsSyn65
		 (reverse happy_var_1
	)
happyReduction_101 _  = notHappyAtAll 

happyReduce_102 = happySpecReduce_1  66 happyReduction_102
happyReduction_102 (HappyAbsSyn76  happy_var_1)
	 =  HappyAbsSyn66
		 (reverse happy_var_1
	)
happyReduction_102 _  = notHappyAtAll 

happyReduce_103 = happySpecReduce_1  67 happyReduction_103
happyReduction_103 (HappyAbsSyn77  happy_var_1)
	 =  HappyAbsSyn67
		 (reverse happy_var_1
	)
happyReduction_103 _  = notHappyAtAll 

happyReduce_104 = happySpecReduce_3  68 happyReduction_104
happyReduction_104 _
	(HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn68
		 (happy_var_2
	)
happyReduction_104 _ _ _  = notHappyAtAll 

happyReduce_105 = happySpecReduce_3  69 happyReduction_105
happyReduction_105 _
	(HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn69
		 (happy_var_2
	)
happyReduction_105 _ _ _  = notHappyAtAll 

happyReduce_106 = happySpecReduce_3  70 happyReduction_106
happyReduction_106 _
	(HappyAbsSyn7  happy_var_2)
	_
	 =  HappyAbsSyn70
		 (happy_var_2
	)
happyReduction_106 _ _ _  = notHappyAtAll 

happyReduce_107 = happySpecReduce_3  71 happyReduction_107
happyReduction_107 _
	(HappyAbsSyn17  happy_var_2)
	_
	 =  HappyAbsSyn71
		 (happy_var_2
	)
happyReduction_107 _ _ _  = notHappyAtAll 

happyReduce_108 = happySpecReduce_1  72 happyReduction_108
happyReduction_108 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn72
		 (happy_var_1 :| []
	)
happyReduction_108 _  = notHappyAtAll 

happyReduce_109 = happySpecReduce_2  72 happyReduction_109
happyReduction_109 (HappyAbsSyn7  happy_var_2)
	(HappyAbsSyn72  happy_var_1)
	 =  HappyAbsSyn72
		 (cons happy_var_2 happy_var_1
	)
happyReduction_109 _ _  = notHappyAtAll 

happyReduce_110 = happySpecReduce_1  73 happyReduction_110
happyReduction_110 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn73
		 (happy_var_1 :| []
	)
happyReduction_110 _  = notHappyAtAll 

happyReduce_111 = happySpecReduce_2  73 happyReduction_111
happyReduction_111 (HappyAbsSyn7  happy_var_2)
	(HappyAbsSyn73  happy_var_1)
	 =  HappyAbsSyn73
		 (cons happy_var_2 happy_var_1
	)
happyReduction_111 _ _  = notHappyAtAll 

happyReduce_112 = happySpecReduce_1  74 happyReduction_112
happyReduction_112 (HappyAbsSyn49  happy_var_1)
	 =  HappyAbsSyn74
		 (happy_var_1 :| []
	)
happyReduction_112 _  = notHappyAtAll 

happyReduce_113 = happySpecReduce_3  74 happyReduction_113
happyReduction_113 (HappyAbsSyn49  happy_var_3)
	_
	(HappyAbsSyn74  happy_var_1)
	 =  HappyAbsSyn74
		 (cons happy_var_3 happy_var_1
	)
happyReduction_113 _ _ _  = notHappyAtAll 

happyReduce_114 = happySpecReduce_1  75 happyReduction_114
happyReduction_114 (HappyAbsSyn54  happy_var_1)
	 =  HappyAbsSyn75
		 (happy_var_1 :| []
	)
happyReduction_114 _  = notHappyAtAll 

happyReduce_115 = happySpecReduce_3  75 happyReduction_115
happyReduction_115 (HappyAbsSyn54  happy_var_3)
	_
	(HappyAbsSyn75  happy_var_1)
	 =  HappyAbsSyn75
		 (cons happy_var_3 happy_var_1
	)
happyReduction_115 _ _ _  = notHappyAtAll 

happyReduce_116 = happySpecReduce_1  76 happyReduction_116
happyReduction_116 (HappyAbsSyn36  happy_var_1)
	 =  HappyAbsSyn76
		 (happy_var_1 :| []
	)
happyReduction_116 _  = notHappyAtAll 

happyReduce_117 = happySpecReduce_3  76 happyReduction_117
happyReduction_117 (HappyAbsSyn36  happy_var_3)
	_
	(HappyAbsSyn76  happy_var_1)
	 =  HappyAbsSyn76
		 (cons happy_var_3 happy_var_1
	)
happyReduction_117 _ _ _  = notHappyAtAll 

happyReduce_118 = happySpecReduce_1  77 happyReduction_118
happyReduction_118 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn77
		 (happy_var_1 :| []
	)
happyReduction_118 _  = notHappyAtAll 

happyReduce_119 = happySpecReduce_3  77 happyReduction_119
happyReduction_119 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn77  happy_var_1)
	 =  HappyAbsSyn77
		 (cons happy_var_3 happy_var_1
	)
happyReduction_119 _ _ _  = notHappyAtAll 

happyReduce_120 = happySpecReduce_0  78 happyReduction_120
happyReduction_120  =  HappyAbsSyn78
		 ([]
	)

happyReduce_121 = happySpecReduce_2  78 happyReduction_121
happyReduction_121 (HappyAbsSyn4  happy_var_2)
	(HappyAbsSyn78  happy_var_1)
	 =  HappyAbsSyn78
		 (happy_var_2:happy_var_1
	)
happyReduction_121 _ _  = notHappyAtAll 

happyReduce_122 = happySpecReduce_0  79 happyReduction_122
happyReduction_122  =  HappyAbsSyn79
		 ([]
	)

happyReduce_123 = happySpecReduce_2  79 happyReduction_123
happyReduction_123 (HappyAbsSyn5  happy_var_2)
	(HappyAbsSyn79  happy_var_1)
	 =  HappyAbsSyn79
		 (happy_var_2:happy_var_1
	)
happyReduction_123 _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 105 105 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenVariable _ happy_dollar_dollar -> cont 80;
	Hole happy_dollar_dollar -> cont 81;
	LiteralUint _ _ -> cont 82;
	LeftParen happy_dollar_dollar -> cont 83;
	RightParen happy_dollar_dollar -> cont 84;
	LeftBrace happy_dollar_dollar -> cont 85;
	RightBrace happy_dollar_dollar -> cont 86;
	Colon happy_dollar_dollar -> cont 87;
	Comma happy_dollar_dollar -> cont 88;
	BackTick happy_dollar_dollar -> cont 89;
	LayoutStart happy_dollar_dollar -> cont 90;
	LayoutSeparator happy_dollar_dollar -> cont 91;
	LayoutEnd happy_dollar_dollar -> cont 92;
	RightArrow happy_dollar_dollar -> cont 93;
	TokenOperator _ _ -> cont 94;
	Forall happy_dollar_dollar -> cont 95;
	Dot happy_dollar_dollar -> cont 96;
	Data happy_dollar_dollar -> cont 97;
	Equal happy_dollar_dollar -> cont 98;
	At happy_dollar_dollar -> cont 99;
	Case happy_dollar_dollar -> cont 100;
	Of happy_dollar_dollar -> cont 101;
	LambdaStart happy_dollar_dollar -> cont 102;
	Let happy_dollar_dollar -> cont 103;
	In happy_dollar_dollar -> cont 104;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 105 tk tks = happyError' (tks, explist)
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
