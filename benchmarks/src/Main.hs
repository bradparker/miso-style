{-# LANGUAGE OverloadedStrings #-}

module Main
  ( main
  ) where

import           Control.Monad.Trans.Writer (execWriter)
import           Data.Foldable              (foldr)
import           Example                    (Model (Model), generateRows, view)
import           Miso.String                (MisoString)
import           MisoStyle.Styles.Print     (renderStyles)
import           MisoStyle.Styles.Types     (Style, Styles (..))

foreign import javascript "console.profile($1);" startProfile ::
               MisoString -> IO ()

foreign import javascript "console.profileEnd($1);" stopProfile ::
               MisoString -> IO ()

profile :: MisoString -> IO () -> IO ()
profile name action = startProfile name *> action *> stopProfile name

main :: IO ()
main = do
  rows <- generateRows 10000
  profile "1000" $ print (execWriter (view (Model (take 1000 rows))))
  profile "10000" $ print (execWriter (view (Model rows)))
  profile "10000 Rendered" $
    print (renderStyles $ execWriter (view (Model rows)))
