import 'dart:math';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_demo/core/service_locater/service_locator.dart';
import 'package:flutter_cubit_demo/feature/home_screen/controller/list_cubit.dart';
import 'package:flutter_cubit_demo/feature/home_screen/model/user_model.dart';

class ListExample extends StatefulWidget {
  const ListExample({super.key});

  @override
  State<ListExample> createState() => _ListExampleState();
}

class _ListExampleState extends State<ListExample> {
  // Todo: Cubit
  ListCubit listCubit = ServiceLocator.getIt<ListCubit>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() {
    dev.log("${listCubit.state}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: BlocProvider.value(
        value: listCubit,
        child: BlocBuilder<ListCubit, List<User>>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: state.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.length,
                      itemBuilder: (context, index) {
                        final user = state[index];
                        return ListTile(
                          leading: CircleAvatar(
                            child: Text("${index + 1}"),
                          ),
                          title: Text('${user.name} (${user.gender})'),
                          subtitle: Text('Number: ${user.number}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    _showUserDialog(user: user);
                                    getData();
                                  }),
                              IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    listCubit.removeUser(user.id);
                                    getData();
                                  }),
                            ],
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        "No Data....",
                        style: TextStyle(color: Colors.black, fontSize: 24),
                      ),
                    ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showUserDialog(),
        tooltip: 'Add User',
        child: const Icon(Icons.add),
      ),
    );
  }

  _showUserDialog({User? user}) {
    final TextEditingController nameController = TextEditingController(text: user?.name ?? '');
    final TextEditingController numberController = TextEditingController(text: user?.number ?? '');
    final TextEditingController genderController = TextEditingController(text: user?.gender ?? '');

    final bool isEdit = user != null;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEdit ? 'Edit User' : 'Add User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: numberController,
                decoration: const InputDecoration(labelText: 'Number'),
              ),
              TextField(
                controller: genderController,
                decoration: const InputDecoration(labelText: 'Gender'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (isEdit) {
                  // Editing existing user
                  listCubit.editUser(User(
                    id: user.id,
                    name: nameController.text,
                    number: numberController.text,
                    gender: genderController.text,
                  ));
                  getData();
                } else {
                  // Adding new user
                  listCubit.addUser(User(
                    id: Random().nextInt(1000), // Generate a random id for simplicity
                    name: nameController.text,
                    number: numberController.text,
                    gender: genderController.text,
                  ));
                  getData();
                }
                Navigator.of(context).pop();
              },
              child: Text(isEdit ? 'Save' : 'Add'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
