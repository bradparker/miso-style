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
import           MisoStyle.Styles.Types (AcceptsProperty, Builder, property)

animationDelay :: AcceptsProperty s => MisoString -> Builder s
animationDelay = property "animation-delay"

animationDirection :: AcceptsProperty s => MisoString -> Builder s
animationDirection = property "animation-direction"

animationDuration :: AcceptsProperty s => MisoString -> Builder s
animationDuration = property "animation-duration"

animationFillMode :: AcceptsProperty s => MisoString -> Builder s
animationFillMode = property "animation-fill-mode"

animationIterationCount :: AcceptsProperty s => MisoString -> Builder s
animationIterationCount = property "animation-iteration-count"

animationPlayState :: AcceptsProperty s => MisoString -> Builder s
animationPlayState = property "animation-play-state"

animationTimingFunction :: AcceptsProperty s => MisoString -> Builder s
animationTimingFunction = property "animation-timing-function"

background :: AcceptsProperty s => MisoString -> Builder s
background = property "background"

backgroundAttachment :: AcceptsProperty s => MisoString -> Builder s
backgroundAttachment = property "background-attachment"

backgroundColor :: AcceptsProperty s => MisoString -> Builder s
backgroundColor = property "background-color"

backgroundImage :: AcceptsProperty s => MisoString -> Builder s
backgroundImage = property "background-image"

backgroundPosition :: AcceptsProperty s => MisoString -> Builder s
backgroundPosition = property "background-position"

backgroundRepeat :: AcceptsProperty s => MisoString -> Builder s
backgroundRepeat = property "background-repeat"

border :: AcceptsProperty s => MisoString -> Builder s
border = property "border"

borderBottom :: AcceptsProperty s => MisoString -> Builder s
borderBottom = property "border-bottom"

borderBottomColor :: AcceptsProperty s => MisoString -> Builder s
borderBottomColor = property "border-bottom-color"

borderBottomStyle :: AcceptsProperty s => MisoString -> Builder s
borderBottomStyle = property "border-bottom-style"

borderBottomWidth :: AcceptsProperty s => MisoString -> Builder s
borderBottomWidth = property "border-bottom-width"

borderColor :: AcceptsProperty s => MisoString -> Builder s
borderColor = property "border-color"

borderLeft :: AcceptsProperty s => MisoString -> Builder s
borderLeft = property "border-left"

borderLeftColor :: AcceptsProperty s => MisoString -> Builder s
borderLeftColor = property "border-left-color"

borderLeftStyle :: AcceptsProperty s => MisoString -> Builder s
borderLeftStyle = property "border-left-style"

borderLeftWidth :: AcceptsProperty s => MisoString -> Builder s
borderLeftWidth = property "border-left-width"

borderRadius :: AcceptsProperty s => MisoString -> Builder s
borderRadius = property "border-radius"

borderRight :: AcceptsProperty s => MisoString -> Builder s
borderRight = property "border-right"

borderRightColor :: AcceptsProperty s => MisoString -> Builder s
borderRightColor = property "border-right-color"

borderRightStyle :: AcceptsProperty s => MisoString -> Builder s
borderRightStyle = property "border-right-style"

borderRightWidth :: AcceptsProperty s => MisoString -> Builder s
borderRightWidth = property "border-right-width"

borderStyle :: AcceptsProperty s => MisoString -> Builder s
borderStyle = property "border-style"

borderTop :: AcceptsProperty s => MisoString -> Builder s
borderTop = property "border-top"

borderTopColor :: AcceptsProperty s => MisoString -> Builder s
borderTopColor = property "border-top-color"

borderTopStyle :: AcceptsProperty s => MisoString -> Builder s
borderTopStyle = property "border-top-style"

borderTopWidth :: AcceptsProperty s => MisoString -> Builder s
borderTopWidth = property "border-top-width"

borderWidth :: AcceptsProperty s => MisoString -> Builder s
borderWidth = property "border-width"

clear :: AcceptsProperty s => MisoString -> Builder s
clear = property "clear"

clip :: AcceptsProperty s => MisoString -> Builder s
clip = property "clip"

color :: AcceptsProperty s => MisoString -> Builder s
color = property "color"

cursor :: AcceptsProperty s => MisoString -> Builder s
cursor = property "cursor"

