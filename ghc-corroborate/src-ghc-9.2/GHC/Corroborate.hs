{-# OPTIONS_GHC -fno-warn-missing-signatures #-}

-- | The GHC API changes over time. This module re-exports most GHC imports
-- needed by typechecker plugins and has a stable API over multiple GHC
-- versions.
module GHC.Corroborate
    (
      -- * Imports from
      -- ** GHC.Plugins
      module GHC.Plugins
      -- ** GHC.Tc.Types.Constraint
    , module GHC.Tc.Types.Constraint
      -- ** GHC.Core.Predicate
    , module GHC.Core.Predicate
      -- ** GHC.Tc.Types.Evidence
    , module GHC.Tc.Types.Evidence
      -- ** GHC.Tc.Plugin
    , module GHC.Tc.Plugin
      -- ** GHC.Tc.Types
    , module GHC.Tc.Types
      -- ** GHC.Tc.Utils.TcType
    , module GHC.Tc.Utils.TcType
      -- ** GHC.Core.Type
    , module GHC.Core.Type
      -- ** GHC.Core.TyCo.Rep
    , module GHC.Core.TyCo.Rep
      -- ** GHC.Types.Unique
    , module GHC.Types.Unique
      -- ** GHC.TcPluginM.Extra
    , module GHC.TcPluginM.Extra
      -- ** GHC.Builtin.Types
    , module GHC.Builtin.Types
      -- ** GHC.Builtin.Types.Literals
    , module GHC.Builtin.Types.Literals
      -- ** GHC
    , module GHC
      -- ** GHC.Data.IOEnv
    , module GHC.Data.IOEnv
      -- * Alternatives
    , tcLookupClass, tcLookupTyCon, lookupOrig
    ) where

import Prelude hiding ((<>))

import GHC.Plugins
    ( Plugin(..), PluginRecompile(..)
    , defaultPlugin, purePlugin, impurePlugin, flagRecompile
    , PredType, FastString(..), Role(..), TyCoVarSet, ModuleName, Module
    , Kind, TyVar, Var, Id, DFunId, Coercion, TyCon(..), Outputable(..)
    , (<>), (<+>), ($$)
    , isNumLitTy, isStrLitTy, isFamilyTyCon
    , mkNumLitTy, mkStrLitTy
    , mkTyConApp, mkTcTyVar, mkPrimEqPred, mkTyVarTy, isTcTyVar
    , dataConName, dataConWrapId, promoteDataCon
    , heqTyCon, heqDataCon
    , consDataCon, nilDataCon
    , typeKind, typeSymbolKind, typeSymbolKindCon, tyVarKind
    , tyCoVarsOfType, tyCoVarsOfTypes, tyConDataCons
    , mkModuleName, mkSysTvName
    , getOccName, occName, occNameFS, mkTcOcc, occNameString
    , text, fsLit, unpackFS, showSDocUnsafe
    , tcSplitTyConApp_maybe, splitTyConApp_maybe
    , nonDetCmpType, nonDetCmpTypes, thenCmp, getUnique
    , mkUnivCo, elemVarSet, coreView
    , boolTyCon, promotedTrueDataCon, promotedFalseDataCon
    , getTyVar_maybe, splitTyConApp_maybe, splitFunTy_maybe
    )
import GHC.Tc.Types.Constraint
    ( Ct(..), CtLoc
    , ctLoc, ctEvidence, ctPred, ctEvPred
    , isGiven, isWanted, isGivenCt
    , mkNonCanonical, WantedConstraints
    )
import GHC.Core.Predicate (Pred(..), EqRel(..), classifyPredType)
import GHC.Tc.Types.Evidence (EvTerm(..), TcCoercion, TcCoercionR, EvExpr, evCast, evDFunApp)
import GHC.Tc.Plugin
    ( TcPluginM, FindResult(..)
    , unsafeTcPluginTcM, tcPluginIO, tcPluginTrace, findImportedModule
    , matchFam, newFlexiTyVar, zonkCt, newUnique, isTouchableTcPluginM
    )
import qualified GHC.Tc.Plugin as TcPlugin (tcLookupClass, tcLookupTyCon, lookupOrig)
import GHC.Tc.Types (TcPlugin(..), TcPluginResult(..))
import GHC.Tc.Utils.TcType (vanillaSkolemTv, tcGetTyVar_maybe, isMetaTyVar)
import GHC.Core.TyCo.Rep (UnivCoProvenance(PluginProv), Type(..), cmpTyLit)
import GHC.Core.Type (nonDetCmpTc)
import GHC.Types.Unique (nonDetCmpUnique)
import GHC.TcPluginM.Extra (evByFiat, tracePlugin, lookupModule, lookupName )
import GHC.Builtin.Types (naturalTyCon, naturalTy)
import GHC.Builtin.Types.Literals (typeNatAddTyCon, typeNatSubTyCon)
import GHC (Class)
import GHC.Data.IOEnv (newMutVar, readMutVar, writeMutVar)

{-# DEPRECATED tcLookupClass "Use 'GHC.Corroborate.Divulge.divulgeClass' instead" #-}
tcLookupClass = TcPlugin.tcLookupClass

{-# DEPRECATED tcLookupTyCon "Use 'GHC.Corroborate.Divulge.divulgeTyCon' instead" #-}
tcLookupTyCon = TcPlugin.tcLookupTyCon

{-# DEPRECATED lookupOrig "Use 'lookupName' instead" #-}
lookupOrig = TcPlugin.lookupOrig
