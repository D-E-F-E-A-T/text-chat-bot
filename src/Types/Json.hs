module Types.Json where

import Data.Aeson
import Data.Aeson.Types
import Data.Text ( Text )

data Config = Config 
  { messengerConfig :: [MessengerConfig] }

data MessengerConfig = MessengerConfig
  { name  :: Text
  , token :: Text
  , proxy :: Maybe Proxy }

data Proxy = Proxy
  { host :: Text
  , port :: Int }
