module HMeguKin.Parser.Types (
  Range (..),
  Token (..),
  Variable (..),
  Operator (..),
  IndenterError (..),
) where

data Range = Range
  { lineStart :: Int
  , lineEnd :: Int
  , columnStart :: Int
  , columnEnd :: Int
  , positionStart :: Int
  , positionEnd :: Int
  }
  deriving stock (Show)

data Token
  = LineBreak Range
  | Comment Range String
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
  | Let Range
  | In Range
  | Case Range
  | Of Range
  | Forall Range
  | Data Range
  | Type Range
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
  deriving stock (Show)

data Variable
  = NonCapitalized Range String
  | NonCapitalizedPrefixed Range String
  | Capitalized Range String
  | CapitalizedPrefixed Range String
  deriving stock (Show)

data Operator
  = NonPrefixedOperator Range String
  | PrefixedOperator Range String
  deriving stock (Show)

data IndenterError
  = IndenterError
  | -- Indentation introduction token name
    UnexpectedEOF String
  | -- First token requested a context, second token is missindented
    ContextFirstValueBeforeStart Token Token
  | -- if this happen inside a imports, someone tried to import (=)
    MissIndentedAfterEqual Token Token
  deriving stock (Show)
