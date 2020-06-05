module Internal.Evidence (evDFunApp', evCast', terms) where

import Internal

evDFunApp' :: DFunId -> [Type] -> [EvTerm] -> EvTerm
evDFunApp' = EvDFunApp

evCast' :: EvTerm -> TcCoercionR -> EvTerm
evCast' = EvCast

terms :: String -> Type -> Type -> [EvTerm]
terms s t1 t2 = [evByFiat s t1 t2]
