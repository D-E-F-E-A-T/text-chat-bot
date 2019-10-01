{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FunctionalDependencies #-}

module Typeclasses 
  ( Has (..), Liftable (..) ) where

import Control.Monad.Reader   ( MonadReader, ask )
import Control.Monad.IO.Class ( MonadIO, liftIO )
import Types                  ( Config )

class MonadReader env m => Has env m where
  get' :: m env 
  get' = ask 

class Liftable m' m where
  lift' :: m' a -> m a

