{-# LANGUAGE OverloadedStrings #-}

module Main (main) where

import Test.Hspec (hspec, describe, it, shouldBe)
import MisoStyle
import qualified Miso

app :: Miso.View ()
app = styledView (const (base Miso.div_ (styles (color "blue")) [] [text "Hello, world"])) ()

expected :: String
expected = "<div><style>@media all {.m6450259326116818422 {color: blue}}</style><div class=\"m6450259326116818422\">Hello, world</div></div>"

main :: IO ()
main = hspec $ do
  describe "Rendering a styled view" $ do
    it "returns a div with two children: a style tag containing all required CSS and the app content" $ do
      show app `shouldBe` expected
