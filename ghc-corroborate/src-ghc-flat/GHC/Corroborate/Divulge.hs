module GHC.Corroborate.Divulge (divulgeTyCon, divulgeClass) where

import GhcPlugins (TyCon, Module, mkTcOcc)
import GHC.TcPluginM.Extra (lookupName )
import TcPluginM (TcPluginM, tcLookupClass, tcLookupTyCon)
import Class (Class)

divulgeTyCon :: Module -> String -> TcPluginM TyCon
divulgeTyCon md s = tcLookupTyCon =<< lookupName md (mkTcOcc s)

divulgeClass :: Module -> String -> TcPluginM Class
divulgeClass md s = tcLookupClass =<< lookupName md (mkTcOcc s)
