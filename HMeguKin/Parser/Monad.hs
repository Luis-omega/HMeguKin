module HMeguKin.Parser.Monad where

import Control.Monad.Reader (ReaderT (ReaderT))
import Control.Monad.Trans.Reader (ask, local)
import HMeguKin.Parser.Types (HasRange (getRange), IndenterError (ContextFirstValueBeforeStart, MissIndentedAfterEqual, UnexpectedEOF), Token (EOF, LexerError, TokenIndenterError), range2PartialTuple, token2Name)

type ParserMonad a = ReaderT [Token] (Either [String]) a

returnError :: [String] -> ParserMonad a
returnError msg = ReaderT (const $ Left msg)

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
          let errorRest = take 10 remain
           in returnError
                [ "Unexpected character '"
                    <> take 1 remain
                    <> "' at line "
                    <> show line
                    <> ", column "
                    <> show column
                    <> ".",
                  errorRest
                ]
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
        _ ->
          returnError $
            [ "Unexpected "
                <> tokenName
                <> " at line "
                <> show line
                <> ", column "
                <> show column
                <> ".",
              "Expected one of: "
            ]
              <> expectedTokens
