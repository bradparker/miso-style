# Miso Styling Experiment

*N.B.* at this point this is for my own curiousity and learning. The api ... is a little weird and will change :).

CSS in JS in the style of Fela and Aphrodite, but in Haskell and specifically for the Miso framework.

## Usage

The `MisoStyle` module exports a function called `base` (this is a silly name) it wraps existing Miso element functions so that they become "style-aware". Elements wrapped by base take an extra arg, a `stylesheet`, which is a set of CSS rules you'd like to apply to this element.

It looks like this:

```haskell
import MisoStyle  (stylesheet, animation, atmedia, base, rule, StyledElement)

helloStyles =
  stylesheet
    [ rule ("color", "white")
    , rule ("padding", "1rem")
    , rule ("border-raduis", "1rem")
    , rule ("background-color", "coral")
    , rule ("animation-duration", "2s")
    , rule ("animation-iteration-count", "infinite")
    , animation
        [ ("0%", [("opacity", "0.5")])
        , ("100%", [("opacity", "1")])
        ]
    , atmedia ("screen and (min-width: 400px)", [("background-color", "seagreen")])
    ]

hello :: MisoString -> StyledElement ()
hello name =
  base div_ helloStyles [] [text ("Hello, " <> name <> "!")]
```
