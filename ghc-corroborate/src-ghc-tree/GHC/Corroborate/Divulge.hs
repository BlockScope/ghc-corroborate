module GHC.Corroborate.Divulge (divulgeTyCon, divulgeClass) where

import GHC.Plugins (TyCon, Module, mkTcOcc)
import GHC.TcPluginM.Extra (lookupName )
import GHC.Tc.Plugin (TcPluginM, tcLookupClass, tcLookupTyCon)
import GHC (Class)

divulgeTyCon :: Module -> String -> TcPluginM TyCon
divulgeTyCon md s = tcLookupTyCon =<< lookupName md (mkTcOcc s)

divulgeClass :: Module -> String -> TcPluginM Class
divulgeClass md s = tcLookupClass =<< lookupName md (mkTcOcc s)
