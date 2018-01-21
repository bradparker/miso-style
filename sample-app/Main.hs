module Main
  ( main
  ) where

import qualified App  as MyApp
import           Miso (App (..), defaultEvents, startApp)

main :: IO ()
main =
  startApp
    App
    { initialAction = MyApp.initialAction
    , model = MyApp.initialModel
    , update = MyApp.update
    , view = MyApp.view
    , events = defaultEvents
    , subs = MyApp.subs
    , mountPoint = Nothing
    }
