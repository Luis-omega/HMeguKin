module HMeguKin.Parser.Types (
  Range (..),
  Token (..),
  Variable (..),
  Operator (..),
  IndenterError (..),
  token2Name,
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
    Let _ -> "Let"
    In _ -> "In"
    Case _ -> "Case"
    Of _ -> "Of"
    Forall _ -> "Forall"
    Data _ -> "Data"
    Type _ -> "Type"
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
