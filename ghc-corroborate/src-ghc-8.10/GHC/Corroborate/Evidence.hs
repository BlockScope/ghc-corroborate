module GHC.Corroborate.Evidence (evDFunApp', evCast', terms) where

import GHC.Corroborate

evDFunApp' :: DFunId -> [Type] -> [EvExpr] -> EvTerm
evDFunApp' = evDFunApp

evCast' :: EvTerm -> TcCoercion -> EvTerm
evCast' (EvExpr e)  = evCast e
evCast' EvTypeable{} = error "Can't evCast EvTypeable{}"
evCast' EvFun{} = error "Can't evCast EvFun{}"

terms :: String -> Type -> Type -> [EvExpr]
terms s t1 t2 =
    case evByFiat s t1 t2 of
        EvExpr e -> [e]
        EvTypeable{} -> []
        EvFun{} -> []
