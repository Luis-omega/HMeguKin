{
module HMeguKin.Parser.Lexer (lexer,alexScanTokens) where
}

%wrapper "monad"

$digit = 0-9            -- digits
$alpha = [a-zA-Z]       -- alphabetic characters

tokens :-

  $white+                        ;
  "--".*                         ;
  let                            { \s -> Let }
  in                             { \s -> In }
  $digit+                        { \s -> Int (read s) }
  [\=\+\-\*\/\(\)]               { \s -> Sym (head s) }
  $alpha [$alpha $digit \_ \']*  { \s -> Var s }

{
-- Each action has type :: String -> Token

-- The token type:
data Token
  = Let
  | In
  | Sym Char
  | Var String
  | Int Int
  deriving (Eq, Show)

lexer = do
  s <- getContents
  print (alexScanTokens s)
}