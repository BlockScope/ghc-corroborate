module GHC.Corroborate.Compare (cmpTyCon, cmpType, cmpTypes) where

import GHC.Corroborate

cmpTyCon :: TyCon -> TyCon -> Ordering
cmpTyCon a b = getUnique a `nonDetCmpUnique` getUnique b

cmpType :: Type -> Type -> Ordering
cmpType = nonDetCmpType

cmpTypes :: [Type] -> [Type] -> Ordering
cmpTypes = nonDetCmpTypes
