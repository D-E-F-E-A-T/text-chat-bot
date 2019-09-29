{-# LANGUAGE OverloadedStrings #-}

module Main where

import System.Environment ( getArgs )
import System.Exit ( exitFailure )
import Control.Monad ( when )
import qualified Logger as Logger
import qualified Data.Bytestring
import qualified Logger.Impl.Console as ConsoleLogger

main :: IO ()
main = 
  ConsoleLogger.withHandle $ \ logger -> do
  arguments <- getArgs
  when (length arguments /= 1) $ do
    Logger.logFatal logger "Invalid count of arguments" >> exitFailure
  let [configPath] = arguments  
  
  undefined
