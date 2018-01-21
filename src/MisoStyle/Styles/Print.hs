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
import           MisoStyle.Styles.Types    (Declaration (..), KeyFrame (..),
                                            Style (..), Styles)
import           Text.PrettyPrint          (Doc, braces, char, colon, punctuate,
                                            render, semi, space, text, (<+>),
                                            (<>))

classes :: Style -> Doc
classes a@Animation {} =
  identifier a <+>
  identifier (Rule Nothing (Declaration "animation-name" (identify a)))
classes x = identifier x

identifier :: Style -> Doc
identifier = misostring . identify

misostring :: MisoString -> Doc
misostring = text . unpack

declaration :: Declaration -> Doc
declaration d = misostring (property d) <> colon <+> misostring (value d)

ruleset :: [Declaration] -> Doc
ruleset = mconcat . punctuate semi . map declaration

keyframe :: KeyFrame -> Doc
keyframe (KeyFrame s b) = misostring s <+> braces (ruleset b)

media :: Maybe MisoString -> Doc
media = misostring . fromMaybe "all"

topLevel :: Style -> Doc
topLevel a@(Animation ks) =
  topLevel (Rule Nothing (Declaration "animation-name" (identify a))) <+>
  text "@keyframes" <+> identifier a <+> braces (mconcat (map keyframe ks))
topLevel r@(Rule p d) =
  "@media" <+>
  media p <+> braces (char '.' <> identifier r <+> braces (declaration d))

renderStyles :: Styles -> MisoString
renderStyles = pack . render . mconcat . punctuate space . map topLevel . toList

renderClasses :: Styles -> MisoString
renderClasses = pack . render . mconcat . punctuate space . map classes . toList
