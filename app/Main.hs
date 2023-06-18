module Main where

import qualified Control.Exception (catch)

import Control.Exception.Base (catch)
import HMeguKin.Parser.Lexer (alexScanTokens)

main :: IO ()
main = do
  putStrLn "Hello, Haskell!"
  values <- catch (alexScanTokens "_324") (const [])
  print values
