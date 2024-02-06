class ServiceLocator {
  const ServiceLocator._();

  static final _registeredInstances = <Object>[];

  static void add<T extends Object>(T object) =>
      _registeredInstances.add(object);

  static T get<T extends Object>() => _registeredInstances.whereType<T>().first;
}
