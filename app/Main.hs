{-# LANGUAGE OverloadedStrings #-}

module Main where

import MyPrelude
import Control.Exception              ( try )
import Control.Monad.IO.Class         ( MonadIO, liftIO )
import Control.Monad.Reader           ( runReaderT, ReaderT , MonadReader )
import Control.Monad.Except           ( runExceptT, ExceptT , MonadError )
import Control.Monad                  ( when )
import System.Environment             ( getArgs )
import System.Exit                    ( exitFailure )
import Data.Aeson                     ( decodeStrict )
import App                            ( runApp )
import qualified Logger               as Logger
import qualified Logger.Impl.Console  as ConsoleLogger
import qualified Types                as Types

logWithExit :: Logger.Handle -> Text -> IO ()
logWithExit logger text = Logger.logFatal logger text >> exitFailure

main :: IO ()
main = 
  ConsoleLogger.withHandle $ \ logger -> do
  let logWithExit' = logWithExit logger
  -- |Passing config path in command-line. 
  -- Get args and check its count
  arguments <- getArgs
  when ( length arguments /= 1 ) $ logWithExit' "Invalid count of arguments"
  let [configPath] = arguments 
  
  -- |Try to read config
  readConfigResult <- try $
    b8ReadFile configPath :: Types.ReadFileExpection ByteStringChar8
  when ( isLeft readConfigResult ) $ logWithExit' $
    "Can't read configuration from path" <> tPack configPath <> "/n"

  -- |Try to parse config
  let ( Right b8Config ) = readConfigResult
      maybeParsedConfig  = decodeStrict b8Config :: Maybe Types.Config
  when ( isNothing maybeParsedConfig ) $ 
    logWithExit' "Can't parse configuration file"
  let ( Just parsedConfig ) = maybeParsedConfig
  runApp parsedConfig
