import 'package:example/image_service.dart';
import 'package:example/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:segregated_data_persistence/segregated_data_persistence.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ServiceLocator.add(DataPersistenceEngine());
  ServiceLocator.add(ImageService(ServiceLocator.get<DataPersistenceEngine>()));

  runApp(DataPersistence(child: const App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const InitialPage(),
    );
  }
}

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final images = ValueNotifier<Iterable<PersistedData>>([]);

  Future<void> _getImages() async {
    final imageService = ServiceLocator.get<ImageService>();
    images.value = await imageService.getImages();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _getImages());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Segregated Data Persistence Example')),
      body: ValueListenableBuilder(
        valueListenable: images,
        builder: (context, value, child) {
          if (value.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              final image = value.elementAt(index);
              return PersistedImage(fileName: image.fileName);
            },
          );
        },
      ),
    );
  }
}
