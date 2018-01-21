{-# LANGUAGE OverloadedStrings #-}

module MisoStyle.Styles.Identify
  ( identify
  ) where

import           Data.Hashable          (hash)
import           Data.Monoid            ((<>))
import           Miso.String            (MisoString, pack)
import           MisoStyle.Styles.Types (Style)

identify :: Style -> MisoString
identify = ("m" <>) . pack . show . hash
