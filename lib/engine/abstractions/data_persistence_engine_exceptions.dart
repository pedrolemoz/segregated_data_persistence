abstract class DataPersistenceEngineException implements Exception {
  final Object? reason;

  const DataPersistenceEngineException({this.reason});
}

class UnableToGetDataBytesFromUriException
    extends DataPersistenceEngineException {
  const UnableToGetDataBytesFromUriException({super.reason});
}

class UnableToPersistDataException extends DataPersistenceEngineException {
  const UnableToPersistDataException({super.reason});
}

class UnableToGetPersistedDataUsingFileNameException
    extends DataPersistenceEngineException {
  const UnableToGetPersistedDataUsingFileNameException({super.reason});
}

class UnableToGetAllPersistedDataException
    extends DataPersistenceEngineException {
  const UnableToGetAllPersistedDataException({super.reason});
}

class UnableToGetPersistenceDirectoryException
    extends DataPersistenceEngineException {
  const UnableToGetPersistenceDirectoryException({super.reason});
}

class UnableToDeletePersistenceDirectoryException
    extends DataPersistenceEngineException {
  const UnableToDeletePersistenceDirectoryException({super.reason});
}

class UnableToDeletePersistedDataException
    extends DataPersistenceEngineException {
  const UnableToDeletePersistedDataException({super.reason});
}
