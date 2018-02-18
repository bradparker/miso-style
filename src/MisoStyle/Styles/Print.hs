module MisoStyle.Styles.Print
  ( renderStyles
  , renderClasses
  ) where

import           Data.Foldable          (foldr)
import           Data.IntMap            (IntMap, Key, foldrWithKey, insert)
import           Data.List              (intersperse)
import           Data.Maybe             (fromMaybe)
import           Data.Monoid            (mconcat, (<>))
import           Miso.String            (MisoString, toMisoString)
import           MisoStyle.Styles.Types (Keyframe (..), Keyframes (..),
                                         Property (..), PseudoClass, Style (..),
                                         Styles (..))

toIntMap :: Styles -> IntMap Style
toIntMap = foldr (uncurry insert) mempty . unStyles

(<+>) :: MisoString -> MisoString -> MisoString
a <+> b = a <> space <> b

space :: MisoString
space = " "

colon :: MisoString
colon = ":"

semi :: MisoString
semi = ";"

braces :: MisoString -> MisoString
braces b = "{" <> b <> "}"

punctuate :: MisoString -> [MisoString] -> MisoString
punctuate b = mconcat . intersperse b

identifier :: Key -> MisoString
identifier = ("m" <>) . toMisoString . show

property :: Property -> MisoString
property (Property p v) = p <> colon <+> v

properties :: [Property] -> MisoString
properties = punctuate semi . map property

pseudoClasses :: [PseudoClass] -> MisoString
pseudoClasses [] = mempty
pseudoClasses ps = colon <> punctuate colon ps

keyframe :: Keyframe -> MisoString
keyframe (Keyframe s b) = s <+> braces (properties b)

style :: Key -> Style -> MisoString
style k (Rule m ss p) =
  "@media" <+>
  fromMaybe "all" m <+>
  braces ("." <> identifier k <> pseudoClasses ss <+> braces (property p))
style k (Animation m ss (Keyframes ks)) =
  style k (Rule m ss (Property "animation-name" (identifier k))) <+>
  "@keyframes" <+> identifier k <+> braces (mconcat (map keyframe ks))

renderStyles :: Styles -> MisoString
renderStyles =
  foldrWithKey (\key val acc -> style key val <+> acc) "" . toIntMap

renderClasses :: Styles -> MisoString
renderClasses = foldr ((<+>) . identifier . fst) "" . unStyles
