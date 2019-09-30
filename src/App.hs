{-# LANGUAGE FlexibleContexts #-}
module App where

import Types ( App (..), Config )
import Control.Monad.Reader ( MonadReader , runReaderT )

runApp :: Config -> IO ()
runApp config = runReaderT ( unApp app ) config

app :: ( MonadReader Config m ) => m ()
app = do
  undefined
