module HMeguKin.Parser.Indenter (indent) where

import HMeguKin.Parser.Lexer qualified as Lexer
import HMeguKin.Parser.Types
  ( IndenterError (..),
    Operator
      ( NonPrefixedOperator,
        PrefixedOperator
      ),
    Range
      ( Range,
        columnEnd,
        columnStart,
        lineEnd,
        lineStart,
        positionEnd,
        positionStart
      ),
    Token (..),
    Variable
      ( Capitalized,
        CapitalizedPrefixed,
        NonCapitalized,
        NonCapitalizedPrefixed
      ),
  )
import HMeguKin.Parser.Types qualified as Types

data LayoutContext
  = IndentAtNextToken {start :: Lexer.Token, next :: Lexer.Token}
  | Root

-- \| ForgetIndent Token

data Stream
  = Peek Lexer.Token [Lexer.Token]
  | EOFStream
  deriving stock (Show)

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
token2Name token =
  case token of
    Lexer.Comment _ _ -> "Comment"
    Lexer.At _ -> "@"
    Lexer.Hole _ -> "_"
    Lexer.Colon _ -> ":"
    Lexer.Equal _ -> "Equal"
    Lexer.LambdaStart _ -> "LambdaStart"
    Lexer.Pipe _ -> "Pipe"
    Lexer.Dot _ -> "Dot"
    Lexer.Comma _ -> "Comma"
    Lexer.RightArrow _ -> "RightArrow"
    Lexer.LeftArrow _ -> "LeftArrow"
    Lexer.LeftBrace _ -> "LeftBrace"
    Lexer.RightBrace _ -> "RightBrace"
    Lexer.LeftBracket _ -> "LeftBracket"
    Lexer.RightBracket _ -> "RightBracket"
    Lexer.LeftParen _ -> "LeftParen"
    Lexer.RightParen _ -> "RightParen"
    Lexer.BackTick _ -> "BackTick"
    Lexer.Let _ -> "Let"
    Lexer.In _ -> "In"
    Lexer.Case _ -> "Case"
    Lexer.Of _ -> "Of"
    Lexer.Forall _ -> "Forall"
    Lexer.Data _ -> "Data"
    Lexer.Type _ -> "Type"
    Lexer.Term _ -> "Term"
    Lexer.NewType _ -> "NewType"
    Lexer.Module _ -> "Module"
    Lexer.Import _ -> "Import"
    Lexer.Where _ -> "Where"
    Lexer.As _ -> "As"
    Lexer.Left_ _ -> "Left_"
    Lexer.Right_ _ -> "Right_"
    Lexer.None _ -> "None"
    Lexer.Unqualified _ -> "Unqualified"
    Lexer.OperatorKeyword _ -> "OperatorKeyword"
    Lexer.TokenOperator _ _ -> "TokenOperator"
    Lexer.LiteralUint _ _ -> "LiteralUint"
    Lexer.TokenVariable _ _ -> "TokenVariable"
    Lexer.EOF -> "EOF"
    Lexer.LexerError _ _ _ -> "LexerError"

-- TODO: MOve to lexer.x
-- FIXME
token2Range :: Lexer.Token -> Range
token2Range token =
  case token of
    Lexer.Comment range _ -> range
    Lexer.At range -> range
    Lexer.Hole range -> range
    Lexer.Colon range -> range
    Lexer.Equal range -> range
    Lexer.LambdaStart range -> range
    Lexer.Pipe range -> range
    Lexer.Dot range -> range
    Lexer.Comma range -> range
    Lexer.RightArrow range -> range
    Lexer.LeftArrow range -> range
    Lexer.LeftBrace range -> range
    Lexer.RightBrace range -> range
    Lexer.LeftBracket range -> range
    Lexer.RightBracket range -> range
    Lexer.LeftParen range -> range
    Lexer.RightParen range -> range
    Lexer.BackTick range -> range
    Lexer.Let range -> range
    Lexer.In range -> range
    Lexer.Case range -> range
    Lexer.Of range -> range
    Lexer.Forall range -> range
    Lexer.Data range -> range
    Lexer.Type range -> range
    Lexer.Term range -> range
    Lexer.NewType range -> range
    Lexer.Module range -> range
    Lexer.Import range -> range
    Lexer.Where range -> range
    Lexer.As range -> range
    Lexer.Left_ range -> range
    Lexer.Right_ range -> range
    Lexer.None range -> range
    Lexer.Unqualified range -> range
    Lexer.OperatorKeyword range -> range
    Lexer.TokenOperator range _ -> range
    Lexer.LiteralUint range _ -> range
    Lexer.TokenVariable range _ -> range
    Lexer.EOF -> Range (-1) (-1) (-1) (-1) (-1) (-1)
    Lexer.LexerError range _ _ -> range

