# Miso Styling Experiment

*N.B.* at this point this is for my own curiousity and learning. The api ... is a little weird and will change :).

CSS in JS in the style of Fela and Aphrodite, but in Haskell and specifically for the Miso framework.

## Usage

The `MisoStyle` module exports a function called `base` (this is a silly name) it wraps existing Miso element functions so that they become "style-aware". Elements wrapped by base take an extra arg, a `Styles` value, which is a set of CSS rules you'd like to apply to this element.

It looks like this:

```haskell
{-# LANGUAGE OverloadedStrings #-}

module Hello (hello) where

import Data.Monoid (<>)
import Miso (div_)
import MisoStyle
  ( StyledElement
  , Styles
  , animation
  , atmedia
  , base
  , keyframe
  , property
  , styles
  , text
  )

helloStyles :: Styles
helloStyles =
  styles $ do
    property "color" "white"
    property "padding" "1rem"
    property "border-raduis" "1rem"
    property "background-color" "coral"
    property "animation-duration" "2s"
    property "animation-iteration-count" "infinite"
    animation
      [ keyframe "0%" (property "opacity" "0.5")
      , keyframe "100%" (property "opacity" "1")
      ]
    atmedia
      "screen and (min-width: 400px)"
      (property "background-color" "seagreen")


hello :: MisoString -> StyledElement ()
hello name =
  base div_ helloStyles [] [text ("Hello, " <> name <> "!")]
```
