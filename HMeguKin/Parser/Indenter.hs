module HMeguKin.Parser.Indenter (indent) where

import HMeguKin.Parser.Types (
  IndenterError (..),
  Operator (
    NonPrefixedOperator,
    PrefixedOperator
  ),
  Range (
    columnEnd,
    columnStart,
    lineEnd,
    lineStart,
    positionEnd,
    positionStart
  ),
  Token (..),
  Variable (
    Capitalized,
    CapitalizedPrefixed,
    NonCapitalized,
    NonCapitalizedPrefixed
  ),
 )

import HMeguKin.Parser.Lexer qualified as Lexer

data LayoutContext
  = IndentAtNextToken {start :: Lexer.Token, next :: Lexer.Token}
  | Root
  | ForgetIndent Token

data Stream
  = Peek Lexer.Token [Lexer.Token]
  | EOFStream

consume :: Stream -> (Lexer.Token, Stream)
consume (Peek t []) = (t, EOFStream)
consume (Peek t (x : xs)) = (t, Peek x xs)
consume EOFStream = (Lexer.EOF, EOFStream)

list2Stream :: [Lexer.Token] -> Stream
list2Stream [] = EOFStream
list2Stream (x : xs) = (Peek x xs)

peek :: Stream -> Lexer.Token
peek (Peek t _) = t
peek _ = Lexer.EOF

-- TODO: MOve to lexer.x
-- FIXME
token2Name :: Lexer.Token -> String
token2Name = undefined

-- TODO: MOve to lexer.x
-- FIXME
token2Range :: Lexer.Token -> Range
token2Range = undefined

alexToken2token :: Lexer.Token -> Token
alexToken2token token =
  case token of
    Lexer.LineBreak range -> LineBreak range
    Lexer.Comment range content -> Comment range content
    Lexer.At range -> At range
    Lexer.Hole range -> Hole range
    Lexer.Colon range -> Colon range
    Lexer.Equal range -> Equal range
    Lexer.LambdaStart range -> LambdaStart range
    Lexer.Pipe range -> Pipe range
    Lexer.Dot range -> Dot range
    Lexer.Comma range -> Comma range
    Lexer.RightArrow range -> RightArrow range
    Lexer.LeftArrow range -> LeftArrow range
    Lexer.LeftBrace range -> LeftBrace range
    Lexer.RightBrace range -> RightBrace range
    Lexer.LeftBracket range -> LeftBracket range
    Lexer.RightBracket range -> RightBracket range
    Lexer.LeftParen range -> LeftParen range
    Lexer.RightParen range -> RightParen range
    Lexer.Let range -> Let range
    Lexer.In range -> In range
    Lexer.Case range -> Case range
    Lexer.Of range -> Of range
    Lexer.Forall range -> Forall range
    Lexer.Data range -> Data range
    Lexer.Type range -> Type range
    Lexer.NewType range -> NewType range
    Lexer.Module range -> Module range
    Lexer.Import range -> Import range
    Lexer.Where range -> Where range
    Lexer.As range -> As range
    Lexer.Left_ range -> Left_ range
    Lexer.Right_ range -> Right_ range
    Lexer.None range -> None range
    Lexer.Unqualified range -> Unqualified range
    Lexer.OperatorKeyword range -> OperatorKeyword range
    Lexer.TokenOperator range operator -> TokenOperator range operator
    Lexer.LiteralUint range content -> LiteralUint range content
    Lexer.TokenVariable range variable -> TokenVariable range variable
    Lexer.EOF -> EOF
    Lexer.LexerError range char remain -> LexerError range char remain

makeLayout :: (Range -> Token) -> Lexer.Token -> Token
makeLayout constructor = constructor . token2Range

makeContextAtNextToken ::
  Lexer.Token ->
  Stream ->
  [LayoutContext] ->
  ([LayoutContext], Maybe Token)
makeContextAtNextToken token stream stack =
  case peek stream of
    Lexer.EOF ->
      let range = token2Range token
       in (stack, pure $ TokenIndenterError range $ UnexpectedEOF (token2Name token))
    nextToken ->
      let range = token2Range token
          nextRange = token2Range nextToken
       in if columnStart nextRange > columnStart range
            then
              if lineStart nextRange > lineStart range
                then
                  let
                    tokenLayout = makeLayout LayoutStart token
                    layoutContext = IndentAtNextToken{start = token, next = nextToken}
                   in
                    (layoutContext : stack, pure tokenLayout)
                else (stack, Nothing)
            else
              ( stack
              , pure $
                  TokenIndenterError range $
                    ContextFirstValueBeforeStart
                      (alexToken2token token)
                      (alexToken2token nextToken)
              )

makeContextAtRoot :: Lexer.Token -> Stream -> [LayoutContext] -> ([LayoutContext], Token)
makeContextAtRoot token stream stack =
  case peek stream of
    Lexer.EOF ->
      let range = token2Range token
       in (stack, TokenIndenterError range $ UnexpectedEOF (token2Name token))
    nextToken ->
      let range = token2Range token
          nextRange = token2Range nextToken
       in if columnStart nextRange > 1
            then
              let
                tokenLayout = makeLayout LayoutStart nextToken
                layoutContext = IndentAtNextToken{start = token, next = nextToken}
               in
                (layoutContext : stack, tokenLayout)
            else
              ( stack
              , TokenIndenterError range $
                  MissIndentedAfterEqual
                    (alexToken2token token)
                    (alexToken2token nextToken)
              )

-- TODO: Add a state for imports
indentStep :: [LayoutContext] -> Stream -> ([LayoutContext], Stream, [Token])
indentStep stack stream =
  case consume stream of
    -- FIXME:
    (Lexer.EOF, _) -> (stack, stream, undefined)
    (token@(Lexer.Equal _), remainStream) ->
      case stack of
        [Root] ->
          let (newStack, generatedTokens) = makeContextAtRoot token remainStream stack
           in (newStack, remainStream, [alexToken2token token, generatedTokens])
        _ -> (stack, remainStream, [alexToken2token token])

indentInner :: Stream -> [Token]
indentInner EOFStream = [EOF]
indentInner stream = loop [Root] stream
 where
  loop :: [LayoutContext] -> Stream -> [Token]
  loop layouts stream =
    let (newLayouts, newStream, tokens) = indentStep [Root] stream
     in if hasErrorToken tokens
          then tokens
          else tokens ++ loop newLayouts newStream

  hasErrorToken = any aux
  aux (TokenIndenterError _ _) = True
  aux _ = False

indent :: [Lexer.Token] -> [Token]
indent = indentInner . list2Stream