alexToken2token :: Lexer.Token -> Token
alexToken2token token =
  case token of
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
    Lexer.BackTick range -> BackTick range
    Lexer.Let range -> Let range
    Lexer.In range -> In range
    Lexer.Case range -> Case range
    Lexer.Of range -> Of range
    Lexer.Forall range -> Forall range
    Lexer.Data range -> Data range
    Lexer.Type range -> Type range
    Lexer.Term range -> Term range
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
                  let tokenLayout = makeLayout LayoutStart token
                      layoutContext = IndentAtNextToken {start = token, next = nextToken}
                   in (layoutContext : stack, pure tokenLayout)
                else (stack, Nothing)
            else
              ( stack,
                pure $
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
              let tokenLayout = makeLayout LayoutStart nextToken
                  layoutContext = IndentAtNextToken {start = token, next = nextToken}
               in (layoutContext : stack, tokenLayout)
            else
              ( stack,
                TokenIndenterError range $
                  MissIndentedAfterEqual
                    (alexToken2token token)
                    (alexToken2token nextToken)
              )

unwindStack :: [LayoutContext] -> Lexer.Token -> ([LayoutContext], [Token])
unwindStack stack token = loop stack
  where
    range = token2Range token
    loop [] = error "Something wrong happened at unwind"
    loop (Root : _) = ([Root], [])
    loop (IndentAtNextToken {next} : xs) =
      if columnStart range < columnStart (token2Range next)
        then
          let (newStack, generatedTokens) = loop xs
           in (newStack, makeLayout LayoutEnd token : generatedTokens)
        else (stack, [])

genSeparatorIfSameLevel :: [LayoutContext] -> Lexer.Token -> [Token]
genSeparatorIfSameLevel stack token =
  case stack of
    (IndentAtNextToken {next} : _) ->
      if columnStart (token2Range next) == columnStart (token2Range token)
        then
          if lineStart (token2Range next) == lineStart (token2Range token)
            then []
            else [makeLayout LayoutSeparator token]
        else []
    _ -> []

regularIndentStepCase ::
  Lexer.Token -> Stream -> [LayoutContext] -> ([LayoutContext], Stream, [Token])
regularIndentStepCase token remainStream stack =
  let (newStack, generatedToken) =
        makeContextAtNextToken token remainStream stack
   in case generatedToken of
        Just otherToken ->
          (newStack, remainStream, [alexToken2token token, otherToken])
        Nothing ->
          (newStack, remainStream, [alexToken2token token])

indentStep :: [LayoutContext] -> Stream -> ([LayoutContext], Stream, [Token])
indentStep stack stream =
  case consume stream of
    (Lexer.EOF, _) -> (stack, stream, [EOF])
    (token@(Lexer.Equal _), remainStream) ->
      case stack of
        [Root] ->
          let (newStack, generatedTokens) =
                makeContextAtRoot token remainStream stack
           in (newStack, remainStream, [alexToken2token token, generatedTokens])
        _ -> (stack, remainStream, [alexToken2token token])
    (token@(Lexer.Colon _), remainStream) ->
      case stack of
        [Root] ->
          let (newStack, generatedTokens) =
                makeContextAtRoot token remainStream stack
           in (newStack, remainStream, [alexToken2token token, generatedTokens])
        _ -> (stack, remainStream, [alexToken2token token])
    (token@(Lexer.Let _), remainStream) ->
      regularIndentStepCase token remainStream stack
    (token@(Lexer.In _), remainStream) ->
      regularIndentStepCase token remainStream stack
    (token@(Lexer.Case _), remainStream) ->
      regularIndentStepCase token remainStream stack
    (token@(Lexer.Of _), remainStream) ->
      regularIndentStepCase token remainStream stack
    (token, remainStream) ->
      (stack, remainStream, [alexToken2token token])

indentInner :: Stream -> [Token]
indentInner EOFStream = [EOF]
indentInner stream = loop [Root] stream
  where
    loop :: [LayoutContext] -> Stream -> [Token]
    loop [Root] EOFStream = []
    loop (_ : xs) EOFStream = makeLayout LayoutEnd Lexer.EOF : loop xs EOFStream
    loop stack stream =
      let (unwindedStack, unwindTokens) = unwindStack stack (peek stream)
          separatorTokens = genSeparatorIfSameLevel unwindedStack (peek stream)
          (newLayouts, newStream, tokens) = indentStep unwindedStack stream
       in unwindTokens
            ++ separatorTokens
            ++ if hasErrorToken tokens
              then tokens
              else tokens ++ loop newLayouts newStream

    hasErrorToken = any aux
    aux (TokenIndenterError _ _) = True
    aux _ = False

indent :: [Lexer.Token] -> [Token]
indent = indentInner . list2Stream
