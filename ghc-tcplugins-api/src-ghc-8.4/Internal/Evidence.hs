module Internal.Evidence (evDFunApp', evCast', terms) where

import Internal

evDFunApp' :: DFunId -> [Type] -> [EvTerm] -> EvTerm
evDFunApp' = EvDFunApp

evCast' :: EvTerm -> TcCoercionR -> EvTerm
evCast' = EvCast

terms :: Type -> Type -> [EvTerm]
terms t1 t2 = [evByFiat "units" t1 t2]
