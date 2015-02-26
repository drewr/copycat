module Copycat.Opts ( CommandLine(..)
                    , Opts(..)
                    , Verbosity(..)
                    , Columns
                    , parseArgs
                    ) where

import Options.Applicative

type Url = String
type Command = String
type Columns = String
data Verbosity = Normal
               | Verbose
               deriving (Show, Read)

data Opts = Opts
            { url :: Url
            , columns :: Columns
            , verbose :: Verbosity
            }

data CommandLine = CommandLine Command Opts

opts :: Parser Opts
opts = Opts
  <$> strOption ( long "url"
               <> short 'u'
               <> value "http://localhost:9200"
               <> metavar "URL"
               <> help "Instance URL" )
  <*> strOption ( long "columns"
               <> short 'c'
               <> value "default"
               <> metavar "COLUMNS"
               <> help "What columns to return" )
  <*> flag Normal Verbose ( long "verbose"
               <> short 'v'
               <> help "Show column headers?" )

args :: Parser Command
args = argument str ( metavar "API" <> help "cat API to call" )

parseCommandLine :: Parser CommandLine
parseCommandLine = CommandLine <$> args <*> opts

parseArgs :: IO (CommandLine)
parseArgs = execParser p
  where
    p = info (helper <*> parseCommandLine)
      ( fullDesc <> progDesc "copycat!" <> header "the _cat companion" )
