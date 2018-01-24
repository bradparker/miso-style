{-# LANGUAGE LambdaCase #-}

module MisoStyle.Styles.Types
  ( Styles
  , KeyFrame(..)
  , Style(..)
  , rule
  , animation
  , keyframe
  , stylesheet
  , atmedia
  , declarations
  ) where

import           Data.Hashable (Hashable, hashWithSalt)
import           Data.Set      (Set, fromList)
import           Miso.String   (MisoString, unpack)

data KeyFrame =
  KeyFrame MisoString
           [Style]
  deriving (Show, Eq, Ord)

data Style
  = Declaration MisoString
                MisoString
  | Animation [KeyFrame]
  | AtMedia MisoString
            Style
  deriving (Show, Eq, Ord)

type Styles = Set Style

instance Hashable KeyFrame where
  hashWithSalt s (KeyFrame stop b) = hashWithSalt s (unpack stop, b)

instance Hashable Style where
  hashWithSalt s (Declaration p v)     = hashWithSalt s (unpack p, unpack v)
  hashWithSalt s (Animation ks)        = hashWithSalt s ks
  hashWithSalt s (AtMedia media style) = hashWithSalt s (unpack media, style)

stylesheet :: [[Style]] -> Styles
stylesheet = fromList . concat

rule :: MisoString -> MisoString -> [Style]
rule p v = pure (Declaration p v)

keyframe :: MisoString -> [[Style]] -> KeyFrame
keyframe s ds = KeyFrame s (concat ds)

animation :: [KeyFrame] -> [Style]
animation ks = pure (Animation ks)

atmedia :: MisoString -> [[Style]] -> [Style]
atmedia m = map (AtMedia m) . concat

declarations :: [Style] -> [Style]
declarations ss =
  (\case
     d@Declaration {} -> [d]
     _ -> []) =<<
  ss
