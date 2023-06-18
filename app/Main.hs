module Main where

import qualified Control.Exception (catch)

import HMeguKin.Parser.Lexer (lexer)

main :: IO ()
main = do
  putStrLn "Hello, Haskell!"
  let values = lexer "asdf;asdf"
  print values
