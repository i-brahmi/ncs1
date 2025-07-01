import 'package:flutter/foundation.dart';
import 'package:ncs/models/user_model.dart';


@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoggedIn extends UserState {
  UserLoggedIn(this.userData);
  final User userData;
}

class UserLoggedOut extends UserState {}

class UserError extends UserState {
  UserError(this.message);
  final String message;
}


