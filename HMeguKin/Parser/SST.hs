module HMeguKin.Parser.SST where

import Data.List.NonEmpty (NonEmpty ((:|)), intersperse, toList)
import Data.List.Split (splitOn)
import Data.Maybe (fromJust)
import HMeguKin.Parser.Types (HasRange (getRange), Range, mergeRanges)
import HMeguKin.Parser.Types qualified as Lexer
import HMeguKin.Parser.Types qualified as Types
import Prettyprinter (Doc, Pretty (pretty), align, colon, comma, encloseSep, group, hang, hardline, hsep, nest, parens, punctuate, sep, softline, vsep, (<+>))

prettyMaybeWithParens ::
  forall a ann.
  (Pretty a) =>
  (a -> Bool) ->
  a ->
  Doc ann
prettyMaybeWithParens predicate a =
  if predicate a then parens $ pretty a else pretty a

data IntercalatedList a b
  = FirstItem a
  | IntercalatedCons a (IntercalatedList b a)
  deriving stock (Show)

instance (HasRange a, HasRange b) => HasRange (IntercalatedList a b) where
  getRange (FirstItem a) = getRange a
  getRange (IntercalatedCons a b) = mergeRanges (getRange a) (getRange b)

prettyIntercaltedList ::
  forall a b ann.
  (a -> Doc ann) ->
  (b -> Doc ann) ->
  IntercalatedList a b ->
  Doc ann
prettyIntercaltedList prettyA _ (FirstItem a) = prettyA a
prettyIntercaltedList prettyA prettyB (IntercalatedCons a bs) =
  prettyA a <> softline <> prettyIntercaltedList prettyB prettyA bs

data Variable
  = PlainLowerCase Range String
  | PrefixedLowerCase Range (NonEmpty String) String
  | PlainCapitalized Range String
  | PrefixedCapitalized Range (NonEmpty String) String
  deriving stock (Show)

instance Pretty Variable where
  pretty (PlainLowerCase _ s) = pretty s
  pretty (PrefixedLowerCase _ p s) =
    pretty (intersperse "." p) <> pretty '.' <> pretty s
  pretty (PlainCapitalized _ s) = pretty s
  pretty (PrefixedCapitalized _ p s) =
    pretty (intersperse "." p) <> pretty '.' <> pretty s

instance HasRange Variable where
  getRange (PlainLowerCase range _) = range
  getRange (PrefixedLowerCase range _ _) = range
  getRange (PlainCapitalized range _) = range
  getRange (PrefixedCapitalized range _ _) = range

data Literal
  = LiteralUint Range String
  | LiteralString Range String
  deriving stock (Show)

instance HasRange Literal where
  getRange (LiteralUint range _) = range
  getRange (LiteralString range _) = range

instance Pretty Literal where
  pretty (LiteralUint _ s) = pretty s
  -- FIXME: add scaping for " in the string and other string related format
  pretty (LiteralString _ s) = pretty '\"' <> pretty s <> pretty '\"'

data Operator
  = PlainOperator Range String
  | PrefixedOperator Range (NonEmpty String) String
  | VariableAsOperator Range Variable
  deriving stock (Show)

instance HasRange Operator where
  getRange (PlainOperator r _) = r
  getRange (PrefixedOperator r _ _) = r
  getRange (VariableAsOperator r _) = r

instance Pretty Operator where
  pretty (PlainOperator _ s) = pretty s
  pretty (PrefixedOperator _ p s) =
    pretty (intersperse "." p) <> pretty '.' <> pretty s
  pretty (VariableAsOperator _ v) = pretty '`' <> pretty v <> pretty '`'

data Pattern
  = LiteralPattern Range Literal
  | HolePattern Range
  | VariablePattern Range Variable
  | ApplicationPattern Range Variable (NonEmpty Pattern)
  | -- (pattern : Type)
    AnnotationPattern Range Pattern Type
  | -- (name@pattern)
    AsPattern Range Variable Pattern
  deriving stock (Show)

instance Pretty Pattern where
  pretty (LiteralPattern _ l) = pretty l
  pretty (HolePattern _) = pretty '_'
  pretty (VariablePattern _ v) = pretty v
  pretty (ApplicationPattern _ v p) =
    group . hang 2 . vsep $
      (pretty v : toList (prettyMaybeWithParens patternNeedParens <$> p))
  pretty (AnnotationPattern _ p t) = pretty p <> colon <> pretty t
  pretty (AsPattern _ v p) =
    pretty v
      <> pretty '@'
      <> prettyMaybeWithParens patternNeedParens p

