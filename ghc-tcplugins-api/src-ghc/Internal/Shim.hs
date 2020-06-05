module Internal.Shim
    ( tyVarsOfType
    , tyVarsOfTypes
    , promoteTyCon
    , mkEqPred
    , mkHEqPred
    , mkFunnyEqEvidence
    ) where

import Internal
import Internal.Evidence (evDFunApp', evCast', terms)

tyVarsOfType :: Type -> TyCoVarSet
tyVarsOfType = tyCoVarsOfType

tyVarsOfTypes :: [Type] -> TyCoVarSet
tyVarsOfTypes = tyCoVarsOfTypes

promoteTyCon :: TyCon -> TyCon
promoteTyCon = id

mkEqPred :: Type -> Type -> Type
mkEqPred = mkPrimEqPred

mkHEqPred :: Type -> Type -> Type
mkHEqPred t1 t2 = TyConApp heqTyCon [typeKind t1, typeKind t2, t1, t2]

-- | Make up evidence for a fake equality constraint @t1 ~~ t2@ by
-- coercing bogus evidence of type @t1 ~ t2@ (or its heterogeneous
-- variant, in GHC 8.0).
mkFunnyEqEvidence :: String -> Type -> Type -> Type -> EvTerm
mkFunnyEqEvidence s t t1 t2 =
    castFrom `evCast'` castTo
    where
        castFrom :: EvTerm
        castFrom = evDFunApp' funId tys $ terms s t1 t2
            where
                funId :: Id
                funId = dataConWrapId heqDataCon

                tys :: [Kind]
                tys = [typeKind t1, typeKind t2, t1, t2]

        castTo :: TcCoercion
        castTo =
            mkUnivCo from Representational tySource t
            where
                from :: UnivCoProvenance
                from = PluginProv s

                tySource :: Type
                tySource = mkHEqPred t1 t2
