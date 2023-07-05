module Main where

import qualified Control.Exception (catch)
import Control.Monad.Trans.Reader (runReaderT)
import HMeguKin.Parser.Indenter (indent)
import HMeguKin.Parser.Lexer (lexer)
import HMeguKin.Parser.Monad (getErrorPart, prettyfyParserError)
import HMeguKin.Parser.Parser (parse)
import HMeguKin.Parser.SST (Type)
import HMeguKin.Parser.Types (token2Name)
import Prettyprinter (Pretty (pretty))

main :: IO ()
main = do
  putStrLn "Hello, Haskell!"
  -- FIXME: The of at the same level as `case` is causing the creation of layout separator
  -- fix that or add it to the grammar
  let strToParse = "fact n =\n case n of\n          0 -> 1\n          1 -> 1\n          _ ->  n * (fact (n-1))"
      values = lexer strToParse
  print values
  let indented = indent values
  print $ token2Name <$> indented
  let parsedResult = runReaderT parse indented
  case parsedResult of
    Left parserError -> print $ prettyfyParserError strToParse parserError
    Right parsed -> do
      print parsed
      let prettier = pretty parsed
      print prettier
      let relexed = (indent . lexer) (show prettier)
      print (relexed == indented)
      print $ token2Name <$> relexed
