module MisoStyle.Styles.Types
  ( Styles
  , Declaration(..)
  , KeyFrame(..)
  , Style(..)
  , rule
  , animation
  , stylesheet
  , atmedia
  ) where

import           Control.Arrow (second, (&&&))
import           Data.Hashable (Hashable, hashWithSalt)
import           Data.Monoid   (mconcat)
import           Data.Set      (Set, fromList, singleton)
import           Miso.String   (MisoString, unpack)

data Declaration = Declaration
  { property :: MisoString
  , value    :: MisoString
  } deriving (Show, Eq, Ord)

data KeyFrame = KeyFrame
  { stop  :: MisoString
  , block :: [Declaration]
  } deriving (Show, Eq, Ord)

type MediaQuery = Maybe MisoString

data Style
  = Rule MediaQuery
         Declaration
  | Animation { keyframes :: [KeyFrame] }
  deriving (Show, Eq, Ord)

type Styles = Set Style

instance Hashable Declaration where
  hashWithSalt s = hashWithSalt s . (unpack . property &&& unpack . value)

instance Hashable KeyFrame where
  hashWithSalt s = hashWithSalt s . (unpack . stop &&& block)

instance Hashable Style where
  hashWithSalt s (Rule p d)    = hashWithSalt s (unpack <$> p, d)
  hashWithSalt s (Animation k) = hashWithSalt s k

stylesheet :: [Styles] -> Styles
stylesheet = mconcat

rule :: (MisoString, MisoString) -> Styles
rule (p, v) = singleton (Rule Nothing (Declaration p v))

animation :: [(MisoString, [(MisoString, MisoString)])] -> Styles
animation frames =
  singleton
    (Animation
       (map (uncurry KeyFrame . second (map (uncurry Declaration))) frames))

atmedia :: (MisoString, [(MisoString, MisoString)]) -> Styles
atmedia (m, rs) = fromList (map (\(p, v) -> Rule (Just m) (Declaration p v)) rs)
