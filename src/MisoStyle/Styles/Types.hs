{-# LANGUAGE OverloadedStrings #-}

module MisoStyle.Styles.Types
  ( Keyframe(..)
  , Property(..)
  , Keyframes(..)
  , MediaScope
  , PseudoSelector
  , Style(..)
  , Styles(..)
  , keyframe
  , animation
  , styles
  , atmedia
  , pseudo
  , hover
  , property
  ) where

import           Control.Lens               (over, _1, _2)
import           Control.Monad.Trans.Class  (lift)
import           Control.Monad.Trans.Reader (ReaderT, ask, local, runReaderT)
import           Control.Monad.Trans.State  (State, execState, get, modify, put)
import           Data.Hashable              (Hashable, hashWithSalt)
import           Data.Monoid                ((<>))
import           Data.Set                   (Set, insert)
import           Miso.String                (MisoString, unpack)

data Keyframe =
  Keyframe MisoString
           [Property]
  deriving (Show, Eq, Ord)

data Property =
  Property MisoString
           MisoString
  deriving (Show, Eq, Ord)

newtype Keyframes =
  Keyframes [Keyframe]
  deriving (Show, Eq, Ord)

type MediaScope = Maybe MisoString

type PseudoSelector = MisoString

data Style
  = Rule MediaScope
         [PseudoSelector]
         Property
  | Animation MediaScope
              [PseudoSelector]
              Keyframes
  deriving (Show, Eq, Ord)

newtype Styles = Styles
  { unStyles :: Set Style
  } deriving (Show, Eq, Ord)

instance Hashable Property where
  hashWithSalt s (Property p v) = hashWithSalt s (unpack p, unpack v)

instance Hashable Keyframe where
  hashWithSalt s (Keyframe stop b) = hashWithSalt s (unpack stop, b)

instance Hashable Keyframes where
  hashWithSalt s (Keyframes ks) = hashWithSalt s ks

instance Hashable Style where
  hashWithSalt s (Rule m ss p) = hashWithSalt s (unpack <$> m, unpack <$> ss, p)
  hashWithSalt s (Animation m ss ks) =
    hashWithSalt s (unpack <$> m, unpack <$> ss, ks)

instance Monoid Styles where
  mempty = Styles mempty
  mappend (Styles a) (Styles b) = Styles (a <> b)

class AcceptsProperty s where
  addProperty :: MediaScope -> [PseudoSelector] -> Property -> s -> s

instance AcceptsProperty Keyframe where
  addProperty _ _ p (Keyframe s ps) = Keyframe s (ps ++ [p])

instance AcceptsProperty Styles where
  addProperty m ss p (Styles s) = Styles (insert (Rule m ss p) s)

type Builder s
   = ReaderT ( MediaScope
             , [PseudoSelector]
             , MediaScope -> [PseudoSelector] -> Property -> s -> s) (State s) ()

property :: MisoString -> MisoString -> Builder s
property p v = do
  (m, ss, addProp) <- ask
  lift (modify (addProp m ss (Property p v)))

keyframe :: MisoString -> Builder Keyframe -> Keyframe
keyframe stop = runBuilder Nothing [] (Keyframe stop [])

animation :: [Keyframe] -> Builder Styles
animation ks = do
  (m, ss, _) <- ask
  (Styles s) <- lift get
  lift (put (Styles (insert (Animation m ss (Keyframes ks)) s)))

runBuilder ::
     AcceptsProperty s => MediaScope -> [PseudoSelector] -> s -> Builder s -> s
runBuilder m ss s builder =
  execState (runReaderT builder (m, ss, addProperty)) s

styles :: Builder Styles -> Styles
styles = runBuilder Nothing [] mempty

atmedia :: MisoString -> Builder Styles -> Builder Styles
atmedia = local . over _1 . const . Just

pseudo :: MisoString -> Builder Styles -> Builder Styles
pseudo = local . over _2 . (++) . pure

hover :: Builder Styles -> Builder Styles
hover = pseudo "hover"
