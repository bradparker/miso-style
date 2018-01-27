{-# LANGUAGE OverloadedStrings #-}

module MisoStyle.Styles
  ( Styles
  , property
  , animation
  , animationIterationCount
  , animationDuration
  , atmedia
  , styles
  , color
  , backgroundColor
  , hover
  , keyframe
  , renderClasses
  , renderStyles
  ) where

import           Miso.String            (MisoString)
import           MisoStyle.Styles.Print (renderClasses, renderStyles)
import           MisoStyle.Styles.Types (AcceptsProperty, Builder, Styles,
                                         animation, atmedia, hover, keyframe,
                                         property, styles)

color :: AcceptsProperty s => MisoString -> Builder s
color = property "color"

backgroundColor :: AcceptsProperty s => MisoString -> Builder s
backgroundColor = property "background-color"

animationDuration :: AcceptsProperty s => MisoString -> Builder s
animationDuration = property "animation-duration"

animationIterationCount :: AcceptsProperty s => MisoString -> Builder s
animationIterationCount = property "animation-iteration-count"
