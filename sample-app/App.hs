{-# LANGUAGE OverloadedStrings #-}

module App
  ( update
  , view
  , subs
  , initialAction
  , initialModel
  ) where

import           Data.Bool   (bool)
import           Miso        (Effect, Sub, View, button_, div_, keyboardSub,
                              mouseSub, noEff, onClick)
import qualified Miso
import           Miso.String (ms)
import           MisoStyle   (animation, atmedia, base, rule, styledView,
                              stylesheet, text)

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
      (stylesheet [])
      []
      [ base
          button_
          (stylesheet
             [ rule ("color", "white")
             , rule ("background-color", "red")
             , rule ("animation-duration", "2s")
             , rule ("animation-iteration-count", "infinite")
             , animation
                 [ ("0%", [("background-color", "coral")])
                 , ("100%", [("background-color", "red")])
                 ]
             ])
          [onClick (Decrement 2)]
          [text "-"]
      , text (ms (" " ++ show m ++ " "))
      , base
          button_
          (stylesheet
             [ rule ("color", "white")
             , rule ("background-color", "green")
             , atmedia
                 ( "screen and (min-width: 400px)"
                 , [("background-color", "blue")])
             ])
          [onClick (Increment 2)]
          [text "+"]
      ]
