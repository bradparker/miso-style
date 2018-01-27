{-# LANGUAGE OverloadedStrings #-}

module App
  ( update
  , view
  , subs
  , initialAction
  , initialModel
  ) where

import           Data.Bool   (bool)
import           Data.Monoid (mempty)
import           Miso        (Effect, Sub, View, button_, div_, keyboardSub,
                              mouseSub, noEff, onClick)
import qualified Miso
import           Miso.String (ms)
import           MisoStyle   (StyledView, animation, animationDuration,
                              animationIterationCount, atmedia, backgroundColor,
                              base, color, hover, keyframe, styledView, styles,
                              text)

type Model = Int

data Action
  = NoOp
  | Increment Int
  | Decrement Int
  deriving (Show, Eq)

initialAction :: Action
initialAction = NoOp

initialModel :: Model
initialModel = 0

update :: Action -> Model -> Effect Action Model
update NoOp          = noEff
update (Increment n) = noEff . (+ n)
update (Decrement n) = noEff . subtract n

subs :: [Sub Action Model]
subs = [mouseSub (Increment . fst), keyboardSub (const (Decrement 100))]

increment :: StyledView Action
increment =
  base
    button_
    (styles $ do
       color "white"
       backgroundColor "red"
       animationDuration "2s"
       animationIterationCount "infinite"
       animation $ do
         keyframe "0%" (backgroundColor "coral")
         keyframe "100%" (backgroundColor "red"))
    [onClick (Decrement 2)]
    [text "-"]

decrement :: StyledView Action
decrement =
  base
    button_
    (styles $ do
       color "white"
       backgroundColor "green"
       hover (backgroundColor "seagreen")
       atmedia "screen and (min-width: 400px)" (backgroundColor "blue"))
    [onClick (Increment 2)]
    [text "+"]

app :: Model -> StyledView Action
app m =
  base
    div_
    (styles (return mempty))
    []
    [increment, text (ms (" " ++ show m ++ " ")), decrement]

view :: Model -> View Action
view = styledView app
