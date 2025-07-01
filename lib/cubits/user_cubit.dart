import 'package:bloc/bloc.dart';
import 'package:ncs/cubits/user_state.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ncs/models/user_model.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  late User user;
  Future<void> login(String email, String password) async {
    emit(UserLoading());

    final url = Uri.parse('https://ncs-bpb4.onrender.com/auth/login');
    try {
      final response = await http.post(
        url,
        body: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        user = User.fromJson(data['data']);
        emit(UserLoggedIn(user));
      } else {
        emit(UserError('Failed to login'));
      }
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }

  Future<void> signup(
    String email,
    String firstname,
    String lastname,
    String password,
    String confirmPassword,
  ) async {
    emit(UserLoading());

    final url = Uri.parse('https://ncs-bpb4.onrender.com/auth/register');
    try {
      final response = await http.post(
        url,
        body: {
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
          'firstName': firstname,
          'lastName': lastname,
        },
      );

      if (password != confirmPassword) {
        emit(UserError('Passwords do not match'));
        return;
      }

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        user = User.fromJson(data['data']);
        emit(UserLoggedIn(user));
      } else if (response.statusCode == 400) {
      } else {
        emit(UserError('Failed to signup'));
      }
    } catch (error) {
      emit(UserError(error.toString()));
    } finally {}
  }

  Future<void> logout() async {
    emit(UserLoading());
    try {
      // Simulate a network call
      await Future.delayed(Duration(seconds: 1));
      user = User(
        id: '',
        email: '',
        firstName: '',
        lastName: '',
        profilePictureUrl: '',
        points: 0,
      );
      emit(UserInitial());
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }
}
