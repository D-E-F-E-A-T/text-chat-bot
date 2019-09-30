module MyPrelude 
  (
  -- |ByteString.Char8 exports
    b8Pack, b8Unpack, b8ReadFile
  , ByteStringChar8

  -- |Text exports
  , tPack, tUnpack, Text

  -- |Either exports
  , isLeft, isRight

  -- |Maybe exports
  , isNothing

  ) where

import qualified Data.ByteString.Char8  as B
import qualified Data.Text              as T
import Data.Either                      ( isLeft, isRight )
import Data.Maybe                       ( isNothing )

-- |ByteString.Char8 functoins 
b8ReadFile  = B.readFile
b8Pack      = B.pack
b8Unpack    = B.unpack

-- |ByteString.Char8 types
type ByteStringChar8  = B.ByteString

-- |Text functoins
tPack   = T.pack
tUnpack = T.unpack

-- |Text types
type Text = T.Text
