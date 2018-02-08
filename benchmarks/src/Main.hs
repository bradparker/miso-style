{-# LANGUAGE OverloadedStrings #-}

module Main
  ( main
  ) where

import           Control.Monad.Trans.Writer (execWriter)
import           Data.Foldable              (foldr)
import           Data.Set                   (Set, insert)
import           Example                    (Model (Model), generateRows, view)
import           Miso.String                (MisoString)
import           MisoStyle.Styles.Types     (Style, Styles (..))

foreign import javascript "console.profile($1);" startProfile ::
               MisoString -> IO ()

foreign import javascript "console.profileEnd($1);" stopProfile ::
               MisoString -> IO ()

profile :: MisoString -> IO () -> IO ()
profile name action = startProfile name *> action *> stopProfile name

toSet :: Styles -> Set Style
toSet = foldr insert mempty . unStyles

main :: IO ()
main = do
  rows <- generateRows 10000
  profile "1000" $ print (toSet $ execWriter (view (Model (take 1000 rows))))
  profile "10000" $ print (toSet $ execWriter (view (Model rows)))
