{-# LANGUAGE OverloadedStrings #-}

module Main where

import Java
import CoreNLP

main :: IO ()
main = do
  d <- java $ newDocument "add your text here! It can contain multiple sentences"
  sentences <- javaWith d getSentences
  print sentences
