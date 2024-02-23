import 'dart:io';
import 'dart:typed_data';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:http/http.dart' as http;

import '../../segregated_data_persistence.dart';

final class DataPersistenceEngine implements IDataPersistenceEngine {
  @override
  Future<PersistedData> persist({required DataInfo data}) async {
    try {
      final dataInBytes = await _getDataBytes(
        uri: data.uri,
        headers: data.headers,
      );
      final persistenceDirectory = await _getPersistenceDirectory();
      final persistedDataPath = join(persistenceDirectory.path, data.fileName);
      final persistedData = File(persistedDataPath);
      return PersistedData(
        content: await persistedData.writeAsBytes(dataInBytes),
        fileName: data.fileName,
      );
    } catch (exception) {
      throw UnableToPersistDataException(reason: exception);
    }
  }

  @override
  Future<Iterable<PersistedData>> persistMultiple({
    required Iterable<DataInfo> elements,
  }) async {
    final persistedDataList = <PersistedData>[];

    for (final data in elements) {
      final persistedData = await persist(data: data);
      persistedDataList.add(persistedData);
    }

    return persistedDataList;
  }

  @override
  Future<Iterable<PersistedData>> getAllData() async {
    try {
      final persistenceDirectory = await _getPersistenceDirectory();
      return persistenceDirectory.listSync().map(
            (data) => PersistedData(
              content: File(data.path),
              fileName: _getFileName(file: data),
            ),
          );
    } catch (exception) {
      throw UnableToGetAllPersistedDataException(reason: exception);
    }
  }

  @override
  Future<PersistedData> getByFileName({
    required String fileName,
  }) async {
    try {
      final persistenceDirectory = await _getPersistenceDirectory();
      final data = persistenceDirectory
          .listSync()
          .firstWhere((file) => _getFileName(file: file) == fileName);
      return PersistedData(
        content: File(data.path),
        fileName: _getFileName(file: data),
      );
    } catch (exception) {
      throw UnableToGetPersistedDataUsingFileNameException(reason: exception);
    }
  }

  @override
  Future<void> clearAllData() async {
    try {
      final persistenceDirectory = await _getPersistenceDirectory();
      await persistenceDirectory.delete(recursive: true);
    } catch (exception) {
      throw UnableToDeletePersistenceDirectoryException(reason: exception);
    }
  }

  @override
  Future<void> deleteByFileName({required String fileName}) async {
    try {
      final data = await getByFileName(fileName: fileName);
      await data.content.delete();
    } catch (exception) {
      throw UnableToDeletePersistedDataException(reason: exception);
    }
  }

  Future<Uint8List> _getDataBytes({
    required Uri uri,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        return response.bodyBytes;
      }

      throw const UnableToGetDataBytesFromUriException();
    } catch (exception) {
      throw UnableToGetDataBytesFromUriException(reason: exception);
    }
  }

  Future<String> _getPersistenceDirectoryName() async {
    const baseName = 'segregated_data_persistence';
    final packageInfo = await PackageInfo.fromPlatform();
    final packageName = packageInfo.packageName;
    return '$baseName@$packageName';
  }

  Future<Directory> _getPersistenceDirectory() async {
    try {
      final temporaryDirectory = await getTemporaryDirectory();
      final persistenceDirectoryName = await _getPersistenceDirectoryName();
      final persistenceDirectoryPath = join(
        temporaryDirectory.path,
        persistenceDirectoryName,
      );
      return Directory(persistenceDirectoryPath).create();
    } catch (exception) {
      throw UnableToGetPersistenceDirectoryException(reason: exception);
    }
  }

  String _getFileName({required FileSystemEntity file}) =>
      file.path.split(Platform.pathSeparator).last;

  @override
  Future<bool> existsByFileName({required String fileName}) async {
    final persistenceDirectory = await _getPersistenceDirectory();
    persistenceDirectory.list().where

  }

  @override
  Future<bool> persistenceDirectoryIsEmpty() {
    // TODO: implement persistenceDirectoryIsEmpty
    throw UnimplementedError();
  }
}
