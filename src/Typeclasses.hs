{-# LANGUAGE FlexibleContexts #-}

module Typeclasses 
  ( HasConfig (..) ) where

import Control.Monad.Reader ( MonadReader, ask )
import Types ( Config )

class MonadReader Config m => HasConfig m where
  getConfig :: m Config 
  getConfig = ask 
