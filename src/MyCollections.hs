{-# LANGUAGE MagicHash           #-}
{-# LANGUAGE DataKinds           #-}
{-# LANGUAGE TypeFamilies        #-}
{-# LANGUAGE FlexibleContexts    #-}
{-# LANGUAGE UnliftedFFITypes    #-}
{-# LANGUAGE ScopedTypeVariables #-}

module MyCollections where

import Java
import Java.Collections
import GHC.Base

data {-# CLASS "java.util.Collection" #-} Collection a = Collection (Object# (Collection a))
  deriving Class

data {-# CLASS "java.util.List" #-} List a = List (Object# (List a))
  deriving (Class, Show)

data {-# CLASS "java.util.ArrayList" #-} ArrayList a = ArrayList (Object# (ArrayList a))
  deriving (Class, Show)

foreign import java unsafe "@new" newArrayList :: Java c (ArrayList a)

foreign import java unsafe "@interface add" add ::
  (Extends a Object, Extends b (Collection a)) => a -> Java b Bool

foreign import java unsafe "@interface addAll" addAll ::
  (Extends a Object, Extends b (Collection a)) => Proxy# a -> b -> Java b Bool

type instance Inherits (List a) = '[Collection a, Iterable a]

type instance Inherits (ArrayList a) = '[List a]

instance Class a => Monoid (ArrayList a) where
  mempty          = pureJava newArrayList
  a1 `mappend` a2 = pureJava $ do
    al <- newArrayList
    _  <- al <.> (addAll (proxy# :: Proxy# a) a1)
    _  <- al <.> (addAll (proxy# :: Proxy# a) a2)
    return al
