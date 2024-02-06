import '../../segregated_data_persistence.dart';

abstract interface class IDataPersistenceEngine {
  Future<PersistedData> persistData({required DataInfo data});

  Future<Iterable<PersistedData>> persistMultipleData({
    required Iterable<DataInfo> elements,
  });

  Future<PersistedData> getPersistedDataByFileName({required String fileName});

  Future<Iterable<PersistedData>> getAllPersistedData();

  Future<void> clearAllPersistedData();

  Future<void> deletePersistedDataByFileName({required String fileName});
}
