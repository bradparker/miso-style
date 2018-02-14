{-# LANGUAGE OverloadedStrings #-}

module MisoStyle.Base
  ( base
  , text
  , styledView
  , StyledView
  ) where

import           Control.Monad.Trans.Writer.Strict (Writer, runWriter, tell,
                                                    writer)
import           Miso                              (Attribute, View)
import qualified Miso
import           Miso.String                       (MisoString)
import           MisoStyle.Styles                  (Styles, renderClasses,
                                                    renderStyles)

type Element action = [Attribute action] -> [View action] -> View action

type StyledView action = Writer Styles (View action)

base ::
     Element action
  -> Styles
  -> [Attribute action]
  -> [StyledView action]
  -> StyledView action
base el styles attrs children =
  el (Miso.class_ (renderClasses styles) : attrs) <$>
  (tell styles >> sequence children)

text :: MisoString -> StyledView action
text str = writer (Miso.text str, mempty)

style :: Styles -> View action
style styles = Miso.nodeHtml "style" [] [Miso.text (renderStyles styles)]

styledView :: (model -> StyledView action) -> model -> View action
styledView sv model = Miso.div_ [] [style styles, app]
  where
    (app, styles) = runWriter (sv model)
