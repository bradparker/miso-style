{-# LANGUAGE OverloadedStrings #-}

module Main
  ( main
  ) where

import qualified Miso
import           MisoStyle
import           Test.Hspec (describe, hspec, it, shouldBe)

app :: Miso.View ()
app =
  styledView
    (const (styled Miso.div_ (styles (color "blue")) [] [text "Hello, world"]))
    ()

expected :: String
expected =
  "<div><style>@media all {.m6450259326116818422 {color: blue}} </style><div class=\"m6450259326116818422 \">Hello, world</div></div>"

main :: IO ()
main =
  hspec
    (describe
       "Rendering a styled view"
       (it
          "returns a div with two children: a style tag containing all required CSS and the app content"
          (show app `shouldBe` expected)))
