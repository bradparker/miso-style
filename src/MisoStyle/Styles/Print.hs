{-# LANGUAGE OverloadedStrings #-}

module MisoStyle.Styles.Print
  ( renderStyles
  , renderClasses
  ) where

import           Data.Foldable             (toList)
import           Data.Monoid               (mconcat)
import           Miso.String               (MisoString, pack, unpack)
import           MisoStyle.Styles.Identify (identify)
import           MisoStyle.Styles.Types    (KeyFrame (..), Style (..), Styles,
                                            declarations)
import           Text.PrettyPrint          (Doc, braces, char, colon, punctuate,
                                            render, semi, space, text, (<+>),
                                            (<>))

classes :: Style -> Doc
classes a@Animation {} = identifier (Declaration "animation-name" (identify a))
classes ma@(AtMedia m Animation {}) =
  identifier (AtMedia m (Declaration "animation-name" (identify ma)))
classes x = identifier x

identifier :: Style -> Doc
identifier = misostring . identify

misostring :: MisoString -> Doc
misostring = text . unpack

declaration :: Style -> Doc
declaration (Declaration p v) = misostring p <> colon <+> misostring v
declaration _                 = mempty

ruleset :: [Style] -> Doc
ruleset = mconcat . punctuate semi . map declaration

keyframe :: KeyFrame -> Doc
keyframe (KeyFrame s b) = misostring s <+> braces (ruleset (declarations b))

style :: Style -> Doc
style d@Declaration {} = char '.' <> identifier d <+> braces (declaration d)
style md@(AtMedia m d@Declaration {}) =
  "@media" <+>
  misostring m <+> braces (char '.' <> identifier md <+> braces (declaration d))
style a@(Animation ks) =
  style (Declaration "animation-name" (identify a)) <+>
  text "@keyframes" <+> identifier a <+> braces (mconcat (map keyframe ks))
style ma@(AtMedia m (Animation ks)) =
  style (AtMedia m (Declaration "animation-name" (identify ma))) <+>
  text "@keyframes" <+> identifier ma <+> braces (mconcat (map keyframe ks))
style _ = mempty

renderStyles :: Styles -> MisoString
renderStyles = pack . render . mconcat . punctuate space . map style . toList

renderClasses :: Styles -> MisoString
renderClasses = pack . render . mconcat . punctuate space . map classes . toList
