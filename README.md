# Miso Styling Experiment

*N.B.* at this point this is for my own curiousity and learning.

CSS in JS in the style of Fela and Aphrodite, but in Haskell and specifically for the Miso framework.

## Usage

The `MisoStyle` module exports a function called `styled` it wraps existing Miso element functions so that they become "style-aware". Elements wrapped by styled take an extra arg, a `Styles` value, which is a set of CSS rules you'd like to apply to this element.

It looks like this:

```haskell
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
                              styled, borderRadius, color, keyframe, opacity,
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
```

## Development

### System requirements

* Nix
* Cabal (`nix-env -i cabal-install`)

### Running the tests

```
 » nix-shell -A env --run "cabal test --show-details=always"
```

### Viewing the sample app

```
 » cd examples/hello-world
 » nix-shell -A env --run "cabal build"
 » cd dist/build/hello-world/hello-world.jsexe/
 » python -m SimpleHTTPServer
```
