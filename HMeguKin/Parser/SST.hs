module HMeguKin.Parser.SST where

import Data.List.NonEmpty (NonEmpty ((:|)))
import Data.List.Split (splitOn)
import Data.Maybe (fromJust)
import HMeguKin.Parser.Types (Range, mergeRanges)
import HMeguKin.Parser.Types qualified as Types

class HasRange a where
  getRange :: a -> Range

instance HasRange Range where
  getRange x = x

instance (HasRange a) => HasRange (NonEmpty a) where
  getRange lst = foldr1 mergeRanges (getRange <$> lst)

instance (HasRange a) => HasRange [a] where
  getRange lst = foldr1 mergeRanges (getRange <$> lst)

instance (HasRange a, HasRange b) => HasRange (a, b) where
  getRange (x, y) = mergeRanges (getRange x) (getRange y)

instance (HasRange a, HasRange b, HasRange c) => HasRange (a, b, c) where
  getRange (x, y, c) = mergeRanges (mergeRanges (getRange x) (getRange y)) (getRange c)

data IntercalatedList a b
  = FirstItem a
  | IntercalatedCons a (IntercalatedList b a)
  deriving stock (Show)

data Variable
  = PlainLowerCase Range String
  | PrefixedLowerCase Range (NonEmpty String) String
  | PlainCapitalized Range String
  | PrefixedCapitalized Range (NonEmpty String) String
  deriving stock (Show)

instance HasRange Variable where
  getRange (PlainLowerCase range _) = range
  getRange (PrefixedLowerCase range _ _) = range
  getRange (PlainCapitalized range _) = range
  getRange (PrefixedCapitalized range _ _) = range

data Literal
  = LiteralUint Range String
  | LiteralString Range String
  deriving stock (Show)

instance HasRange Literal where
  getRange (LiteralUint range _) = range
  getRange (LiteralString range _) = range

data Operator
  = PlainOperator Range String
  | PrefixedOperator Range (NonEmpty String) String
  | VariableAsOperator Range Variable
  deriving stock (Show)

data Pattern
  = LiteralPattern Range Literal
  | HolePattern Range
  | VariablePattern Range Variable
  | ApplicationPattern Range Variable (NonEmpty Pattern)
  deriving stock (Show)

instance HasRange Pattern where
  getRange (LiteralPattern range _) = range
  getRange (HolePattern range) = range
  getRange (VariablePattern range _) = range
  getRange (ApplicationPattern range _ _) = range

data Type
  = VariableType Range Variable
  | OperatorType Range Operator
  | RecordType Range [(Range, Variable, Type)]
  | MeaninglessOperatorApplications Range (IntercalatedList Type Operator)
  | ApplicationType Range Type Type
  | TypeArrow Range Type Type
  | TypeForAll Range (NonEmpty Variable) Type
  deriving stock (Show)

instance HasRange Type where
  getRange (VariableType range _) = range
  getRange (OperatorType range _) = range
  getRange (RecordType range _) = range
  getRange (MeaninglessOperatorApplications range _) = range
  getRange (ApplicationType range _ _) = range
  getRange (TypeArrow range _ _) = range
  getRange (TypeForAll range _ _) = range

data Expression
  = LiteralExpression Range Literal
  | VariableExpression Range Variable
  deriving stock (Show)

splitStringByDot :: String -> Maybe (String, NonEmpty String)
splitStringByDot value =
  case splitOn "." value of
    [] -> Nothing
    xs ->
      let name = last xs
       in case init xs of
            [] -> Nothing
            (first : remain) -> Just (name, first :| remain)

tokenVariable2Variable :: Types.Variable -> Variable
tokenVariable2Variable (Types.NonCapitalized range value) = PlainLowerCase range value
tokenVariable2Variable (Types.NonCapitalizedPrefixed range value) =
  let (name, prefix) = fromJust $ splitStringByDot value
   in PrefixedLowerCase range prefix name
tokenVariable2Variable (Types.Capitalized range value) = PlainCapitalized range value
tokenVariable2Variable (Types.CapitalizedPrefixed range value) =
  let (name, prefix) = fromJust $ splitStringByDot value
   in PrefixedCapitalized range prefix name

tokenLiteral2Literal :: Types.Token -> Literal
tokenLiteral2Literal (Types.LiteralUint range value) = LiteralUint range value
tokenLiteral2Literal _ = error "This isn't suppose to happen"
