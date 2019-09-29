{-# LANGUAGE OverloadedStrings #-}

module Main where

import MyPrelude
import Control.Exception              ( SomeException, try )
import System.Environment             ( getArgs )
import System.Exit                    ( exitFailure )
import Control.Monad                  ( when )
import Data.Aeson                     ( decodeStrict )
import qualified Logger               as Logger
import qualified Logger.Impl.Console  as ConsoleLogger


type ReadFileExpection a = IO ( Either SomeException a )

main :: IO ()
main = 
  ConsoleLogger.withHandle $ \ logger -> do
  let logFatal = Logger.logFatal logger
  -- |Passing config path in command-ilne. 
  -- Get args and check its count
  arguments <- getArgs
  when (length arguments /= 1) $ do
    logFatal "Invalid count of arguments" >> exitFailure
  let [configPath] = arguments 
  
  -- |Try to read config
  readConfigResult <- try $
    b8ReadFile configPath :: ReadFileExpection ByteStringChar8
  when (isLeft readConfigResult) $ do
    logFatal $
      "Can't read configuration from path"
      <> tPack configPath <> "/n"
    exitFailure
  let (Right b8Config) = readConfigResult

  undefined

