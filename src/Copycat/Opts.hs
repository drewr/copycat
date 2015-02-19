module Copycat.Opts ( Options(..)
                    , Command(..)
                    , parseArgs
                    ) where

import Options.Applicative

type Url = String
data Verbosity = Normal
               | Verbose
               deriving (Show, Read)
type WcList = String
type Headers = String

data OptsCommon = OptsCommon
                  { url :: Url
                  , verbose :: Verbosity }

data Command = Nodes Headers WcList
             | Master Headers

data Options = Options OptsCommon Command

common :: Parser OptsCommon
common = OptsCommon
  <$> strOption
      ( short 'u' <> long "url"
     <> metavar "URL"
     <> help "Instance URL" )
  <*> flag Normal Verbose
      ( short 'v' <> long "verbose"
     <> help "Column headers" )

parseNodes :: Parser Command
parseNodes = Nodes
  <$> argument str (metavar "HEADERS")
  <*> argument str (metavar "NODES")

parseMaster :: Parser Command
parseMaster = Master
  <$> argument str (metavar "HEADERS")

parseCommand :: Parser Command
parseCommand = subparser $
  command "nodes" (info (helper <*> parseNodes) $ progDesc "desc for _cat/nodes") <>
  command "master" (info (helper <*> parseMaster) $ progDesc "desc for _cat/master")

parseOptions :: Parser Options
parseOptions = Options <$> common <*> parseCommand

parseArgs :: IO (Options)
parseArgs = execParser (info (helper <*> parseOptions) $ progDesc "parser copycat")
