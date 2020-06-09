{-# OPTIONS_GHC -fno-warn-missing-signatures #-}

-- | The GHC API changes over time. This module re-exports most GHC imports
-- needed by typechecker plugins and has a stable API over multiple GHC
-- versions.
module GHC.Corroborate
    (
      -- * Imports from
      -- ** GhcPlugins
      module GhcPlugins
      -- ** Constraint
    , module Constraint
      -- ** Predicate
    , module Predicate
      -- ** TcEvidence
    , module TcEvidence
      -- ** TcPluginM
    , module TcPluginM
      -- ** TcRnTypes
    , module TcRnTypes
      -- ** TcType
    , module TcType
      -- ** TyCoRep
    , module TyCoRep
      -- ** Unique
    , module Unique
      -- ** GHC.TcPluginM.Extra
    , module GHC.TcPluginM.Extra
      -- ** TcTypeNats
    , module TcTypeNats
      -- ** Class
    , module Class
      -- ** IOEnv
    , module IOEnv
      -- * Alternatives
    , tcLookupClass, tcLookupTyCon, lookupOrig
    ) where

import Prelude hiding ((<>))

import GhcPlugins
    ( Plugin(..), PluginRecompile(..)
    , defaultPlugin, purePlugin, impurePlugin, flagRecompile
    , PredType, FastString(..), Role(..), TyCoVarSet, ModuleName, Module
    , Kind, TyVar, Var, Id, DFunId, Coercion, TyCon(..), Outputable(..), FindResult(..)
    , (<>), (<+>), ($$)
    , isNumLitTy, isStrLitTy, isFamilyTyCon
    , mkNumLitTy, mkStrLitTy
    , mkTyConApp, mkTcTyVar, mkPrimEqPred, mkTyVarTy, isTcTyVar
    , dataConName, dataConWrapId, promoteDataCon
    , heqTyCon, heqDataCon
    , consDataCon, nilDataCon
    , typeKind, typeSymbolKind, typeSymbolKindCon, typeNatKindCon, tyVarKind
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
import Constraint
    ( Ct(..), CtLoc
    , ctLoc, ctEvidence, ctPred, ctEvPred
    , isGiven, isWanted, isGivenCt
    , mkNonCanonical
    )
import Predicate (PredTree(..), EqRel(..), classifyPredType)
import TcEvidence (EvTerm(..), TcCoercion, TcCoercionR, EvExpr, evCast, evDFunApp)
import TcPluginM
    ( TcPluginM, unsafeTcPluginTcM, tcPluginIO, tcPluginTrace, findImportedModule
    , matchFam, newFlexiTyVar, zonkCt, newUnique, isTouchableTcPluginM
    )
import qualified TcPluginM (tcLookupClass, tcLookupTyCon, lookupOrig)
import TcRnTypes (TcPlugin(..), TcPluginResult(..), WantedConstraints)
import TcType (vanillaSkolemTv, tcGetTyVar_maybe, isMetaTyVar)
import TyCoRep
    ( UnivCoProvenance(PluginProv)
    , Type(TyConApp, TyVarTy, AppTy, ForAllTy, FunTy)
    )
import Unique (nonDetCmpUnique)
import GHC.TcPluginM.Extra (evByFiat, tracePlugin, lookupModule, lookupName )
import TcTypeNats (typeNatAddTyCon, typeNatSubTyCon)
import Class (Class)
import IOEnv (newMutVar, readMutVar, writeMutVar)

{-# DEPRECATED tcLookupClass "Use 'GHC.Corroborate.Divulge.divulgeClass' instead" #-}
tcLookupClass = TcPluginM.tcLookupClass

{-# DEPRECATED tcLookupTyCon "Use 'GHC.Corroborate.Divulge.divulgeTyCon' instead" #-}
tcLookupTyCon = TcPluginM.tcLookupTyCon

{-# DEPRECATED lookupOrig "Use 'lookupName' instead" #-}
lookupOrig = TcPluginM.lookupOrig