patternNeedParens :: Pattern -> Bool
patternNeedParens (LiteralPattern _ _) = False
patternNeedParens (HolePattern _) = False
patternNeedParens (VariablePattern _ _) = False
patternNeedParens (ApplicationPattern {}) = True
patternNeedParens (AnnotationPattern {}) = True
patternNeedParens (AsPattern {}) = False

instance HasRange Pattern where
  getRange (LiteralPattern range _) = range
  getRange (HolePattern range) = range
  getRange (VariablePattern range _) = range
  getRange (ApplicationPattern range _ _) = range
  getRange (AnnotationPattern range _ _) = range
  getRange (AsPattern range _ _) = range

data MetaRecord a
  = EmptyRecord Range
  | NonEmptyRecord Range (NonEmpty (Range, Variable, a))
  deriving stock (Show)

instance HasRange (MetaRecord a) where
  getRange (EmptyRecord r) = r
  getRange (NonEmptyRecord r _) = r

prettyMetaRecord ::
  forall
    a
    ann.
  ((Range, Variable, a) -> Doc ann) ->
  MetaRecord a ->
  Doc ann
prettyMetaRecord _ (EmptyRecord _) = pretty @String "{}"
prettyMetaRecord prettyItem (NonEmptyRecord _ items) =
  encloseSep
    (pretty '{')
    (pretty '}')
    comma
    (toList $ prettyItem <$> items)

data Type
  = VariableType Range Variable
  | RecordType Range (MetaRecord Type)
  | MeaninglessOperatorsType Range (IntercalatedList Type Operator)
  | ApplicationType Range Type Type
  | TypeArrow Range Type Type
  | TypeForall Range (NonEmpty Variable) Type
  deriving stock (Show)

instance HasRange Type where
  getRange (VariableType range _) = range
  getRange (RecordType range _) = range
  getRange (MeaninglessOperatorsType range _) = range
  getRange (ApplicationType range _ _) = range
  getRange (TypeArrow range _ _) = range
  getRange (TypeForall range _ _) = range

instance Pretty Type where
  pretty (VariableType _ v) = pretty v
  pretty (RecordType _ record) = prettyMetaRecord prettyItem record
    where
      prettyItem (_, v, t) = pretty v <> colon <> pretty t
  pretty (MeaninglessOperatorsType _ lst) =
    prettyIntercaltedList (prettyMaybeWithParens needParens) pretty lst
    where
      needParens (VariableType _ _) = False
      needParens (RecordType _ _) = False
      needParens (MeaninglessOperatorsType _ _) = True
      needParens (ApplicationType {}) = False
      needParens (TypeArrow {}) = True
      needParens (TypeForall {}) = True
  pretty (ApplicationType _ t1 t2) =
    case t1 of
      (VariableType _ _) ->
        group (pretty t1 <> softline <> prettyMaybeWithParens needParens t2)
      (RecordType _ _) ->
        group (pretty t1 <> softline <> prettyMaybeWithParens needParens t2)
      (MeaninglessOperatorsType _ _) ->
        group
          ( parens (pretty t1)
              <> softline
              <> prettyMaybeWithParens needParens t2
          )
      (ApplicationType {}) ->
        group (pretty t1 <> softline <> prettyMaybeWithParens needParens t2)
      (TypeArrow {}) ->
        group (parens (pretty t1) <> softline <> prettyMaybeWithParens needParens t2)
      (TypeForall {}) ->
        group (parens (pretty t1) <> softline <> prettyMaybeWithParens needParens t2)
    where
      needParens (VariableType _ _) = False
      needParens (RecordType _ _) = False
      needParens (MeaninglessOperatorsType _ _) = True
      needParens (ApplicationType {}) = True
      needParens (TypeArrow {}) = True
      needParens (TypeForall {}) = True
  pretty (TypeArrow _ t1 t2) =
    prettyMaybeWithParens
      needParens
      t1
      <+> pretty @String "->" <> softline <> pretty t2
    where
      needParens (VariableType _ _) = False
      needParens (RecordType _ _) = False
      needParens (MeaninglessOperatorsType _ _) = False
      needParens (ApplicationType {}) = False
      needParens (TypeArrow {}) = True
      needParens (TypeForall {}) = True
  pretty (TypeForall _ vars t) =
    group $
      pretty @String "forall"
        <> softline
        -- TODO: Maybe move this align?
        <> align
          ( vsep (pretty <$> toList vars)
              <> softline
              <> pretty '.'
              <> softline
              <> pretty t
          )

