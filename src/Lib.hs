module Lib where 

import MyPrelude
import qualified Logger               as Logger
import System.Exit                    ( exitFailure )

logWithExit :: Logger.Handle -> Text -> IO ()
logWithExit logger text = Logger.logFatal logger text >> exitFailure



