import 'package:equatable/equatable.dart';
import 'package:Piratecoin/features/auth/domain/entities/user.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;
  final String token;
  final String username;
  final String userid;

  AuthAuthenticated(
      {required this.user,
      required this.token,
      required this.username,
      required this.userid});

  @override
  List<Object?> get props => [user, token, username, userid];
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}
