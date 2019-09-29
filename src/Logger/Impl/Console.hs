{-# LANGUAGE OverloadedStrings #-}
module Logger.Impl.Console
  ( withHandle ) where

import Prelude hiding ( log )
import Logger
import Data.Text ( Text , unpack, pack )
import Control.Exception ( bracket )
 
new :: IO Handle
new =
  pure Handle
    { logTrace    = log Trace 
    , logDebug    = log Debug
    , logInfo     = log Info
    , logWarning  = log Warning
    , logError    = log Error
    , logFatal    = log Fatal }

close :: Handle -> IO ()
close _ = pure ()

withHandle :: (Handle -> IO ()) -> IO ()
withHandle action = bracket new close action

-- |Function takes log level with text and return IO action
-- type Logger = Text -> IO ()
log :: LogLevel -> Logger
log logLevel message =
  print $  "[" <> pack (show logLevel)  <> "]" 
        <> " : " <> message

