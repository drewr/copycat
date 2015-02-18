
module Copycat.Opts ( Options(..)
                    , execParser
                    ) where

import Options.Applicative

type Url = String
type Verbose = Bool
type NodeList = String
type IndexList = String

data Common = Common
              { url :: String
              , verbose :: Bool }

data Api = Nodes NodeList
         | Master
         | Indices IndexList

data Options = Options Common Api

-- opts :: Parser Options
-- opts = Options
--   <$> strOption

common :: Parser Common
common = Common
  <$> strOption
      ( long "url"
     <> metavar "URL"
     <> help "Instance URL" )
  <*> switch
      ( short 'v'
     <> long "verbose"
     <> help "Column headers" )

parseNodes :: Parser Api
parseNodes = Nodes
  <$> argument str (metavar "NODES")
