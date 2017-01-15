{-# LANGUAGE MagicHash #-}

module CoreNLP where

import Java

data {-# CLASS "edu.stanford.nlp.simple.Document" #-} Document = Document (Object# Document)
  deriving (Class, Show)

data {-# CLASS "edu.stanford.nlp.simple.Sentence" #-} Sentence = Sentence (Object# Sentence)
  deriving (Class, Show)

data {-# CLASS "java.util.List" #-} List a = List (Object# (List a))
  deriving (Class, Show)

foreign import java unsafe "@new" newDocument :: String -> Java a Document

foreign import java unsafe "@new" newSentence :: String -> Java a Sentence

foreign import java unsafe "sentences" getSentences :: Java Document (List String)
