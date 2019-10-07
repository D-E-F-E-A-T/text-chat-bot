{-# LANGUAGE OverloadedStrings #-}
module Specs
  ( loggingOfFatalError ) where

import Test.Hspec
import System.Exit                    ( ExitCode(..) )
import Control.Exception              ( SomeException )
import Core                           ( logWithExit )
import Data.Either                    ( isLeft )
import qualified Logger.Impl.Console  as Console
import qualified Logger               as Logger

loggingOfFatalError :: Spec
loggingOfFatalError =
  around Console.withHandle $ do
      describe "Logging with exit" $ do
        it "log text and exit  failure" $ \ l -> do
          (logWithExit l "Error message!") `shouldThrow` (== ExitFailure 1)


