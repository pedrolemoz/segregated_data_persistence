final class DataInfo {
  final String fileName;
  final Uri uri;
  final Map<String, String>? headers;

  const DataInfo({
    required this.fileName,
    required this.uri,
    this.headers = const {},
  });

  factory DataInfo.fromUrl({
    required String url,
    required String fileName,
    Map<String, String>? headers,
  }) =>
      DataInfo(fileName: fileName, uri: Uri.parse(url), headers: headers);
}
