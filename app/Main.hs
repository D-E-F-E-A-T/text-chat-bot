{-# LANGUAGE OverloadedStrings #-}

module Main where

import MyPrelude
import Control.Exception              ( SomeException, try )
import System.Environment             ( getArgs )
import System.Exit                    ( exitFailure )
import Control.Monad                  ( when )
import Data.Aeson                     ( decodeStrict )
import Control.Monad.Reader           ( runReaderT, ReaderT , MonadReader )
import App                            ( runApp )
import Core                           ( logWithExit )
import qualified Logger               as Logger
import qualified Logger.Impl.Console  as ConsoleLogger
import qualified Types                as Types


type ReadFileExpection a = IO ( Either SomeException a )

main :: IO ()
main = 
  ConsoleLogger.withHandle $ \ logger -> do
  let logWithExit' = logWithExit logger
  -- |Passing config path in command-ilne. 
  -- Get args and check its count
  arguments <- getArgs
  when ( length arguments /= 1 ) $ logWithExit' "Invalid count of arguments"
  let [configPath] = arguments 
  
  -- |Try to read config
  readConfigResult <- try $
    b8ReadFile configPath :: ReadFileExpection ByteStringChar8
  when ( isLeft readConfigResult ) $ logWithExit' $
      "Can't read configuration from path"
      <> tPack configPath <> "/n"

  -- |Try to parse config
  let ( Right b8Config ) = readConfigResult
      maybeParsedConfig  = decodeStrict b8Config :: Maybe Types.Config
  when ( isNothing maybeParsedConfig ) $ 
    logWithExit' "Can't parse configuration file"
  let ( Just parsedConfig ) = maybeParsedConfig
  runApp parsedConfig

