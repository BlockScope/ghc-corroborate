module GHC.Corroborate.Constraint (newGiven) where

import GhcApi.Constraint (CtEvidence)
import GHC.Utils.Panic (panicDoc)
import qualified GHC.Tc.Plugin as TcPlugin (newGiven)
import GHC.Corroborate

-- | Create a new [G]iven constraint, with the supplied evidence. This must not
-- be invoked from 'tcPluginInit' or 'tcPluginStop', or it will panic.
newGiven :: CtLoc -> PredType -> EvTerm -> TcPluginM CtEvidence
newGiven loc pty (EvExpr ev) = TcPlugin.newGiven loc pty ev
newGiven _ _  ev = panicDoc "newGiven: not an EvExpr: " (ppr ev)
