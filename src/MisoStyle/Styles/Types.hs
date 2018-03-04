module MisoStyle.Styles.Types
  ( Keyframe(..)
  , Property(..)
  , Keyframes(..)
  , MediaScope
  , PseudoClass
  , Style(..)
  , Styles(..)
  , AcceptsProperty
  , StyleBuilder
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
import           Data.Hashable              (Hashable, hash, hashWithSalt)
import           Data.IntMap                (IntMap, insert)
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
  { unStyles :: IntMap Style
  } deriving (Show, Eq, Ord)

insertStyle :: Style -> Styles -> Styles
insertStyle s (Styles ss) = Styles (insert (hash s) s ss)

instance Hashable Property where
  hashWithSalt s (Property p v) =
    s `hashWithSalt` unpack p `hashWithSalt` unpack v

instance Hashable Keyframe where
  hashWithSalt s (Keyframe stop b) =
    s `hashWithSalt` unpack stop `hashWithSalt` b

instance Hashable Keyframes where
  hashWithSalt s (Keyframes ks) = hashWithSalt s ks

instance Hashable Style where
  hashWithSalt s (Rule m ss p) =
    s `hashWithSalt` (unpack <$> m) `hashWithSalt` (unpack <$> ss) `hashWithSalt`
    p
  hashWithSalt s (Animation m ss ks) =
    s `hashWithSalt` (unpack <$> m) `hashWithSalt` (unpack <$> ss) `hashWithSalt`
    ks

instance Monoid Styles where
  mempty = Styles mempty
  mappend (Styles a) (Styles b) = Styles (a <> b)

class AcceptsProperty s where
  addProperty :: MediaScope -> [PseudoClass] -> Property -> s -> s

instance AcceptsProperty Keyframe where
  addProperty _ _ p (Keyframe s ps) = Keyframe s (ps ++ [p])

instance AcceptsProperty Styles where
  addProperty m ss p = insertStyle (Rule m ss p)

type StyleBuilder s = ReaderT (MediaScope, [PseudoClass]) (State s) ()

type AnimationStyleBuilder = Writer [Keyframe] ()

property :: AcceptsProperty s => MisoString -> MisoString -> StyleBuilder s
property p v = do
  (m, ss) <- ask
  lift (modify (addProperty m ss (Property p v)))

keyframe :: MisoString -> StyleBuilder Keyframe -> AnimationStyleBuilder
keyframe stop = tell . pure . runStyleBuilder Nothing [] (Keyframe stop [])

animation :: AnimationStyleBuilder -> StyleBuilder Styles
animation builder = do
  (m, ss) <- ask
  lift $ do
    s <- get
    put (insertStyle (Animation m ss (Keyframes (execWriter builder))) s)

runStyleBuilder :: MediaScope -> [PseudoClass] -> s -> StyleBuilder s -> s
runStyleBuilder m ss s builder = execState (runReaderT builder (m, ss)) s

styles :: StyleBuilder Styles -> Styles
styles = runStyleBuilder Nothing [] mempty

atmedia :: MisoString -> StyleBuilder Styles -> StyleBuilder Styles
atmedia = local . first . const . Just

pseudo :: MisoString -> StyleBuilder Styles -> StyleBuilder Styles
pseudo = local . second . (++) . pure
