import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_demo/core/service_locater/service_locator.dart';
import 'package:flutter_cubit_demo/feature/home_screen/controller/counter_cubit.dart';
import 'package:flutter_cubit_demo/feature/home_screen/controller/list_cubit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  // todo:Cubit
  final CounterCubit counterCubit = ServiceLocator.getIt<CounterCubit>();
  final ListCubit listCubit = ServiceLocator.getIt<ListCubit>();

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: counterCubit,
      child: BlocBuilder<CounterCubit, int>(
        builder: (context, state) {
          _counter = state;

          return Scaffold(
            backgroundColor: Color.fromARGB(255, state, 106, 106),
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(widget.title),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '$state',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: "${_counter + 1}",
                  onPressed: () => counterCubit.increment(),
                  child: const Icon(Icons.add),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    if (_counter >= 1) {
                      counterCubit.decrement();
                    }
                  },
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void getData() {
    log("${listCubit.state}");
  }
}
