import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_demo/feature/home_screen/model/user_model.dart';

class ListCubit extends Cubit<List<User>> {
  ListCubit() : super([]);

  void addUser(User user) {
    final updateList = List<User>.from(state)..add(user);
    emit(updateList); // Emit the new state
  }

  void removeUser(int userId) {
    final updatedList = state.where((user) => user.id != userId).toList();
    emit(updatedList);
  }

  void editUser(User updateUser) {
    final currentUser = state.map((user) {
      return user.id == updateUser.id ? updateUser : user;
    }).toList();
    emit(currentUser);
  }
}
