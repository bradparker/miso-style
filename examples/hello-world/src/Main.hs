{-# LANGUAGE OverloadedStrings #-}

module Main
  ( main
  ) where

import           Data.Monoid ((<>))
import           Miso        (App (..), Effect, View, defaultEvents, div_,
                              noEff, startApp)
import           Miso.String (MisoString)
import           MisoStyle   (StyledView, Styles, animation, animationDuration,
                              animationIterationCount, atmedia, backgroundColor,
                              base, borderRadius, color, keyframe, opacity,
                              padding, styledView, styles, text)

helloStyles :: Styles
helloStyles =
  styles $ do
    color "white"
    padding "1rem"
    borderRadius "1rem"
    backgroundColor "coral"
    animationDuration "2s"
    animationIterationCount "infinite"
    animation $ do
      keyframe "0%" (opacity "0.5")
      keyframe "100%" (opacity "1")
    atmedia "screen and (min-width: 400px)" (backgroundColor "seagreen")

hello :: MisoString -> StyledView ()
hello name = base div_ helloStyles [] [text ("Hello, " <> name <> "!")]

initialModel :: MisoString
initialModel = "World"

updateModel :: () -> MisoString -> Effect () MisoString
updateModel = const noEff

app :: MisoString -> View ()
app = styledView hello

main :: IO ()
main =
  startApp
    App
    { initialAction = ()
    , model = initialModel
    , update = updateModel
    , view = app
    , events = defaultEvents
    , subs = []
    , mountPoint = Nothing
    }
