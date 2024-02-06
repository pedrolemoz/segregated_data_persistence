import 'dart:io';

final class PersistedData {
  final String fileName;
  final File content;

  const PersistedData({required this.content, required this.fileName});
}
