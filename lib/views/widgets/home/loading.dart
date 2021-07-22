import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/cubit/login_register_cubit.dart';
import 'package:htb_mobile/data/models/user_response.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Loading Called");
    return BlocBuilder<UserAuthCubit, UserResponse>(
      builder: (context, state) {
        print(state);
        if (state == null) {
          return Scaffold(
            body: Container(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Container(
            child: Text("Success"),
          );
        }
      },
    );
  }
}
