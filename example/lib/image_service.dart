import 'package:segregated_data_persistence/segregated_data_persistence.dart';

class ImageService {
  final IDataPersistenceEngine _persistenceEngine;

  const ImageService(this._persistenceEngine);

  static const _data = [
    (
      'cat.jpg',
      'https://cdn.pixabay.com/photo/2020/11/09/16/21/cat-5727135_1280.jpg'
    ),
    (
      'cat2.jpg',
      'https://cdn.pixabay.com/photo/2014/04/13/20/49/cat-323262_1280.jpg'
    ),
    (
      'flower.jpg',
      'https://cdn.pixabay.com/photo/2023/07/28/20/36/flower-8155951_1280.jpg'
    ),
    (
      'flamingo.jpg',
      'https://cdn.pixabay.com/photo/2024/01/15/14/59/bird-8510323_960_720.jpg'
    ),
    (
      'bird.jpg',
      'https://cdn.pixabay.com/photo/2024/01/08/16/06/bird-8495858_1280.jpg'
    )
  ];

  Future<Iterable<PersistedData>> getImages() async {
    return await _persistenceEngine.persistMultipleData(
      elements: _data.map(
        (record) => DataInfo.fromUrl(
          fileName: record.$1,
          url: record.$2,
        ),
      ),
    );
  }
}
