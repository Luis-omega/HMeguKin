module Main where

import qualified Control.Exception (catch)
import HMeguKin.Parser.Indenter (indent)
import HMeguKin.Parser.Lexer (lexer)
import HMeguKin.Parser.Parser (parse)
import HMeguKin.Parser.SST (Type)
import HMeguKin.Parser.Types (token2Name)

main :: IO ()
main = do
  putStrLn "Hello, Haskell!"
  let values = lexer "1"
  print values
  let indented = indent values
  print $ token2Name <$> indented
  let parsed = parse indented
  print $ parsed
