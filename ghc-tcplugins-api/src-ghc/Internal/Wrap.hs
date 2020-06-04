module Internal.Wrap (newUnique, newWantedCt, newGivenCt) where

import Internal
import GHC.TcPluginM.Extra (newGiven, newWanted)

newWantedCt :: CtLoc -> PredType -> TcPluginM Ct
newWantedCt loc = fmap mkNonCanonical . newWanted loc

newGivenCt :: CtLoc -> PredType -> EvTerm -> TcPluginM Ct
newGivenCt loc prd ev = mkNonCanonical <$> newGiven loc prd ev
