module MisoStyle.Styles.PseudoClasses
  ( hover
  ) where

import           MisoStyle.Styles.Types (StyleBuilder, Styles, pseudo)

hover :: StyleBuilder Styles -> StyleBuilder Styles
hover = pseudo "hover"
