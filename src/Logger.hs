module Logger 
  ( Handle (..)
  , LogLevel (..)
  , Logger ) where

import Data.Text ( Text )

-- |The levels of logging message
data LogLevel = 
  Trace | Debug | Info | Warning | Error | Fatal 
  deriving (Eq, Ord, Show)

type Logger = Text -> IO ()

data Handle = Handle
  { logTrace    :: Logger 
  , logDebug    :: Logger
  , logInfo     :: Logger
  , logWarning  :: Logger
  , logError    :: Logger
  , logFatal    :: Logger }
