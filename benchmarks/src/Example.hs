{-# LANGUAGE NamedFieldPuns    #-}
{-# LANGUAGE OverloadedStrings #-}

module Example
  ( view
  , generateRows
  , Model(Model)
  ) where

import           Control.Monad (mapM)
import           Data.Bool     (bool)
import           Data.Foldable (foldr)
import           Data.List     (intersperse, length, zipWith)
import           Data.Monoid   (mconcat, mempty, (<>))
import           Data.Vector   (Vector, (!))
import qualified Data.Vector   as Vector
import           Miso          (Attribute, View, a_, button_, class_,
                                defaultEvents, div_, h1_, href_, id_, onClick,
                                span_, table_, tbody_, td_, tr_, type_)
import           Miso.String   (MisoString, ms)
import           MisoStyle     (StyledView, Styles, base, borderTop, color,
                                hover, lineHeight, marginBottom, padding,
                                property, styledView, styles, text,
                                textDecoration, verticalAlign, width)
import           System.Random (randomRIO)

adjectives :: Vector MisoString
adjectives =
  Vector.fromList
    [ "pretty"
    , "large"
    , "big"
    , "small"
    , "tall"
    , "short"
    , "long"
    , "handsome"
    , "plain"
    , "quaint"
    , "clean"
    , "elegant"
    , "easy"
    , "angry"
    , "crazy"
    , "helpful"
    , "mushy"
    , "odd"
    , "unsightly"
    , "adorable"
    , "important"
    , "inexpensive"
    , "cheap"
    , "expensive"
    , "fancy"
    ]

colours :: Vector MisoString
colours =
  Vector.fromList
    [ "red"
    , "yellow"
    , "blue"
    , "green"
    , "pink"
    , "brown"
    , "purple"
    , "brown"
    , "white"
    , "black"
    , "orange"
    ]

nouns :: Vector MisoString
nouns =
  Vector.fromList
    [ "table"
    , "chair"
    , "house"
    , "bbq"
    , "desk"
    , "car"
    , "pony"
    , "cookie"
    , "sandwich"
    , "burger"
    , "pizza"
    , "mouse"
    , "keyboard"
    ]

tdStyles :: Styles
tdStyles =
  styles $ do
    padding "8px"
    lineHeight "1.42857143"
    verticalAlign "top"
    borderTop "1px solid #ddd"

anchorStyles :: Styles
anchorStyles =
  styles $ do
    color "#337ab7"
    textDecoration "none"
    hover (textDecoration "underline")

row :: Row -> StyledView ()
row Row {_id, label} =
  base
    tr_
    mempty
    []
    [ base
        td_
        (tdStyles <> styles (width "8.33333333%"))
        []
        [text (ms (show _id))]
    , base td_ tdStyles [] [base a_ anchorStyles [href_ "#"] [text label]]
    , base
        td_
        tdStyles
        []
        [base a_ anchorStyles [href_ "#"] [base span_ mempty [] []]]
    , base td_ tdStyles [] []
    ]

view :: Model -> StyledView ()
view Model {rows} =
  base
    table_
    (styles $ do
       width "100%"
       property "max-width" "100%"
       marginBottom "20px")
    []
    [base tbody_ mempty [] (map row rows)]

generateRows :: Int -> IO [Row]
generateRows count =
  mapM
    (((generateRow <$> randomRIO (0, Vector.length adjectives - 1) <*>
       randomRIO (0, Vector.length colours - 1) <*>
       randomRIO (0, Vector.length nouns - 1)) <*>) .
     pure)
    [0 .. count]

generateRow :: Int -> Int -> Int -> Int -> Row
generateRow adjectiveIndex colourIndex nounIndex _id =
  Row
  { _id = _id
  , label =
      adjectives ! adjectiveIndex <> " " <> colours ! colourIndex <> " " <>
      nouns !
      nounIndex
  }

newtype Model = Model
  { rows :: [Row]
  } deriving (Show, Eq, Ord)

data Row = Row
  { _id   :: !Int
  , label :: !MisoString
  } deriving (Show, Eq, Ord)
