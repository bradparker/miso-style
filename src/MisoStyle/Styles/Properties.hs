{-# LANGUAGE NoImplicitPrelude #-}

module MisoStyle.Styles.Properties
  ( animationDelay
  , animationDirection
  , animationDuration
  , animationFillMode
  , animationIterationCount
  , animationPlayState
  , animationTimingFunction
  , background
  , backgroundAttachment
  , backgroundColor
  , backgroundImage
  , backgroundPosition
  , backgroundRepeat
  , border
  , borderBottom
  , borderBottomColor
  , borderBottomStyle
  , borderBottomWidth
  , borderColor
  , borderLeft
  , borderLeftColor
  , borderLeftStyle
  , borderLeftWidth
  , borderRadius
  , borderRight
  , borderRightColor
  , borderRightStyle
  , borderRightWidth
  , borderStyle
  , borderTop
  , borderTopColor
  , borderTopStyle
  , borderTopWidth
  , borderWidth
  , clear
  , clip
  , color
  , cursor
  , display
  , filter
  , float
  , font
  , fontFamily
  , fontSize
  , fontVariant
  , fontWeight
  , height
  , left
  , letterSpacing
  , lineHeight
  , listStyle
  , listStyleImage
  , listStylePosition
  , listStyleType
  , margin
  , marginBottom
  , marginLeft
  , marginRight
  , marginTop
  , opacity
  , overflow
  , padding
  , paddingBottom
  , paddingLeft
  , paddingRight
  , paddingTop
  , pageBreakAfter
  , pageBreakBefore
  , position
  , strokeDasharray
  , strokeDashoffset
  , strokeWidth
  , textAlign
  , textDecoration
  , textIndent
  , textTransform
  , top
  , verticalAlign
  , visibility
  , width
  , zIndex
  ) where

import           Miso.String            (MisoString)
import           MisoStyle.Styles.Types (AcceptsProperty, StyleBuilder,
                                         property)

animationDelay :: AcceptsProperty s => MisoString -> StyleBuilder s
animationDelay = property "animation-delay"

animationDirection :: AcceptsProperty s => MisoString -> StyleBuilder s
animationDirection = property "animation-direction"

animationDuration :: AcceptsProperty s => MisoString -> StyleBuilder s
animationDuration = property "animation-duration"

animationFillMode :: AcceptsProperty s => MisoString -> StyleBuilder s
animationFillMode = property "animation-fill-mode"

animationIterationCount :: AcceptsProperty s => MisoString -> StyleBuilder s
animationIterationCount = property "animation-iteration-count"

animationPlayState :: AcceptsProperty s => MisoString -> StyleBuilder s
animationPlayState = property "animation-play-state"

animationTimingFunction :: AcceptsProperty s => MisoString -> StyleBuilder s
animationTimingFunction = property "animation-timing-function"

background :: AcceptsProperty s => MisoString -> StyleBuilder s
background = property "background"

backgroundAttachment :: AcceptsProperty s => MisoString -> StyleBuilder s
backgroundAttachment = property "background-attachment"

backgroundColor :: AcceptsProperty s => MisoString -> StyleBuilder s
backgroundColor = property "background-color"

backgroundImage :: AcceptsProperty s => MisoString -> StyleBuilder s
backgroundImage = property "background-image"

backgroundPosition :: AcceptsProperty s => MisoString -> StyleBuilder s
backgroundPosition = property "background-position"

backgroundRepeat :: AcceptsProperty s => MisoString -> StyleBuilder s
backgroundRepeat = property "background-repeat"

border :: AcceptsProperty s => MisoString -> StyleBuilder s
border = property "border"

borderBottom :: AcceptsProperty s => MisoString -> StyleBuilder s
borderBottom = property "border-bottom"

borderBottomColor :: AcceptsProperty s => MisoString -> StyleBuilder s
borderBottomColor = property "border-bottom-color"

borderBottomStyle :: AcceptsProperty s => MisoString -> StyleBuilder s
borderBottomStyle = property "border-bottom-style"

borderBottomWidth :: AcceptsProperty s => MisoString -> StyleBuilder s
borderBottomWidth = property "border-bottom-width"

borderColor :: AcceptsProperty s => MisoString -> StyleBuilder s
borderColor = property "border-color"

borderLeft :: AcceptsProperty s => MisoString -> StyleBuilder s
borderLeft = property "border-left"

borderLeftColor :: AcceptsProperty s => MisoString -> StyleBuilder s
borderLeftColor = property "border-left-color"

borderLeftStyle :: AcceptsProperty s => MisoString -> StyleBuilder s
borderLeftStyle = property "border-left-style"

borderLeftWidth :: AcceptsProperty s => MisoString -> StyleBuilder s
borderLeftWidth = property "border-left-width"

borderRadius :: AcceptsProperty s => MisoString -> StyleBuilder s
borderRadius = property "border-radius"

borderRight :: AcceptsProperty s => MisoString -> StyleBuilder s
borderRight = property "border-right"

borderRightColor :: AcceptsProperty s => MisoString -> StyleBuilder s
borderRightColor = property "border-right-color"

borderRightStyle :: AcceptsProperty s => MisoString -> StyleBuilder s
borderRightStyle = property "border-right-style"

borderRightWidth :: AcceptsProperty s => MisoString -> StyleBuilder s
borderRightWidth = property "border-right-width"

borderStyle :: AcceptsProperty s => MisoString -> StyleBuilder s
borderStyle = property "border-style"

borderTop :: AcceptsProperty s => MisoString -> StyleBuilder s
borderTop = property "border-top"

borderTopColor :: AcceptsProperty s => MisoString -> StyleBuilder s
borderTopColor = property "border-top-color"

borderTopStyle :: AcceptsProperty s => MisoString -> StyleBuilder s
borderTopStyle = property "border-top-style"

borderTopWidth :: AcceptsProperty s => MisoString -> StyleBuilder s
borderTopWidth = property "border-top-width"

borderWidth :: AcceptsProperty s => MisoString -> StyleBuilder s
borderWidth = property "border-width"

clear :: AcceptsProperty s => MisoString -> StyleBuilder s
clear = property "clear"

clip :: AcceptsProperty s => MisoString -> StyleBuilder s
clip = property "clip"

color :: AcceptsProperty s => MisoString -> StyleBuilder s
color = property "color"

cursor :: AcceptsProperty s => MisoString -> StyleBuilder s
cursor = property "cursor"

display :: AcceptsProperty s => MisoString -> StyleBuilder s
display = property "display"

filter :: AcceptsProperty s => MisoString -> StyleBuilder s
filter = property "filter"

float :: AcceptsProperty s => MisoString -> StyleBuilder s
float = property "float"

font :: AcceptsProperty s => MisoString -> StyleBuilder s
font = property "font"

fontFamily :: AcceptsProperty s => MisoString -> StyleBuilder s
fontFamily = property "font-family"

fontSize :: AcceptsProperty s => MisoString -> StyleBuilder s
fontSize = property "font-size"

fontVariant :: AcceptsProperty s => MisoString -> StyleBuilder s
fontVariant = property "font-variant"

fontWeight :: AcceptsProperty s => MisoString -> StyleBuilder s
fontWeight = property "font-weight"

height :: AcceptsProperty s => MisoString -> StyleBuilder s
height = property "height"

left :: AcceptsProperty s => MisoString -> StyleBuilder s
left = property "left"

letterSpacing :: AcceptsProperty s => MisoString -> StyleBuilder s
letterSpacing = property "letter-spacing"

lineHeight :: AcceptsProperty s => MisoString -> StyleBuilder s
lineHeight = property "line-height"

listStyle :: AcceptsProperty s => MisoString -> StyleBuilder s
listStyle = property "list-style"

listStyleImage :: AcceptsProperty s => MisoString -> StyleBuilder s
listStyleImage = property "list-style-image"

listStylePosition :: AcceptsProperty s => MisoString -> StyleBuilder s
listStylePosition = property "list-style-position"

listStyleType :: AcceptsProperty s => MisoString -> StyleBuilder s
listStyleType = property "list-style-type"

margin :: AcceptsProperty s => MisoString -> StyleBuilder s
margin = property "margin"

marginBottom :: AcceptsProperty s => MisoString -> StyleBuilder s
marginBottom = property "margin-bottom"

marginLeft :: AcceptsProperty s => MisoString -> StyleBuilder s
marginLeft = property "margin-left"

marginRight :: AcceptsProperty s => MisoString -> StyleBuilder s
marginRight = property "margin-right"

marginTop :: AcceptsProperty s => MisoString -> StyleBuilder s
marginTop = property "margin-top"

opacity :: AcceptsProperty s => MisoString -> StyleBuilder s
opacity = property "opacity"

overflow :: AcceptsProperty s => MisoString -> StyleBuilder s
overflow = property "overflow"

padding :: AcceptsProperty s => MisoString -> StyleBuilder s
padding = property "padding"

paddingBottom :: AcceptsProperty s => MisoString -> StyleBuilder s
paddingBottom = property "padding-bottom"

paddingLeft :: AcceptsProperty s => MisoString -> StyleBuilder s
paddingLeft = property "padding-left"

paddingRight :: AcceptsProperty s => MisoString -> StyleBuilder s
paddingRight = property "padding-right"

paddingTop :: AcceptsProperty s => MisoString -> StyleBuilder s
paddingTop = property "padding-top"

pageBreakAfter :: AcceptsProperty s => MisoString -> StyleBuilder s
pageBreakAfter = property "page-break-after"

pageBreakBefore :: AcceptsProperty s => MisoString -> StyleBuilder s
pageBreakBefore = property "page-break-before"

position :: AcceptsProperty s => MisoString -> StyleBuilder s
position = property "position"

strokeDasharray :: AcceptsProperty s => MisoString -> StyleBuilder s
strokeDasharray = property "stroke-dasharray"

strokeDashoffset :: AcceptsProperty s => MisoString -> StyleBuilder s
strokeDashoffset = property "stroke-dashoffset"

strokeWidth :: AcceptsProperty s => MisoString -> StyleBuilder s
strokeWidth = property "stroke-width"

textAlign :: AcceptsProperty s => MisoString -> StyleBuilder s
textAlign = property "text-align"

textDecoration :: AcceptsProperty s => MisoString -> StyleBuilder s
textDecoration = property "text-decoration"

textIndent :: AcceptsProperty s => MisoString -> StyleBuilder s
textIndent = property "text-indent"

textTransform :: AcceptsProperty s => MisoString -> StyleBuilder s
textTransform = property "text-transform"

top :: AcceptsProperty s => MisoString -> StyleBuilder s
top = property "top"

verticalAlign :: AcceptsProperty s => MisoString -> StyleBuilder s
verticalAlign = property "vertical-align"

visibility :: AcceptsProperty s => MisoString -> StyleBuilder s
visibility = property "visibility"

width :: AcceptsProperty s => MisoString -> StyleBuilder s
width = property "width"

zIndex :: AcceptsProperty s => MisoString -> StyleBuilder s
zIndex = property "z-index"
