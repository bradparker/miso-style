{-# LANGUAGE OverloadedStrings #-}

module MisoStyle.Styles.Print
  ( renderStyles
  , renderClasses
  ) where

import           Data.Foldable             (toList)
import           Data.Maybe                (fromMaybe)
import           Data.Monoid               (mconcat)
import           Miso.String               (MisoString, pack, unpack)
import           MisoStyle.Styles.Identify (identify)
import           MisoStyle.Styles.Types    (Keyframe (..), Keyframes (..),
                                            Property (..), PseudoClass,
                                            Style (..), Styles (..))
import           Text.PrettyPrint          (Doc, braces, char, colon, punctuate,
                                            render, semi, space, text, (<+>),
                                            (<>))

className :: Style -> Doc
className a@(Animation m ss _) =
  identifier (Rule m ss (Property "animation-name" (identify a)))
className x = identifier x

identifier :: Style -> Doc
identifier = misostring . identify

misostring :: MisoString -> Doc
misostring = text . unpack

property :: Property -> Doc
property (Property p v) = misostring p <> colon <+> misostring v

properties :: [Property] -> Doc
properties = mconcat . punctuate semi . map property

pseudoClasses :: [PseudoClass] -> Doc
pseudoClasses [] = mempty
pseudoClasses ps =
  mconcat . (char ':' :) . punctuate (char ':') . map misostring $ ps

keyframe :: Keyframe -> Doc
keyframe (Keyframe s b) = misostring s <+> braces (properties b)

style :: Style -> Doc
style r@(Rule m ss p) =
  "@media" <+>
  misostring (fromMaybe "all" m) <+>
  braces (char '.' <> identifier r <> pseudoClasses ss <+> braces (property p))
style a@(Animation m ss (Keyframes ks)) =
  style (Rule m ss (Property "animation-name" (identify a))) <+>
  text "@keyframes" <+> identifier a <+> braces (mconcat (map keyframe ks))

renderStyles :: Styles -> MisoString
renderStyles =
  pack . render . mconcat . punctuate space . map style . toList . unStyles

renderClasses :: Styles -> MisoString
renderClasses =
  pack . render . mconcat . punctuate space . map className . toList . unStyles
