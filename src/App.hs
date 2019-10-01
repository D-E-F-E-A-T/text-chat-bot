{-# LANGUAGE FlexibleContexts #-}
module App 
  ( runApp ) where

import Types                ( App (..) , Config )
import Control.Monad.Reader ( runReaderT )
import Typeclasses          ( HasConfig (..) )

-- |HasConfig it's MonadReader typeclass with fixed enviroment (Config)
-- and methods:
--  getConfig = ask
instance HasConfig App

runApp :: Config -> IO ()
runApp config = runReaderT ( unApp app ) config

app :: ( HasConfig m ) => m ()
app = do
  config <- getConfig
  undefined
