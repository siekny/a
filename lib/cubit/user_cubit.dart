import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/data/models/user.dart';
import 'package:htb_mobile/services/user_service.dart';

abstract class UserState {}

class LoadingUser extends UserState {}

class UserSuccess extends UserState {
  final User user;

  UserSuccess({this.user});
}

class UserFailure extends UserState {
  final Exception exception;

  UserFailure({this.exception});
}

class UserCubit extends Cubit<UserState> {
  final _service = UserService();

  UserCubit() : super(LoadingUser());

  void getUser() async {
    if (state is UserSuccess == false) {
      emit(LoadingUser());
    }
    try {
      final user = await _service.getUser();
      emit(UserSuccess(user: user));
    } catch (e) {
      emit(UserFailure(exception: e));
    }
  }

  void updateUser(user) async {
    await _service.updateUser(user);
    getUser();
  }
}
