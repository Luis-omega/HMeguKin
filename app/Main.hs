module Main where

import qualified Control.Exception (catch)
import HMeguKin.Parser.Indenter (indent)
import HMeguKin.Parser.Lexer (lexer)
import HMeguKin.Parser.Parser (parse)
import HMeguKin.Parser.Types (token2Name)

main :: IO ()
main = do
  putStrLn "Hello, Haskell!"
  let values = lexer "let \n a = b \n c = d\nin a"
  print values
  let indented = indent values
  print $ token2Name <$> indented
