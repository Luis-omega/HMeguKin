module Main (main) where

import Test.Tasty as Tasty

import HMeguKin.Test.Parser.Indenter qualified as Parser (unitTests)

main :: IO ()
main = do
  unit <- unitTests
  defaultMain unit

unitTests :: IO Tasty.TestTree
unitTests = do
  tests <- sequence [Parser.unitTests]
  pure $
    testGroup
      "UnitTests"
      tests
