{-# LANGUAGE OverloadedStrings #-}

module MisoStyle.Base
  ( base
  , text
  , styledView
  , StyledElement
  ) where

import           Control.Monad.Trans.Writer (Writer, runWriter, tell, writer)
import           Miso                       (Attribute, View)
import qualified Miso
import           Miso.String                (MisoString)
import           MisoStyle.Styles           (Styles, renderClasses,
                                             renderStyles)

type Element action = [Attribute action] -> [View action] -> View action

type StyledElement action = Writer Styles (View action)

base ::
     Element action
  -> Styles
  -> [Attribute action]
  -> [StyledElement action]
  -> StyledElement action
base el styles attrs children =
  el (Miso.class_ (renderClasses styles) : attrs) <$>
  (tell styles >> sequence children)

text :: MisoString -> StyledElement action
text str = writer (Miso.text str, mempty)

style :: Styles -> View action
style styles = Miso.nodeHtml "style" [] [Miso.text (renderStyles styles)]

styledView :: (model -> StyledElement action) -> model -> View action
styledView sv model = Miso.div_ [] [style styles, app]
  where
    (app, styles) = runWriter (sv model)
