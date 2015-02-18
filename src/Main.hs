{-# LANGUAGE OverloadedStrings #-}

module Main where

import Copycat.Opts

main :: IO ()
main = do
  print $ execParser
