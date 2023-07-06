module HMeguKin.Parser.Monad where

import Control.Monad.Reader (ReaderT (ReaderT))
import Control.Monad.Trans.Reader (ask, local)
import Data.Maybe (maybeToList)
import Debug.Trace (trace)
import HMeguKin.Parser.Types
  ( HasRange (getRange),
    IndenterError
      ( ContextFirstValueBeforeStart,
        MissIndentedAfterEqual,
        UnexpectedEOF
      ),
    Range (Range, columnEnd, columnStart, lineEnd, lineStart, positionEnd, positionStart),
    Token
      ( EOF,
        LayoutEnd,
        LayoutSeparator,
        LayoutStart,
        LexerError,
        TokenIndenterError
      ),
    range2PartialTuple,
    token2Name,
  )
import Prettyprinter (Doc, Pretty (pretty), concatWith, emptyDoc, hardline, nest, (<+>))

data ParserError = ParserError
  { msg :: [String],
    range :: Range,
    expected :: [String]
  }
  deriving stock (Show, Eq)

type ParserMonad a = ReaderT [Token] (Either ParserError) a

returnError :: [String] -> Range -> [String] -> ParserMonad a
returnError msg range = ReaderT . const . Left . ParserError msg range

monadicLexer :: (Token -> ParserMonad a) -> ParserMonad a
monadicLexer cont = do
  tokens <- ask
  case tokens of
    [] -> cont EOF
    (token : remain) -> local (const remain) (cont token)

parseError :: (Token, [String]) -> ParserMonad a
parseError (errorToken, expectedTokens) =
  let range = getRange errorToken
      (line, column, _) = range2PartialTuple range
      tokenName = token2Name errorToken
   in case errorToken of
        LexerError _ _ remain ->
          returnError
            [ "Unexpected character '"
                <> take 1 remain
                <> "' at line "
                <> show line
                <> ", column "
                <> show column
                <> "."
            ]
            range
            []
        TokenIndenterError _ err ->
          case err of
            UnexpectedEOF tokenName ->
              returnError
                [ "Unexpected end of input at line "
                    <> show line
                    <> ", column "
                    <> show column
                    <> ".",
                  "The token "
                    <> tokenName
                    <> " should be followed by more tokens."
                ]
                range
                expectedTokens
            ContextFirstValueBeforeStart originToken newToken ->
              let realRange = getRange newToken
                  (rline, rcolumn, _) = range2PartialTuple realRange
               in returnError
                    [ "Unexpected indentation at token "
                        <> token2Name newToken
                        <> ", at line "
                        <> show rline
                        <> ", column "
                        <> show rcolumn
                        <> ".",
                      "Token "
                        <> token2Name originToken
                        <> " must be followed by a token with further indentation."
                    ]
                    realRange
                    []
            MissIndentedAfterEqual originToken newToken ->
              let realRange = getRange newToken
                  (rline, rcolumn, _) = range2PartialTuple realRange
               in returnError
                    [ "Unexpected indentation at token "
                        <> token2Name newToken
                        <> ", at line "
                        <> show rline
                        <> ", column "
                        <> show rcolumn
                        <> ".",
                      "Token "
                        <> token2Name originToken
                        <> " must be followed by a indented token."
                    ]
                    realRange
                    []
        LayoutStart _ realToken ->
          returnError
            [ "Unexpected indentation at token "
                <> token2Name realToken
                <> " at line "
                <> show line
                <> ", column "
                <> show column
                <> "."
            ]
            range
            []
        LayoutSeparator _ realToken ->
          returnError
            [ "Unexpected indentation at token "
                <> token2Name realToken
                <> " at line "
                <> show line
                <> ", column "
                <> show column
                <> "."
            ]
            range
            []
        LayoutEnd _ realToken ->
          returnError
            [ "Unexpected indentation at token "
                <> token2Name realToken
                <> " at line "
                <> show line
                <> ", column "
                <> show column
                <> "."
            ]
            range
            []
        _ ->
          returnError
            [ "Unexpected "
                <> tokenName
                <> " at line "
                <> show line
                <> ", column "
                <> show column
                <> "."
            ]
            range
            expectedTokens

prettyfyParserError :: String -> ParserError -> Doc ann
prettyfyParserError input ParserError {..} =
  let errorPart = maybeToList $ getErrorPart input range
      allstuff = case expected of
        [] ->
          concatWith (\x y -> x <> hardline <> y) $
            (pretty <$> msg) <> errorPart
        _ ->
          concatWith
            (\x y -> x <> hardline <> y)
            ( (pretty <$> msg)
                <> errorPart
            )
            <> hardline
            <> pretty @String
              "Expected: "
            <> nest
              4
              ( hardline
                  <> pretty '*'
                  <+> concatWith
                    ( \x y ->
                        x
                          <> hardline
                          <> pretty '*'
                          <+> y
                    )
                    (pretty <$> expected)
              )
   in nest
        4
        ( hardline
            <> allstuff
            <> if elem "LayoutEnd" expected
              || elem "LayoutSeparator" expected
              || elem "LayoutStart" expected
              then hardline <> pretty @String "Maybe you have a wrong indentation level?"
              else emptyDoc
        )

getErrorPart :: String -> Range -> Maybe (Doc ann)
getErrorPart input (Range {..}) =
  if lineStart == lineEnd
    then pretty @String <$> getLineOf input (positionStart, trace (show columnEnd) columnEnd)
    else
      if (lineStart + 1) == lineEnd
        then do
          start <- getLineOf input (positionStart, columnStart)
          end <- getLineOf input (positionEnd, columnEnd)
          pure $ pretty start <+> hardline <+> pretty end
        else -- FIXME:
          pretty <$> getLineOf input (positionStart, columnStart)

getLineOf :: String -> (Int, Int) -> Maybe String
getLineOf "" _ = Nothing
getLineOf input (position, column) =
  let initLines = lines $ take position input
      endLines = lines $ drop position input
   in if column <= 2
        then case endLines of
          [] -> Nothing
          _ -> pure $ head endLines
        else case initLines of
          [] -> case endLines of
            [] -> Nothing
            _ -> pure $ head endLines
          _ ->
            let init = last initLines
             in case endLines of
                  [] -> pure init
                  _ -> pure $ init <> head endLines