data LetBinding = LetBinding Range Pattern Expression
  deriving stock (Show)

instance HasRange LetBinding where
  getRange (LetBinding r _ _) = r

instance Pretty LetBinding where
  pretty (LetBinding _ p e) =
    pretty p
      <> group
        ( nest
            2
            ( softline
                <> pretty '='
                <> softline
                <> pretty e
            )
        )

data CaseCase = CaseCase Range Pattern Expression
  deriving stock (Show)

instance HasRange CaseCase where
  getRange (CaseCase r _ _) = r

instance Pretty CaseCase where
  pretty (CaseCase _ p e) =
    pretty p
      <> group
        ( nest
            2
            ( softline
                <> pretty @String "->"
                <> softline
                <> pretty e
            )
        )

data Expression
  = LiteralExpression Range Literal
  | VariableExpression Range Variable
  | -- | The Nothing case implies that the variable
    -- | name must be in scope and is not qualified.
    RecordExpression Range (MetaRecord (Maybe Expression))
  | RecordUpdate Range (MetaRecord Expression)
  | OperatorInParens Range Operator
  | AnnotationExpression Range Expression Type
  | TypeArgumentExpression Range Type
  | Accessor Range Expression Variable
  | AccessorFunction Range Variable
  | ApplicationExpression Range Expression (NonEmpty Expression)
  | MeaninglessOperatorsExpression Range (IntercalatedList Expression Operator)
  | Case Range Expression (NonEmpty CaseCase)
  | Lambda Range (NonEmpty Pattern) Expression
  | Let Range (NonEmpty LetBinding) Expression
  deriving stock (Show)

instance HasRange Expression where
  getRange (LiteralExpression r _) = r
  getRange (VariableExpression r _) = r
  getRange (RecordExpression r _) = r
  getRange (RecordUpdate r _) = r
  getRange (OperatorInParens r _) = r
  getRange (AnnotationExpression r _ _) = r
  getRange (TypeArgumentExpression r _) = r
  getRange (Accessor r _ _) = r
  getRange (AccessorFunction r _) = r
  getRange (ApplicationExpression r _ _) = r
  getRange (MeaninglessOperatorsExpression r _) = r
  getRange (Case r _ _) = r
  getRange (Lambda r _ _) = r
  getRange (Let r _ _) = r