display :: AcceptsProperty s => MisoString -> Builder s
display = property "display"

filter :: AcceptsProperty s => MisoString -> Builder s
filter = property "filter"

float :: AcceptsProperty s => MisoString -> Builder s
float = property "float"

font :: AcceptsProperty s => MisoString -> Builder s
font = property "font"

fontFamily :: AcceptsProperty s => MisoString -> Builder s
fontFamily = property "font-family"

fontSize :: AcceptsProperty s => MisoString -> Builder s
fontSize = property "font-size"

fontVariant :: AcceptsProperty s => MisoString -> Builder s
fontVariant = property "font-variant"

fontWeight :: AcceptsProperty s => MisoString -> Builder s
fontWeight = property "font-weight"

height :: AcceptsProperty s => MisoString -> Builder s
height = property "height"

left :: AcceptsProperty s => MisoString -> Builder s
left = property "left"

letterSpacing :: AcceptsProperty s => MisoString -> Builder s
letterSpacing = property "letter-spacing"

lineHeight :: AcceptsProperty s => MisoString -> Builder s
lineHeight = property "line-height"

listStyle :: AcceptsProperty s => MisoString -> Builder s
listStyle = property "list-style"

listStyleImage :: AcceptsProperty s => MisoString -> Builder s
listStyleImage = property "list-style-image"

listStylePosition :: AcceptsProperty s => MisoString -> Builder s
listStylePosition = property "list-style-position"

listStyleType :: AcceptsProperty s => MisoString -> Builder s
listStyleType = property "list-style-type"

margin :: AcceptsProperty s => MisoString -> Builder s
margin = property "margin"

marginBottom :: AcceptsProperty s => MisoString -> Builder s
marginBottom = property "margin-bottom"

marginLeft :: AcceptsProperty s => MisoString -> Builder s
marginLeft = property "margin-left"

marginRight :: AcceptsProperty s => MisoString -> Builder s
marginRight = property "margin-right"

marginTop :: AcceptsProperty s => MisoString -> Builder s
marginTop = property "margin-top"

opacity :: AcceptsProperty s => MisoString -> Builder s
opacity = property "opacity"

overflow :: AcceptsProperty s => MisoString -> Builder s
overflow = property "overflow"

padding :: AcceptsProperty s => MisoString -> Builder s
padding = property "padding"

paddingBottom :: AcceptsProperty s => MisoString -> Builder s
paddingBottom = property "padding-bottom"

paddingLeft :: AcceptsProperty s => MisoString -> Builder s
paddingLeft = property "padding-left"

paddingRight :: AcceptsProperty s => MisoString -> Builder s
paddingRight = property "padding-right"

paddingTop :: AcceptsProperty s => MisoString -> Builder s
paddingTop = property "padding-top"

pageBreakAfter :: AcceptsProperty s => MisoString -> Builder s
pageBreakAfter = property "page-break-after"

pageBreakBefore :: AcceptsProperty s => MisoString -> Builder s
pageBreakBefore = property "page-break-before"

position :: AcceptsProperty s => MisoString -> Builder s
position = property "position"

strokeDasharray :: AcceptsProperty s => MisoString -> Builder s
strokeDasharray = property "stroke-dasharray"

strokeDashoffset :: AcceptsProperty s => MisoString -> Builder s
strokeDashoffset = property "stroke-dashoffset"

strokeWidth :: AcceptsProperty s => MisoString -> Builder s
strokeWidth = property "stroke-width"

textAlign :: AcceptsProperty s => MisoString -> Builder s
textAlign = property "text-align"

textDecoration :: AcceptsProperty s => MisoString -> Builder s
textDecoration = property "text-decoration"

textIndent :: AcceptsProperty s => MisoString -> Builder s
textIndent = property "text-indent"

textTransform :: AcceptsProperty s => MisoString -> Builder s
textTransform = property "text-transform"

top :: AcceptsProperty s => MisoString -> Builder s
top = property "top"

verticalAlign :: AcceptsProperty s => MisoString -> Builder s
verticalAlign = property "vertical-align"

visibility :: AcceptsProperty s => MisoString -> Builder s
visibility = property "visibility"

width :: AcceptsProperty s => MisoString -> Builder s
width = property "width"

zIndex :: AcceptsProperty s => MisoString -> Builder s
zIndex = property "z-index"
