{-# LANGUAGE GeneralizedNewtypeDeriving  #-}
module Types.Core 
  ( App (..) ) where

import Control.Monad.IO.Class ( MonadIO )
import Control.Monad.Reader   ( runReaderT, ReaderT , MonadReader )
import Types.Json             ( Config )


newtype App env a =
  App { unApp :: ReaderT env IO a } deriving 
  ( Functor, Applicative, Monad, MonadIO, MonadReader env )
