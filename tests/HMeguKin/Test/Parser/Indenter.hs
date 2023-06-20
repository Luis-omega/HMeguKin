module HMeguKin.Test.Parser.Indenter (unitTests) where

import Test.Tasty as Tasty
import Test.Tasty.Hspec (testSpec)

import Test.Hspec (describe, it, shouldBe)

unitTests :: IO Tasty.TestTree
unitTests = testSpec "Indenter" $ do
  describe "Prelude.head" $ do
    it "returns the first element of a list" $ do
      "a" `shouldBe` "a"
