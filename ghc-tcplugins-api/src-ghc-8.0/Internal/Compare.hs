module Internal.Compare (cmpTyCon, cmpType, cmpTypes) where

import qualified Type (cmpType, cmpTypes)
import Internal

cmpTyCon :: TyCon -> TyCon -> Ordering
cmpTyCon = compare

cmpType :: Type -> Type -> Ordering
cmpType = Type.cmpType

cmpTypes :: [Type] -> [Type] -> Ordering
cmpTypes = Type.cmpTypes
