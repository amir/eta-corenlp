{-# LANGUAGE OverloadedStrings #-}

module Main where

import Java
import Java.Collections

import CoreNLP

main :: IO ()
main = do
  it  <- java $ do
    d  <- newDocument "add your text here! It can contain multiple sentences"
    getSentences d <.> iterator
  print $ consume (it :: Iterator Sentence)
