{-# LANGUAGE OverloadedStrings #-}

module Main where

import Copycat.Opts
import Network.Wreq (get)

main :: IO ()
main = parseArgs >>= go

go :: Options -> IO ()
go (Options opts cmd) =
  case cmd of
    Master headers -> putStrLn $ get (url opts ++ "/_cat/master")
    Nodes headers nodes -> putStrLn $ "would have run _cat/nodes " ++ nodes
