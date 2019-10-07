{-# LANGUAGE OverloadedStrings #-}

import Test.Hspec
import qualified Specs

main :: IO ()
main = hspec $ do
  Specs.loggingOfFatalError
