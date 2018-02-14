module MisoStyle.Styles.Types
  ( Keyframe(..)
  , Property(..)
  , Keyframes(..)
  , MediaScope
  , PseudoClass
  , Style(..)
  , Styles(..)
  , AcceptsProperty
  , Builder
  , keyframe
  , animation
  , styles
  , atmedia
  , pseudo
  , property
  ) where

import           Control.Monad.Trans.Class  (lift)
import           Control.Monad.Trans.Reader (ReaderT, ask, local, runReaderT)
import           Control.Monad.Trans.State  (State, execState, get, modify, put)
import           Control.Monad.Trans.Writer (Writer, execWriter, tell)
import           Data.Bifunctor             (first, second)
import           Data.DList                 (DList, snoc)
import           Data.Hashable              (Hashable, hash, hashWithSalt)
import           Data.IntMap                (Key)
import           Data.Monoid                ((<>))
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

type PseudoClass = MisoString

data Style
  = Rule MediaScope
         [PseudoClass]
         Property
  | Animation MediaScope
              [PseudoClass]
              Keyframes
  deriving (Show, Eq, Ord)

newtype Styles = Styles
  { unStyles :: DList (Key, Style)
  } deriving (Show, Eq, Ord)

insertStyle :: Style -> Styles -> Styles
insertStyle s (Styles ss) = Styles (snoc ss ((hash s), s))

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
  addProperty :: MediaScope -> [PseudoClass] -> Property -> s -> s

instance AcceptsProperty Keyframe where
  addProperty _ _ p (Keyframe s ps) = Keyframe s (ps ++ [p])

instance AcceptsProperty Styles where
  addProperty m ss p = insertStyle (Rule m ss p)

type Builder s = ReaderT (MediaScope, [PseudoClass]) (State s) ()

type AnimationBuilder = Writer [Keyframe] ()

property :: AcceptsProperty s => MisoString -> MisoString -> Builder s
property p v = do
  (m, ss) <- ask
  lift (modify (addProperty m ss (Property p v)))

keyframe :: MisoString -> Builder Keyframe -> AnimationBuilder
keyframe stop = tell . pure . runBuilder Nothing [] (Keyframe stop [])

animation :: AnimationBuilder -> Builder Styles
animation builder = do
  (m, ss) <- ask
  lift $ do
    s <- get
    put (insertStyle (Animation m ss (Keyframes (execWriter builder))) s)

runBuilder :: MediaScope -> [PseudoClass] -> s -> Builder s -> s
runBuilder m ss s builder = execState (runReaderT builder (m, ss)) s

styles :: Builder Styles -> Styles
styles = runBuilder Nothing [] mempty

atmedia :: MisoString -> Builder Styles -> Builder Styles
atmedia = local . first . const . Just

pseudo :: MisoString -> Builder Styles -> Builder Styles
pseudo = local . second . (++) . pure
