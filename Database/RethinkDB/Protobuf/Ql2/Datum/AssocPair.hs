{-# LANGUAGE BangPatterns, DeriveDataTypeable, FlexibleInstances, MultiParamTypeClasses #-}
module Database.RethinkDB.Protobuf.Ql2.Datum.AssocPair (AssocPair(..)) where
import Prelude ((+), (/))
import qualified Prelude as Prelude'
import qualified Data.Typeable as Prelude'
import qualified Data.Data as Prelude'
import qualified Text.ProtocolBuffers.Header as P'
import qualified Database.RethinkDB.Protobuf.Ql2.Datum as Ql2 (Datum)
 
data AssocPair = AssocPair{key :: !P'.Utf8, val :: !Ql2.Datum}
               deriving (Prelude'.Show, Prelude'.Eq, Prelude'.Ord, Prelude'.Typeable, Prelude'.Data)
 
instance P'.Mergeable AssocPair where
  mergeAppend (AssocPair x'1 x'2) (AssocPair y'1 y'2) = AssocPair (P'.mergeAppend x'1 y'1) (P'.mergeAppend x'2 y'2)
 
instance P'.Default AssocPair where
  defaultValue = AssocPair P'.defaultValue P'.defaultValue
 
instance P'.Wire AssocPair where
  wireSize ft' self'@(AssocPair x'1 x'2)
   = case ft' of
       10 -> calc'Size
       11 -> P'.prependMessageSize calc'Size
       _ -> P'.wireSizeErr ft' self'
    where
        calc'Size = (P'.wireSizeReq 1 9 x'1 + P'.wireSizeReq 1 11 x'2)
  wirePut ft' self'@(AssocPair x'1 x'2)
   = case ft' of
       10 -> put'Fields
       11 -> do
               P'.putSize (P'.wireSize 10 self')
               put'Fields
       _ -> P'.wirePutErr ft' self'
    where
        put'Fields
         = do
             P'.wirePutReq 10 9 x'1
             P'.wirePutReq 18 11 x'2
  wireGet ft'
   = case ft' of
       10 -> P'.getBareMessageWith update'Self
       11 -> P'.getMessageWith update'Self
       _ -> P'.wireGetErr ft'
    where
        update'Self wire'Tag old'Self
         = case wire'Tag of
             10 -> Prelude'.fmap (\ !new'Field -> old'Self{key = new'Field}) (P'.wireGet 9)
             18 -> Prelude'.fmap (\ !new'Field -> old'Self{val = P'.mergeAppend (val old'Self) (new'Field)}) (P'.wireGet 11)
             _ -> let (field'Number, wire'Type) = P'.splitWireTag wire'Tag in P'.unknown field'Number wire'Type old'Self
 
instance P'.MessageAPI msg' (msg' -> AssocPair) AssocPair where
  getVal m' f' = f' m'
 
instance P'.GPB AssocPair
 
instance P'.ReflectDescriptor AssocPair where
  getMessageInfo _ = P'.GetMessageInfo (P'.fromDistinctAscList [10, 18]) (P'.fromDistinctAscList [10, 18])
  reflectDescriptorInfo _
   = Prelude'.read
      "DescriptorInfo {descName = ProtoName {protobufName = FIName \".Ql2.Datum.AssocPair\", haskellPrefix = [MName \"Database\",MName \"RethinkDB\",MName \"Protobuf\"], parentModule = [MName \"Ql2\",MName \"Datum\"], baseName = MName \"AssocPair\"}, descFilePath = [\"Database\",\"RethinkDB\",\"Protobuf\",\"Ql2\",\"Datum\",\"AssocPair.hs\"], isGroup = False, fields = fromList [FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".Ql2.Datum.AssocPair.key\", haskellPrefix' = [MName \"Database\",MName \"RethinkDB\",MName \"Protobuf\"], parentModule' = [MName \"Ql2\",MName \"Datum\",MName \"AssocPair\"], baseName' = FName \"key\"}, fieldNumber = FieldId {getFieldId = 1}, wireTag = WireTag {getWireTag = 10}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 9}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".Ql2.Datum.AssocPair.val\", haskellPrefix' = [MName \"Database\",MName \"RethinkDB\",MName \"Protobuf\"], parentModule' = [MName \"Ql2\",MName \"Datum\",MName \"AssocPair\"], baseName' = FName \"val\"}, fieldNumber = FieldId {getFieldId = 2}, wireTag = WireTag {getWireTag = 18}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 11}, typeName = Just (ProtoName {protobufName = FIName \".Ql2.Datum\", haskellPrefix = [MName \"Database\",MName \"RethinkDB\",MName \"Protobuf\"], parentModule = [MName \"Ql2\"], baseName = MName \"Datum\"}), hsRawDefault = Nothing, hsDefault = Nothing}], keys = fromList [], extRanges = [], knownKeys = fromList [], storeUnknown = False, lazyFields = False}"