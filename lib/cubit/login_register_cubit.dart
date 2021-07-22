import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/data/models/user_response.dart';
import 'package:htb_mobile/services/userAuthService.dart';


class UserAuthCubit extends Cubit<UserResponse> {
  final _service = UserAuthService();

  UserAuthCubit() : super(UserResponse());

  void userLogin(username, password) async =>
      emit(await _service.userLogin(username, password));
}
