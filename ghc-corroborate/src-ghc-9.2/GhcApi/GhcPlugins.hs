{-# OPTIONS_GHC -fno-warn-dodgy-imports #-}

module GhcApi.GhcPlugins (module GHC.Tc.Plugin) where

import GHC.Tc.Plugin hiding (TcPlugin, mkSubst)
