import 'package:flutter/material.dart';
import 'package:ncs/cubits/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncs/screens/splach_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => UserCubit())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const SplachScreen(),
      ),
    );
  }
}
