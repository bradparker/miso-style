module Main
  ( main
  ) where

import           Data.Monoid ((<>))
import           Miso        (App (..), Effect, View, defaultEvents, div_,
                              noEff, startApp)
import           Miso.String (MisoString)
import           MisoStyle   (StyledView, Styles, animation, animationDuration,
                              animationIterationCount, atmedia, backgroundColor,
                              borderRadius, color, fontFamily, keyframe,
                              opacity, padding, styled, styledView, styles,
                              text)

helloStyles :: Styles
helloStyles =
  styles $ do
    backgroundColor "coral"
    borderRadius "0.5rem"
    color "white"
    fontFamily "sans-serif"
    padding "1rem"
    animationDuration "2s"
    animationIterationCount "infinite"
    animation $ do
      keyframe "0%" (opacity "0.5")
      keyframe "100%" (opacity "1")
    atmedia "screen and (min-width: 400px)" (backgroundColor "seagreen")

hello :: MisoString -> StyledView ()
hello name = styled div_ helloStyles [] [text ("Hello, " <> name <> "!")]

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
