module Internal
    ( module GhcPlugins
    , module Constraint
    , module Predicate
    , module TcEvidence
    , module TcPluginM
    , module TcRnTypes
    , module TcType
    , module TyCoRep
    , module Unique
    , module GHC.TcPluginM.Extra
    , module TcTypeNats
    , module Class
    , module IOEnv
    ) where

import GhcPlugins
    ( PredType, FastString(..), Role(..), TyCoVarSet, Plugin(..), ModuleName, Module
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
    , defaultPlugin, mkUnivCo, elemVarSet, coreView
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
import TcEvidence (EvTerm(..), TcCoercion, TcCoercionR)
import TcPluginM
    ( TcPluginM, unsafeTcPluginTcM, tcPluginIO, tcPluginTrace
    , matchFam, newFlexiTyVar, zonkCt, newUnique, isTouchableTcPluginM
    , tcLookupClass, tcLookupTyCon, findImportedModule, lookupOrig
    )
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
