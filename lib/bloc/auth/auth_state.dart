part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class NoneAuthState extends AuthState {}

class GoogleSignInSuccessState extends AuthState {}

class GoogleSignInFailState extends AuthState {
  final dynamic error;
  GoogleSignInFailState(this.error);
}