instance Pretty Expression where
  pretty (LiteralExpression _ l) = pretty l
  pretty (VariableExpression _ v) = pretty v
  pretty (RecordExpression _ r) = prettyMetaRecord prettyItem r
    where
      prettyItem (_, v, Nothing) = pretty v
      prettyItem (_, v, Just e) = pretty v <+> colon <+> pretty e
  pretty (RecordUpdate _ r) = prettyMetaRecord prettyItem r
    where
      prettyItem (_, v, e) = pretty v <+> pretty '=' <+> pretty e
  pretty (OperatorInParens _ o) = parens $ pretty o
  pretty (AnnotationExpression _ e a) = parens $ pretty e <> colon <> pretty a
  pretty (TypeArgumentExpression _ t) =
    pretty '@'
      <> prettyMaybeWithParens needParens t
    where
      needParens (VariableType _ _) = False
      needParens (RecordType _ _) = False
      needParens (MeaninglessOperatorsType _ _) = True
      needParens (ApplicationType {}) = True
      needParens (TypeArrow {}) = True
      needParens (TypeForall {}) = True
  pretty (Accessor _ e v) =
    case e of
      (VariableExpression _ _) -> pretty e <> pretty '.' <> pretty v
      _ -> parens (pretty e) <> pretty '.' <> pretty v
  pretty (AccessorFunction _ v) = pretty @String "_." <> pretty v
  pretty (ApplicationExpression _ e1 e2) =
    prettyMaybeWithParens predicate e1
      <> softline
      <> sep (prettyMaybeWithParens predicate2 <$> toList e2)
    where
      predicate (LiteralExpression _ _) = False
      predicate (VariableExpression _ _) = False
      predicate (RecordExpression _ _) = False
      predicate (RecordUpdate _ _) = False
      predicate (OperatorInParens _ _) = False
      predicate (AnnotationExpression {}) = False
      predicate (TypeArgumentExpression _ _) = False
      predicate (Accessor {}) = False
      predicate (AccessorFunction _ _) = False
      predicate (ApplicationExpression {}) = False
      predicate (MeaninglessOperatorsExpression _ _) = True
      predicate (Case {}) = True
      predicate (Lambda {}) = True
      predicate (Let {}) = True
      predicate2 (ApplicationExpression {}) = True
      predicate2 x = predicate x
  pretty (MeaninglessOperatorsExpression _ lst) =
    prettyIntercaltedList (prettyMaybeWithParens predicate) pretty lst
    where
      predicate (LiteralExpression _ _) = False
      predicate (VariableExpression _ _) = False
      predicate (RecordExpression _ _) = False
      predicate (RecordUpdate _ _) = False
      predicate (OperatorInParens _ _) = False
      predicate (AnnotationExpression {}) = False
      predicate (TypeArgumentExpression _ _) = False
      predicate (Accessor {}) = False
      predicate (AccessorFunction _ _) = False
      predicate (ApplicationExpression {}) = False
      predicate (MeaninglessOperatorsExpression _ _) = True
      predicate (Case {}) = True
      predicate (Lambda {}) = True
      predicate (Let {}) = True
  pretty (Case _ e cases) =
    group
      ( pretty @String "case"
          <> nest 2 (softline <> pretty e)
          <> softline
          <> pretty @String "of"
          <> nest 2 (vsep $ pretty <$> toList cases)
      )
  pretty (Lambda _ ps e) =
    group
      ( pretty '\\'
          <> hsep (prettyMaybeWithParens patternNeedParens <$> toList ps)
          <> pretty @String "->"
          <> softline
          <> pretty e
      )
  pretty (Let _ bs e) =
    (group . align)
      ( pretty @String "let"
          <> nest 2 (hardline <> foldr1 (<>) (intersperse hardline (pretty <$> bs)))
          <> hardline
          <> "in"
          <> nest
            2
            ( hardline
                <> pretty e
            )
      )

data Constructor = Constructor Range Variable [Type]
  deriving stock (Show)

instance HasRange Constructor where
  getRange (Constructor r _ _) = r

instance Pretty Constructor where
  pretty (Constructor _ v ts) =
    pretty v <+> hsep (punctuate (pretty ',') (pretty <$> ts))

data OperatorFixity
  = IsTypeOperator Range
  | IsTermOperator Range
  deriving stock (Show)

instance HasRange OperatorFixity where
  getRange (IsTypeOperator r) = r
  getRange (IsTermOperator r) = r

instance Pretty OperatorFixity where
  pretty (IsTypeOperator _) = pretty @String "type"
  pretty (IsTermOperator _) = pretty @String "term"

data OperatorKind
  = LeftOperator Range
  | RightOperator Range
  | NoneOperator Range
  deriving stock (Show)

instance HasRange OperatorKind where
  getRange (LeftOperator r) = r
  getRange (RightOperator r) = r
  getRange (NoneOperator r) = r

instance Pretty OperatorKind where
  pretty (LeftOperator _) = pretty @String "left"
  pretty (RightOperator _) = pretty @String "right"
  pretty (NoneOperator _) = pretty @String "none"

data ImportItem
  = ImportTypeOrVar Range Variable [Variable]
  | ImportTypeOperator Range Operator
  | ImportTermOperator Range Operator
  deriving stock (Show)

instance HasRange ImportItem where
  getRange (ImportTypeOrVar r _ _) = r
  getRange (ImportTypeOperator r _) = r
  getRange (ImportTermOperator r _) = r

instance Pretty ImportItem where
  pretty (ImportTypeOrVar _ v []) = pretty v
  pretty (ImportTypeOrVar _ v xs) =
    pretty v <> parens (sep (punctuate comma $ pretty <$> xs))
  pretty (ImportTypeOperator _ op) = pretty @String "type" <+> parens (pretty op)
  pretty (ImportTermOperator _ op) = parens (pretty op)

