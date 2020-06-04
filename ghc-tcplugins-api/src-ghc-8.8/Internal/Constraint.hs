module Internal.Constraint (newGiven) where

import GhcApi.Constraint (CtEvidence)
import Panic (panicDoc)
import qualified TcPluginM (newGiven)
import Internal

-- | Create a new [G]iven constraint, with the supplied evidence. This must not
-- be invoked from 'tcPluginInit' or 'tcPluginStop', or it will panic.
newGiven :: CtLoc -> PredType -> EvTerm -> TcPluginM CtEvidence
newGiven loc pty (EvExpr ev) = TcPluginM.newGiven loc pty ev
newGiven _ _  ev = panicDoc "newGiven: not an EvExpr: " (ppr ev)
