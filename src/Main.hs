{-# LANGUAGE OverloadedStrings #-}

module Main where

import Copycat.Opts
import qualified Data.Text as T
import qualified Data.ByteString.Lazy.Char8 as BS
import Control.Lens
import Network.Wreq (defaults, param, getWith, responseBody)

main :: IO ()
main = parseArgs >>= go

go :: CommandLine -> IO ()
go (CommandLine cmd opts) = do
  let httpopts1 = defaults & (param "v" .~ [verbosity $ verbose opts])
  let httpopts2 = if columns opts == "default"
                  then httpopts1
                  else httpopts1 & (param "h" .~ [cols $ columns opts])
  r <- getWith httpopts2 $ url opts ++ "/_cat/" ++ cmd
  putStr $ BS.unpack $ r ^. responseBody

verbosity :: Verbosity -> T.Text
verbosity Normal = "false"
verbosity Verbose = "true"

cols :: Columns -> T.Text
cols h = T.pack h