data Import
  = ImportAs Range Variable [ImportItem] Variable
  | ImportSimple Range Variable [ImportItem]
  deriving stock (Show)

instance HasRange Import where
  getRange (ImportAs r _ _ _) = r
  getRange (ImportSimple r _ _) = r

instance Pretty Import where
  pretty (ImportAs _ name [] qualifier) =
    pretty @String "import"
      <+> pretty name
      <+> pretty @String "as"
      <+> pretty qualifier
  pretty (ImportAs _ name items qualifier) =
    pretty @String "import"
      <+> group
        ( pretty name
            <> parens (sep (punctuate comma $ pretty <$> items))
            <> softline
            <> pretty @String "as"
            <+> pretty qualifier
        )
  pretty (ImportSimple _ name items) =
    pretty @String "import"
      <+> pretty name
        <> parens (sep (punctuate comma $ pretty <$> items))

data ModuleStatement
  = ModuleVariableDeclaration Range Variable Type
  | ModulePatternDefinition Range Pattern Expression
  | ModuleDataType Range Variable [Variable] (NonEmpty Constructor)
  | ModuleOperatorFixity Range Operator OperatorFixity OperatorKind Int
  | ModuleImport Range Import
  | ModuleExport
  deriving stock (Show)

instance Pretty ModuleStatement where
  pretty (ModuleVariableDeclaration _ v t) =
    group $
      pretty v
        <> nest
          2
          ( softline
              <> colon
              <> softline
              <> pretty t
          )
  pretty (ModulePatternDefinition _ p d) =
    group $
      pretty p
        <+> pretty '='
          <> nest
            2
            ( hardline
                <> pretty d
            )
  pretty (ModuleDataType _ name vars constructors) =
    group $
      pretty name
        <+> hsep (pretty <$> vars)
          <> nest
            2
            ( softline
                <> pretty '='
                <> softline
                <> hsep
                  ( punctuate
                      (hardline <> pretty '|')
                      (pretty <$> toList constructors)
                  )
            )
  pretty (ModuleOperatorFixity _ operator operatorFixity operatorKind level) =
    pretty @String "operator"
      <+> pretty operator
      <+> pretty operatorFixity
      <+> pretty operatorKind
      <+> pretty level
  pretty (ModuleImport _ imports) = pretty imports
  pretty ModuleExport = pretty @String "module I don't know what to put here right now."

data ParsedModule = ParsedModule String [ModuleStatement]

-- instance Pretty ParsedModule where

splitStringByDot :: String -> Maybe (String, NonEmpty String)
splitStringByDot value =
  case splitOn "." value of
    [] -> Nothing
    xs ->
      let name = last xs
       in case init xs of
            [] -> Nothing
            (first : remain) -> Just (name, first :| remain)

tokenVariable2Variable :: Types.Variable -> Variable
tokenVariable2Variable (Types.NonCapitalized range value) = PlainLowerCase range value
tokenVariable2Variable (Types.NonCapitalizedPrefixed range value) =
  let (name, prefix) = fromJust $ splitStringByDot value
   in PrefixedLowerCase range prefix name
tokenVariable2Variable (Types.Capitalized range value) = PlainCapitalized range value
tokenVariable2Variable (Types.CapitalizedPrefixed range value) =
  let (name, prefix) = fromJust $ splitStringByDot value
   in PrefixedCapitalized range prefix name

tokenLiteral2Literal :: Types.Token -> Literal
tokenLiteral2Literal (Types.LiteralUint range value) = LiteralUint range value
tokenLiteral2Literal _ = error "This isn't suppose to happen"

lexerOperator2Operator :: Lexer.Operator -> Operator
lexerOperator2Operator (Lexer.NonPrefixedOperator range value) =
  PlainOperator range value
lexerOperator2Operator (Lexer.PrefixedOperator range value) =
  let (name, prefix) = fromJust $ splitStringByDot value
   in PrefixedOperator range prefix name

-- maybe use foldl
makeAccessor :: Expression -> [Variable] -> Expression
makeAccessor exp [] = exp
makeAccessor exp (last : ls) =
  let accessor = Accessor (getRange (exp, last)) exp last
   in makeAccessor accessor ls
