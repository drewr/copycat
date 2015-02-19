{-# LANGUAGE OverloadedStrings #-}

module Main where

import Copycat.Opts

main :: IO ()
main = parseArgs >>= go

go :: Options -> IO ()
go (Options app cmd) =
  case cmd of
    Master headers -> putStrLn $ "would have run _cat/master!! " ++ headers
    Nodes headers nodes -> putStrLn $ "would have run _cat/nodes " ++ nodes
    otherwise -> putStrLn $ "something else"
