{-# LANGUAGE OverloadedStrings #-}

module MisoStyle.Styles.Print
  ( renderStyles
  , renderClasses
  ) where

import           Data.Foldable              (toList)
import           Data.IntMap                (Key, keys, mapWithKey)
import           Data.List                  (intersperse)
import           Data.Maybe                 (fromMaybe)
import           Data.Monoid                (mconcat, (<>))
import           Data.Text.Lazy.Builder     (Builder, fromText, singleton,
                                             toLazyText)
import           Data.Text.Lazy.Builder.Int (decimal)
import           Miso.String                (MisoString, fromMisoString,
                                             toMisoString)
import           MisoStyle.Styles.Types     (Keyframe (..), Keyframes (..),
                                             Property (..), PseudoClass,
                                             Style (..), Styles (..))

(<+>) :: Builder -> Builder -> Builder
a <+> b = a <> space <> b

space :: Builder
space = singleton ' '

colon :: Builder
colon = singleton ':'

semi :: Builder
semi = singleton ';'

braces :: Builder -> Builder
braces b = singleton '{' <> b <> singleton '}'

punctuate :: Builder -> [Builder] -> Builder
punctuate b = mconcat . intersperse b

className :: Key -> MisoString
className = toMisoString . toLazyText . identifier

identifier :: Key -> Builder
identifier = (singleton 'm' <>) . decimal

misostring :: MisoString -> Builder
misostring = fromText . fromMisoString

property :: Property -> Builder
property (Property p v) = misostring p <> colon <+> misostring v

properties :: [Property] -> Builder
properties = punctuate semi . map property

pseudoClasses :: [PseudoClass] -> Builder
pseudoClasses [] = mempty
pseudoClasses ps =
  (singleton ':' <>) . punctuate (singleton ':') . map misostring $ ps

keyframe :: Keyframe -> Builder
keyframe (Keyframe s b) = misostring s <+> braces (properties b)

style :: Key -> Style -> Builder
style k (Rule m ss p) =
  "@media" <+>
  misostring (fromMaybe "all" m) <+>
  braces
    (singleton '.' <> identifier k <> pseudoClasses ss <+> braces (property p))
style k (Animation m ss (Keyframes ks)) =
  style k (Rule m ss (Property "animation-name" (className k))) <+>
  fromText "@keyframes" <+> identifier k <+> braces (mconcat (map keyframe ks))

renderStyles :: Styles -> MisoString
renderStyles =
  toMisoString .
  toLazyText . punctuate space . toList . mapWithKey style . unStyles

renderClasses :: Styles -> MisoString
renderClasses =
  toMisoString .
  toLazyText . punctuate space . toList . map identifier . keys . unStyles
