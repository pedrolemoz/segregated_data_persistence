import '../../segregated_data_persistence.dart';

abstract interface class IDataPersistenceEngine {
  Future<PersistedData> persist({required DataInfo data});

  Future<Iterable<PersistedData>> persistMultiple({
    required Iterable<DataInfo> elements,
  });

  Future<PersistedData> getByFileName({required String fileName});

  Future<Iterable<PersistedData>> getAllData();

  Future<void> clearAllData();

  Future<void> deleteByFileName({required String fileName});

  Future<bool> persistenceDirectoryIsEmpty();

  Future<bool> existsByFileName({required String fileName});
}
