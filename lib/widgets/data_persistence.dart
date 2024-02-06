import 'package:flutter/material.dart';

import '../segregated_data_persistence.dart';

class DataPersistence extends InheritedWidget {
  final IDataPersistenceEngine engine = DataPersistenceEngine();

  DataPersistence({super.key, required super.child});

  static DataPersistence? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DataPersistence>();
  }

  static DataPersistence of(BuildContext context) {
    final DataPersistence? result = maybeOf(context);
    assert(result != null, 'No SegregatedDataPersistenceRoot found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
