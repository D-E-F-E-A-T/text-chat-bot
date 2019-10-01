{-# LANGUAGE OverloadedStrings #-}
module Types.Json
  ( Config (..), MessengerConfig (..), Proxy ) where

import Data.Aeson
import Data.Aeson.Types
import Data.Text ( Text )

-- |Main configuration file data-types
data Config = Config 
  { messengers :: [MessengerConfig] }

data MessengerConfig = MessengerConfig
  { name  :: Text
  , token :: Text
  , proxy :: Maybe Proxy }

data Proxy = Proxy
  { host :: Text
  , port :: Int }

instance FromJSON Proxy where
  parseJSON (Object proxy) = Proxy <$> proxy .: "host" <*> proxy .: "port"

instance FromJSON MessengerConfig where
  parseJSON (Object m) = MessengerConfig  <$> m .: "name"
                                          <*> m .: "token"
                                          <*> m .:? "proxy"

instance FromJSON Config where
  parseJSON (Object c) = Config <$> c .: "messengers"
