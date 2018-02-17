module MisoStyle.Styles.PseudoClasses
  ( hover
  ) where

import           MisoStyle.Styles.Types (Builder, Styles, pseudo)

hover :: Builder Styles -> Builder Styles
hover = pseudo "hover"
