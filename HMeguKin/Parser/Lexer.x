{
module HMeguKin.Parser.Lexer (lexer,alexScanTokens,Token(..)) where

import HMeguKin.Parser.Types (
  Operator (
    NonPrefixedOperator,
    PrefixedOperator
  ),
  Range (Range,
    columnEnd,
    columnStart,
    lineEnd,
    lineStart,
    positionEnd,
    positionStart
  ),
  Variable (
    Capitalized,
    CapitalizedPrefixed,
    NonCapitalized,
    NonCapitalizedPrefixed
  ),
 )

}

%wrapper "posn"

@spaces = \ +
$lineBreak = \n
@comment = "#"[^\n]*
@digit = 0-9
@nonZeroDigit = 1-9
@nonZeroUInt = @nonZeroDigit (digit|_)*
@zeroInt = 0+ (0|_)*
@uint = @nonZeroUInt | @zeroInt
@uppercase = A-Z
@identifierInnerCharacter = (a-z|A-Z|_|0-9)
@capitalizedIdentifier = @uppercase @identifierInnerCharacter*
@lowercasse = a-z
@nonCapitalizedIdentifier = @lowercasse @identifierInnerCharacter*
$at = @
$hole = _
$colon = :
$equal = =
$lambdaStart = \
@pipe = "|"
@dot = "."
@comma = ","
@rightArrow = "->"
@leftArrow = "<-"
@leftBrace = "{"
@rightBrace = "}"
@leftBracket = "["
@rightBracket = "]"
@leftParen = "("
@rightParen = ")"
@backTick = "`"

@operatorAloneChar = ("+" | "-" | "~" | "/" | "!" | "?" | "¡" | "¿" | "$" | "¬" | ">" | "<" | "%" | "&" | "*")
@operatorNotAloneCharacter = ("="|"\"|"|")
@operator = (@operatorAloneChar (@operatorAloneChar | @operatorNotAloneCharacter)*) | (@operatorNotAloneCharacter (@operatorAloneChar | @operatorNotAloneCharacter)+)

@modulePrefix = (@capitalizedIdentifier @dot)+
@prefixedOperator = @modulePrefix @operator
@prefixedVariable = @modulePrefix @nonCapitalizedIdentifier
@prefixedCapitalized = @modulePrefix @capitalizedIdentifier

tokens :-

  @spaces                         ;
  $lineBreak                      ;
  @comment                        {makeToken Comment}
  $at                             {fromPosition At}
  $hole                             {fromPosition Hole}
  $colon                             {fromPosition Colon}
  $equal {fromPosition Equal}
  $lambdaStart {fromPosition LambdaStart}
  @pipe                             {fromPosition Pipe}
  @dot {fromPosition Dot}
  @comma {fromPosition Comma}
  @rightArrow {fromPosition RightArrow}
  @leftArrow {fromPosition LeftArrow}
  @leftBrace {fromPosition LeftBrace}
  @rightBrace {fromPosition RightBrace}
  @leftBracket {fromPosition LeftBracket}
  @rightBracket {fromPosition RightBracket}
  @leftParen  {fromPosition LeftParen}
  @rightParen  {fromPosition RightParen}
  @backTick {fromPosition BackTick}

  let {fromPosition Let}
  in {fromPosition In}
  case {fromPosition Case}
  of {fromPosition Of}
  forall {fromPosition Forall}
  data {fromPosition Data}
  type {fromPosition Type}
  term {fromPosition Term}
  newtype {fromPosition NewType}
  module {fromPosition Module}
  import {fromPosition Import}
  where {fromPosition Where}
  as {fromPosition As}
  left  {fromPosition Left_}
  right {fromPosition Right_}
  none {fromPosition None}
  unqualified {fromPosition Unqualified}

  operator  {fromPosition OperatorKeyword}
  @operator {makeOperatorToken NonPrefixedOperator}
  @prefixedOperator {makeOperatorToken PrefixedOperator}

  @uint {makeToken LiteralUint}

  @nonCapitalizedIdentifier {makeVariableToken NonCapitalized}
  @capitalizedIdentifier {makeVariableToken Capitalized}
  @prefixedVariable {makeVariableToken NonCapitalizedPrefixed}
  @prefixedCapitalized {makeVariableToken CapitalizedPrefixed}


{
-- Each action has type :: String -> Token

-- The token type:
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
  | EOF
  | LexerError Range Char String
  deriving (Show)


makeVariableToken constructor pos str = 
  let 
      var = makeToken constructor pos str
      range = alexPos2Range pos str
  in 
    TokenVariable range var

makeOperatorToken constructor pos str = 
  let 
      var = makeToken constructor pos str
      range = alexPos2Range pos str
  in 
    TokenOperator range var


alexPos2Range (AlexPn positionStart lineStart columnStart) str = 
  let columnEnd = columnStart + length str
      positionEnd = positionStart + length str
  in
  Range{lineStart,columnStart,positionStart,lineEnd=lineStart,columnEnd,positionEnd}

fromPosition :: (Range -> Token) -> AlexPosn -> String -> Token
fromPosition constructor pos s = 
  let range = alexPos2Range pos s
  in
    constructor range

makeToken constructor pos s =
  let range = alexPos2Range pos s
  in
    constructor range s

-- lexer :: String -> [Either LexerError AlexToken]
lexer str = go (alexStartPos, '\n', [], str)
  where
    go inp@(pos, _, _, str) =
      case alexScan inp 0 of
        AlexEOF                -> []
        AlexSkip  inp' len     -> go inp'
        AlexToken inp' len act -> (act pos (take len str)) : go inp'
        -- the skiped param is the remaining bytes
        AlexError (pos,previous, _,remain) -> [LexerError (alexPos2Range pos []) previous remain]
}
