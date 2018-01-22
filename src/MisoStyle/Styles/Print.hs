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
import           MisoStyle.Styles.Types    (Animation (..), Declaration (..),
                                            KeyFrame (..),
                                            MediaScopedAnimation (..),
                                            MediaScopedDeclaration (..),
                                            Style (..), Styles)
import           Text.PrettyPrint          (Doc, braces, char, colon, punctuate,
                                            render, semi, space, text, (<+>),
                                            (<>))

classes :: Style -> Doc
classes a@(A (Animation _)) =
  identifier (D (Declaration "animation-name" (identify a)))
classes ma@(MA (MediaScopedAnimation m _)) =
  identifier
    (MD (MediaScopedDeclaration m (Declaration "animation-name" (identify ma))))
classes x = identifier x

identifier :: Style -> Doc
identifier = misostring . identify

misostring :: MisoString -> Doc
misostring = text . unpack

declaration :: Declaration -> Doc
declaration (Declaration p v) = misostring p <> colon <+> misostring v

ruleset :: [Declaration] -> Doc
ruleset = mconcat . punctuate semi . map declaration

keyframe :: KeyFrame -> Doc
keyframe (KeyFrame s b) = misostring s <+> braces (ruleset b)

style :: Style -> Doc
style d@(D dec) = char '.' <> identifier d <+> braces (declaration dec)
style md@(MD (MediaScopedDeclaration m d)) =
  "@media" <+>
  misostring m <+> braces (char '.' <> identifier md <+> braces (declaration d))
style a@(A (Animation ks)) =
  style (D (Declaration "animation-name" (identify a))) <+>
  text "@keyframes" <+> identifier a <+> braces (mconcat (map keyframe ks))
style ma@(MA (MediaScopedAnimation m (Animation ks))) =
  style
    (MD (MediaScopedDeclaration m (Declaration "animation-name" (identify ma)))) <+>
  text "@keyframes" <+> identifier ma <+> braces (mconcat (map keyframe ks))

renderStyles :: Styles -> MisoString
renderStyles = pack . render . mconcat . punctuate space . map style . toList

renderClasses :: Styles -> MisoString
renderClasses = pack . render . mconcat . punctuate space . map classes . toList
