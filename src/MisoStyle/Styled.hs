module MisoStyle.Styled
  ( styled
  , unstyled
  , text
  , styledView
  , StyledView
  ) where

import           Control.Monad.Trans.State.Strict (State, get, put, runState)
import           Data.Hashable                    (hash)
import           Data.IntMap                      (IntMap, insert, keys, lookup)
import           Data.Monoid                      (mempty, (<>))
import           Miso                             (Attribute, View)
import qualified Miso
import           Miso.String                      (MisoString)
import           MisoStyle.Styles                 (renderClasses, renderStyles)
import           MisoStyle.Styles.Types           (Styles (unStyles))
import           Prelude                          (Maybe (Just, Nothing),
                                                   return, sequence, ($), (.),
                                                   (<$>))

type Element action = [Attribute action] -> [View action] -> View action

type StyledView action = State (IntMap MisoString, Styles) (View action)

styled ::
     Element action
  -> Styles
  -> [Attribute action]
  -> [StyledView action]
  -> StyledView action
styled element styles attrs children = do
  (renderedClasses, currentStyles) <- get
  case lookup identifier renderedClasses of
    Just classes -> element (Miso.class_ classes : attrs) <$> sequence children
    Nothing -> do
      let classes = renderClasses styles
      put (insert identifier classes renderedClasses, currentStyles <> styles)
      element (Miso.class_ classes : attrs) <$> sequence children
  where
    identifier = hash . keys . unStyles $ styles

text :: MisoString -> StyledView action
text = return . Miso.text

unstyled ::
     Element action
  -> [Attribute action]
  -> [StyledView action]
  -> StyledView action
unstyled element attrs children = element attrs <$> sequence children

style :: Styles -> View action
style styles = Miso.nodeHtml "style" [] [Miso.text (renderStyles styles)]

styledView :: (model -> StyledView action) -> model -> View action
styledView sv model = Miso.div_ [] [style styles, app]
  where
    (app, (_, styles)) = runState (sv model) mempty
