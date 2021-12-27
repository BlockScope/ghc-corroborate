module GHC.Corroborate.Compare (cmpTyCon, cmpType, cmpTypes) where

import GHC.Corroborate

-- TODO: all this is deeply dodgy!  These comparison functions are
-- non-deterministic, so we may end up getting different results on different
-- runs.  Really we should replace them with deterministic versions.

cmpTyCon :: TyCon -> TyCon -> Ordering
cmpTyCon = nonDetCmpTc

cmpType :: Type -> Type -> Ordering
cmpType (LitTy x) (LitTy y) = cmpTyLit x y
cmpType t1 t2 = nonDetCmpType t1 t2

cmpTypes :: [Type] -> [Type] -> Ordering
cmpTypes [] [] = EQ
cmpTypes (t1:ts1) (t2:ts2) = cmpType t1 t2 `thenCmp` cmpTypes ts1 ts2
cmpTypes [] _ = LT
cmpTypes _ [] = GT