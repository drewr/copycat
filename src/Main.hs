{-# LANGUAGE OverloadedStrings #-}

module Main where

import Copycat.Opts
import qualified Data.ByteString.Lazy.Char8 as BS
import Control.Lens
import Network.Wreq (get, responseBody)

main :: IO ()
main = parseArgs >>= go

go :: Options -> IO ()
go (Options cmd opts) = do
  r <- get (url opts ++ "/_cat/" ++ cmd)
  putStrLn $ BS.unpack $ r ^. responseBody
