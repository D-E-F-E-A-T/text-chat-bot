{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FunctionalDependencies #-}

module Typeclasses 
  ( Has (..), Liftable (..) ) where

import Control.Monad.Reader   ( MonadReader, ask, asks )
import Control.Monad.IO.Class ( MonadIO, liftIO )
import Types                  ( Config )

class MonadReader env m => Has env m where
  get' :: m env 
  get' = ask 
  get'with :: (env -> a) -> m a
  get'with = asks

class Liftable m' m where
  lift' :: m' a -> m a

