module Copycat.Opts ( Options(..)
                    , Opts(..)
                    , parseArgs
                    ) where

import Options.Applicative

type Url = String
data Verbosity = Normal
               | Verbose
               deriving (Show, Read)

data Opts = Opts
            { url :: Url
            , verbose :: Verbosity }

type Command = String

data Options = Options Command Opts

opts :: Parser Opts
opts = Opts
  <$> strOption ( long "url"
               <> short 'u'
               <> value "http://localhost:9200"
               <> metavar "URL"
               <> help "Instance URL" )
  <*> flag Normal Verbose ( long "verbose"
               <> short 'v'
               <> help "Column headers" )

args :: Parser Command
args = argument str ( metavar "API" <> help "cat API to call" )

parseOptions :: Parser Options
parseOptions = Options <$> args <*> opts

parseArgs :: IO (Options)
parseArgs = execParser p
  where
    p = info (helper <*> parseOptions)
      ( fullDesc <> progDesc "copycat!" <> header "the _cat companion" )
