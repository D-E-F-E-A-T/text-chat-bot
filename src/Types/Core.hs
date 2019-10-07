{-# LANGUAGE GeneralizedNewtypeDeriving  #-}
module Types.Core 
  ( App (..), Messenger (..), ReadFileExpection, Argument ) where

import Control.Monad.IO.Class ( MonadIO )
import Control.Monad.Reader   ( runReaderT, ReaderT , MonadReader )
import Types.Json             ( Config )
import Control.Exception      ( SomeException )

-- |Main application type
newtype App env a =
  App { unApp :: ReaderT env IO a } deriving 
  ( Functor, Applicative, Monad, MonadIO, MonadReader env )

-- |Messenger's type
data Messenger = Telegram | Slack | Unknown

-- |Exeption type
type ReadFileExpection a = IO ( Either SomeException a )

type Argument = String

