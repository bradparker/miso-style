# Miso Styling Experiment

*N.B.* at this point this is for my own curiousity and learning.

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
  ( StyledView
  , Styles
  , animation
  , animationDuration
  , animationIterationCount
  , atmedia
  , backgroundColor
  , base
  , borderRadius
  , color
  , keyframe
  , opacity
  , padding
  , styles
  , text
  )

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
hello name =
  base div_ helloStyles [] [text ("Hello, " <> name <> "!")]
```
