module HMeguKin.Parser.Types
  ( Range (..),
    Token (..),
    Variable (..),
    Operator (..),
    IndenterError (..),
    HasRange (getRange),
    token2Name,
    mergeRanges,
    range2PartialTuple,
  )
where

import Data.List.NonEmpty (NonEmpty)

data Range = Range
  { lineStart :: Int,
    lineEnd :: Int,
    columnStart :: Int,
    columnEnd :: Int,
    positionStart :: Int,
    positionEnd :: Int
  }
  deriving stock (Show, Eq)

mergeRanges :: Range -> Range -> Range
mergeRanges range1 range2 =
  if lineStart range1 >= lineStart range2
    then
      Range
        { lineStart = lineStart range1,
          lineEnd = lineEnd range2,
          columnStart = columnStart range1,
          columnEnd = columnEnd range2,
          positionStart = positionStart range1,
          positionEnd = positionEnd range2
        }
    else mergeRanges range2 range1

range2PartialTuple :: Range -> (Int, Int, Int)
range2PartialTuple r = (lineStart r, columnStart r, positionStart r)

class HasRange a where
  getRange :: a -> Range

instance HasRange Range where
  getRange x = x

instance (HasRange a) => HasRange (NonEmpty a) where
  getRange lst = foldr1 mergeRanges (getRange <$> lst)

instance (HasRange a, HasRange b) => HasRange (a, b) where
  getRange (x, y) = mergeRanges (getRange x) (getRange y)

instance (HasRange a, HasRange b, HasRange c) => HasRange (a, b, c) where
  getRange (x, y, c) =
    mergeRanges (mergeRanges (getRange x) (getRange y)) (getRange c)

data Token
  = Comment Range String
  | At Range
  | Hole Range
  | Colon Range
  | Equal Range
  | LambdaStart Range
  | Pipe Range
  | Dot Range
  | Comma Range
  | RightArrow Range
  | LeftArrow Range
  | LeftBrace Range
  | RightBrace Range
  | LeftBracket Range
  | RightBracket Range
  | LeftParen Range
  | RightParen Range
  | BackTick Range
  | Let Range
  | In Range
  | Case Range
  | Of Range
  | Forall Range
  | Data Range
  | Type Range
  | Term Range
  | NewType Range
  | Module Range
  | Import Range
  | Where Range
  | As Range
  | Left_ Range
  | Right_ Range
  | None Range
  | Unqualified Range
  | OperatorKeyword Range
  | TokenOperator Range Operator
  | LiteralUint Range String
  | TokenVariable Range Variable
  | LexerError Range Char String
  | EOF
  | TokenIndenterError Range IndenterError
  | LayoutStart Range
  | LayoutEnd Range
  | LayoutSeparator Range
  deriving stock (Show, Eq)

data Variable
  = NonCapitalized Range String
  | NonCapitalizedPrefixed Range String
  | Capitalized Range String
  | CapitalizedPrefixed Range String
  deriving stock (Show, Eq)

data Operator
  = NonPrefixedOperator Range String
  | PrefixedOperator Range String
  deriving stock (Show, Eq)

data IndenterError
  = -- Indentation introduction token name
    UnexpectedEOF String
  | -- First token requested a context, second token is missindented
    ContextFirstValueBeforeStart Token Token
  | -- if this happen inside a imports, someone tried to import (=)
    MissIndentedAfterEqual Token Token
  deriving stock (Show, Eq)

instance HasRange Token where
  getRange (Comment range _) = range
  getRange (At range) = range
  getRange (Hole range) = range
  getRange (Colon range) = range
  getRange (Equal range) = range
  getRange (LambdaStart range) = range
  getRange (Pipe range) = range
  getRange (Dot range) = range
  getRange (Comma range) = range
  getRange (RightArrow range) = range
  getRange (LeftArrow range) = range
  getRange (LeftBrace range) = range
  getRange (RightBrace range) = range
  getRange (LeftBracket range) = range
  getRange (RightBracket range) = range
  getRange (LeftParen range) = range
  getRange (RightParen range) = range
  getRange (BackTick range) = range
  getRange (Let range) = range
  getRange (In range) = range
  getRange (Case range) = range
  getRange (Of range) = range
  getRange (Forall range) = range
  getRange (Data range) = range
  getRange (Type range) = range
  getRange (Term range) = range
  getRange (NewType range) = range
  getRange (Module range) = range
  getRange (Import range) = range
  getRange (Where range) = range
  getRange (As range) = range
  getRange (Left_ range) = range
  getRange (Right_ range) = range
  getRange (None range) = range
  getRange (Unqualified range) = range
  getRange (OperatorKeyword range) = range
  getRange (TokenOperator range _) = range
  getRange (LiteralUint range _) = range
  getRange (TokenVariable range _) = range
  getRange (LexerError range _ _) = range
  getRange EOF = Range 0 0 0 0 0 0
  getRange (TokenIndenterError range _) = range
  getRange (LayoutStart range) = range
  getRange (LayoutEnd range) = range
  getRange (LayoutSeparator range) = range

token2Name :: Token -> String
token2Name token =
  case token of
    Comment _ _ -> "Comment"
    At _ -> "@"
    Hole _ -> "_"
    Colon _ -> ":"
    Equal _ -> "Equal"
    LambdaStart _ -> "LambdaStart"
    Pipe _ -> "Pipe"
    Dot _ -> "Dot"
    Comma _ -> "Comma"
    RightArrow _ -> "RightArrow"
    LeftArrow _ -> "LeftArrow"
    LeftBrace _ -> "LeftBrace"
    RightBrace _ -> "RightBrace"
    LeftBracket _ -> "LeftBracket"
    RightBracket _ -> "RightBracket"
    LeftParen _ -> "LeftParen"
    RightParen _ -> "RightParen"
    BackTick _ -> "BackTick"
    Let _ -> "Let"
    In _ -> "In"
    Case _ -> "Case"
    Of _ -> "Of"
    Forall _ -> "Forall"
    Data _ -> "Data"
    Type _ -> "Type"
    Term _ -> "Term"
    NewType _ -> "NewType"
    Module _ -> "Module"
    Import _ -> "Import"
    Where _ -> "Where"
    As _ -> "As"
    Left_ _ -> "Left_"
    Right_ _ -> "Right_"
    None _ -> "None"
    Unqualified _ -> "Unqualified"
    OperatorKeyword _ -> "OperatorKeyword"
    TokenOperator _ _ -> "TokenOperator"
    LiteralUint _ _ -> "LiteralUint"
    TokenVariable _ _ -> "TokenVariable"
    EOF -> "EOF"
    LexerError _ _ _ -> "LexerError"
    TokenIndenterError _ _ -> "TokenIndenterError"
    LayoutStart _ -> "LayoutStart"
    LayoutEnd _ -> "LayoutEnd"
    LayoutSeparator _ -> "LayoutSeparator"
