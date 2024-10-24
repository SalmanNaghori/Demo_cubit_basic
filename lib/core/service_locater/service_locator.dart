import 'package:flutter_cubit_demo/feature/home_screen/controller/counter_cubit.dart';
import 'package:flutter_cubit_demo/feature/home_screen/controller/list_cubit.dart';
import 'package:get_it/get_it.dart';

class ServiceLocator {
  static final getIt = GetIt.instance;
  static void setupLocator() {
    getIt.registerLazySingleton(() => CounterCubit());
    getIt.registerLazySingleton(() => ListCubit());
  }
}
