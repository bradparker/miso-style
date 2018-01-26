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
import           MisoStyle   (animation, atmedia, base, hover, keyframe,
                              property, styledView, styles, text)

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

view :: Model -> View Action
view =
  styledView $ \m ->
    base
      div_
      (styles (return mempty))
      []
      [ base
          button_
          (styles $ do
             property "color" "white"
             property "background-color" "red"
             property "animation-duration" "2s"
             property "animation-iteration-count" "infinite"
             animation
               [ keyframe "0%" (property "background-color" "coral")
               , keyframe "100%" (property "background-color" "red")
               ])
          [onClick (Decrement 2)]
          [text "-"]
      , text (ms (" " ++ show m ++ " "))
      , base
          button_
          (styles $ do
             property "color" "white"
             property "background-color" "green"
             hover (property "background-color" "seagreen")
             atmedia
               "screen and (min-width: 400px)"
               (property "background-color" "blue"))
          [onClick (Increment 2)]
          [text "+"]
      ]
