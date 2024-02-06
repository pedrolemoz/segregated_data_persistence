import 'dart:io';

import 'package:flutter/material.dart';

import '../segregated_data_persistence.dart';

class PersistedImage extends StatefulWidget {
  final String fileName;
  final Widget Function()? loadingBuilder;

  const PersistedImage({
    super.key,
    required this.fileName,
    this.loadingBuilder,
  });

  @override
  State<PersistedImage> createState() => _PersistedImageState();
}

class _PersistedImageState extends State<PersistedImage> {
  final image = ValueNotifier<File?>(null);

  Future<void> _getImage() async {
    final engine = DataPersistence.of(context).engine;
    final persistedData = await engine.getPersistedDataByFileName(
      fileName: widget.fileName,
    );
    image.value = persistedData.content;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _getImage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: image,
      builder: (context, value, child) {
        return image.value == null
            ? widget.loadingBuilder != null
                ? widget.loadingBuilder!()
                : const CircularProgressIndicator()
            : Image.file(image.value!);
      },
    );
  }
}
