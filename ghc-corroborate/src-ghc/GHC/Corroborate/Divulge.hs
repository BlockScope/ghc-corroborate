module GHC.Corroborate.Divulge (divulgeTyCon, divulgeClass) where

import GHC.Corroborate

divulgeTyCon :: Module -> String -> TcPluginM TyCon
divulgeTyCon md s = tcLookupTyCon =<< lookupName md (mkTcOcc s)

divulgeClass :: Module -> String -> TcPluginM Class
divulgeClass md s = tcLookupClass =<< lookupName md (mkTcOcc s)
