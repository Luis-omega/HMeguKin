module HMeguKin.Test.Parser.ParserStage (unitTests) where

import Control.Monad.Trans.Reader (ReaderT (runReaderT))
import Data.Bifunctor (Bifunctor (first, second))
import Data.Either (fromRight)
import HMeguKin.Parser.Indenter (indent)
import HMeguKin.Parser.Lexer (lexer)
import HMeguKin.Parser.Monad (ParserError (ParserError), ParserMonad, prettyfyParserError)
import HMeguKin.Parser.Types (Token)
import Prettyprinter (Doc, Pretty (pretty), defaultLayoutOptions, layoutPretty)
import Prettyprinter.Render.String (renderString)
import Test.Hspec (Expectation, Spec, describe, it, shouldBe)
import Test.Tasty as Tasty
import Test.Tasty.Hspec (testSpec)

unitTests :: IO Tasty.TestTree
unitTests = testSpec "Indenter" $ do
  describe "Prelude.head" $ do
    it "returns the first element of a list" $ do
      "a" `shouldBe` "a"

makeRoundtripTest :: forall a. (Pretty a, Eq a, Show a) => a -> ParserMonad a -> Expectation
makeRoundtripTest value parser = do
  let firstPretty = simplePretty $ pretty value
      parse :: [Token] -> Either ParserError a = runReaderT parser
      firstResult = first (simplePretty . prettyfyParserError firstPretty) $ parse $ (indent . lexer) firstPretty
  (simplePretty . pretty <$> firstResult) `shouldBe` Right firstPretty
  let secondValue :: a = unsafeFromRight firstResult
      secondPretty = simplePretty $ pretty secondValue
      secondResult = first (simplePretty . prettyfyParserError secondPretty) $ parse $ (indent . lexer) secondPretty
  secondResult `shouldBe` firstResult
  where
    simplePretty :: Doc () -> String
    simplePretty = renderString . layoutPretty defaultLayoutOptions
    unsafeFromRight (Right x) = x
