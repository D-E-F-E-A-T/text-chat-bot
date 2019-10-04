{-# LANGUAGE OverloadedStrings #-}
import Test.Hspec
import qualified Logger.Impl.Console as Console
import qualified Logger as Logger
import System.Exit ( ExitCode(..) )
import Core ( logWithExit )

main :: IO ()
main = hspec $ do
    around Console.withHandle $ do
      describe "Testing function logWithExit" $ do
        it "log text and exit  failure" $ \ l -> do
          (logWithExit l "Error message!!!") `shouldThrow` (== ExitFailure 1) 
        
