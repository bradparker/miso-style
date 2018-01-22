{-# LANGUAGE LambdaCase #-}

module MisoStyle.Styles.Types
  ( Styles
  , Declaration(..)
  , MediaScopedDeclaration(..)
  , KeyFrame(..)
  , Animation(..)
  , MediaScopedAnimation(..)
  , Style(..)
  , rule
  , animation
  , keyframe
  , stylesheet
  , atmedia
  ) where

import           Data.Hashable (Hashable, hashWithSalt)
import           Data.Monoid   (mconcat, mempty)
import           Data.Set      (Set, fromList, singleton, toList)
import           Miso.String   (MisoString, unpack)

data Declaration =
  Declaration MisoString
              MisoString
  deriving (Show, Eq, Ord)

data MediaScopedDeclaration =
  MediaScopedDeclaration MisoString
                         Declaration
  deriving (Show, Eq, Ord)

data KeyFrame =
  KeyFrame MisoString
           [Declaration]
  deriving (Show, Eq, Ord)

data Animation =
  Animation [KeyFrame]
  deriving (Show, Eq, Ord)

data MediaScopedAnimation =
  MediaScopedAnimation MisoString
                       Animation
  deriving (Show, Eq, Ord)

data Style
  = A Animation
  | D Declaration
  | MA MediaScopedAnimation
  | MD MediaScopedDeclaration
  deriving (Show, Eq, Ord)

type Styles = Set Style

instance Hashable Declaration where
  hashWithSalt s (Declaration p v) = hashWithSalt s (unpack p, unpack v)

instance Hashable MediaScopedDeclaration where
  hashWithSalt s (MediaScopedDeclaration m d) = hashWithSalt s (unpack m, d)

instance Hashable KeyFrame where
  hashWithSalt s (KeyFrame stop b) = hashWithSalt s (unpack stop, b)

instance Hashable Animation where
  hashWithSalt s (Animation ks) = hashWithSalt s ks

instance Hashable MediaScopedAnimation where
  hashWithSalt s (MediaScopedAnimation m a) = hashWithSalt s (unpack m, a)

instance Hashable Style where
  hashWithSalt s (A a)   = hashWithSalt s a
  hashWithSalt s (MA ma) = hashWithSalt s ma
  hashWithSalt s (D d)   = hashWithSalt s d
  hashWithSalt s (MD md) = hashWithSalt s md

declarations :: [Style] -> [Declaration]
declarations =
  map (\(D d) -> d) .
  filter
    (\case
       D d -> True
       _ -> False)

stylesheet :: [Styles] -> Styles
stylesheet = mconcat

rule :: MisoString -> MisoString -> Styles
rule p v = singleton (D (Declaration p v))

keyframe :: MisoString -> [Styles] -> KeyFrame
keyframe s ds = KeyFrame s (declarations (toList (mconcat ds)))

animation :: [KeyFrame] -> Styles
animation ks = singleton (A (Animation ks))

atmedia :: MisoString -> [Styles] -> Styles
atmedia m =
  foldMap
    (\case
       D (Declaration p v) ->
         singleton (MD (MediaScopedDeclaration m (Declaration p v)))
       MD (MediaScopedDeclaration _ _) -> mempty
       A (Animation ks) ->
         singleton (MA (MediaScopedAnimation m (Animation ks)))
       MA (MediaScopedAnimation _ _) -> mempty) .
  toList . mconcat
