import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncs/constants/Appstyle.dart';
import 'package:ncs/cubits/user_cubit.dart';
import 'package:ncs/cubits/user_state.dart';
import 'package:ncs/screens/login_page.dart';
import 'package:ncs/screens/tabs.dart';

class SplachScreen extends StatelessWidget {
  const SplachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.backgroundColor,
      body: SafeArea(
        child: Center(
          child: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserLoading) {
                return CircularProgressIndicator(
                  color: AppStyle.maincolor,
                );
              } else if (state is UserLoggedIn) {
                return Tabs();
              } else if (state is UserError) {
                return Text(
                  'Error: ${state.message}',
                  style: TextStyle(fontSize: 24, color: Colors.red),
                );
              } else if (state is UserInitial) {
                return LoginPage();
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
