import 'package:flutter/material.dart';

import '../segregated_data_persistence.dart';

class DataPersistence extends InheritedWidget {
  late final IDataPersistenceEngine engine;

  DataPersistence({
    super.key,
    IDataPersistenceEngine? engine,
    required super.child,
  }) : engine = engine ?? DataPersistenceEngine();

  static DataPersistence? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DataPersistence>();
  }

  static DataPersistence of(BuildContext context) {
    final DataPersistence? result = maybeOf(context);
    assert(result != null, 'No DataPersistence found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
