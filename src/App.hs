{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE OverloadedStrings #-}

module App 
  ( runApp ) where

import Types                  ( App (..), Config (..)
                              , MessengerConfig (..), Messenger (..) )
import Control.Monad.Reader   ( runReaderT )
import Data.Foldable          ( for_ )
import Typeclasses            ( Has (..), Liftable (..) )
import Control.Monad.IO.Class ( MonadIO, liftIO )

-- |"Has" it's MonadReader typeclass 
--  methods:
--    get' = ask
instance Has Config           ( App Config )
instance Liftable IO          ( App Config ) where
  lift' = liftIO 
instance Has MessengerConfig  ( App MessengerConfig )
instance Liftable IO          ( App MessengerConfig ) where
  lift' = liftIO

runApp :: Config -> IO ()
runApp config = runReaderT ( unApp app ) config

runMessengerApp :: MessengerConfig -> IO ()
runMessengerApp config = runReaderT ( unApp messengerApp ) config 

messengerApp :: ( Has MessengerConfig m, Liftable IO m ) => m ()
messengerApp = do   
  messengerName <- get'with name
  let currentMessenger = 
        case messengerName of
        "telegram"  -> Telegram
        "slack"     -> Slack
        otherwise   -> Unknown

  undefined

app :: ( Has Config m, Liftable IO m ) => m ()
app = do
  config <- get'
  for_ ( messengers config ) $ lift' . runMessengerApp
  undefined
