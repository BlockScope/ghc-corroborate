module Internal.Evidence (evDFunApp', evCast', terms) where

import Internal

evDFunApp' :: DFunId -> [Type] -> [EvExpr] -> EvTerm
evDFunApp' = evDFunApp

evCast' :: EvTerm -> TcCoercion -> EvTerm
evCast' (EvExpr e)  = evCast e
evCast' EvTypeable{} = error "Can't evCast (EvTypeable _ _)"
evCast' EvFun{} = error "Can't evCast (EvFun _ _ _ _)"

terms :: Type -> Type -> [EvExpr]
terms t1 t2 =
    case evByFiat "units" t1 t2 of
        EvExpr e -> [e]
        EvTypeable{} -> []
        EvFun{} -> []
