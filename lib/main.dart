import 'package:flutter/material.dart';
import 'package:flutter_cubit_demo/core/service_locater/service_locator.dart';
import 'package:flutter_cubit_demo/feature/home_screen/view/list.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await requiredInitialization();
  runApp(const MyApp());
}

requiredInitialization() {
  ServiceLocator.setupLocator();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ListExample(),
      ),
    );
  }
}
