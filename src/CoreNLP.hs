{-# LANGUAGE DataKinds    #-}
{-# LANGUAGE MagicHash    #-}
{-# LANGUAGE TypeFamilies #-}

module CoreNLP where

import Java

import MyCollections

data {-# CLASS "edu.stanford.nlp.simple.Document" #-} Document = Document (Object# Document)
  deriving (Class, Show)

data {-# CLASS "edu.stanford.nlp.simple.Sentence" #-} Sentence = Sentence (Object# Sentence)
  deriving (Class, Show)

foreign import java unsafe "@new" newDocument :: String -> Java a Document

foreign import java unsafe "sentences" getSentences :: Document -> List Sentence
