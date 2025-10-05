import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Piratecoin/features/auth/presentation/bloc/auth_event.dart';
import 'package:Piratecoin/features/auth/presentation/bloc/auth_state.dart';
import 'package:Piratecoin/features/auth/domain/repositories/auth_repository.dart';
import 'package:Piratecoin/services/storage/secure_storage.dart';
import 'package:Piratecoin/features/auth/domain/entities/user.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final SecureStorage storage;

  AuthBloc({required this.authRepository, required this.storage})
      : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      // Call repository → returns real user with id, username, token
      final User user = await authRepository.login(
        event.email,
        event.password,
      );

      final token = user.token ?? '';
      final userid = user.userid ?? '';
      final username = user.username ?? '';

      // Save token securely
      await storage.saveToken(token);
      await storage.saveUsername(username);
      await storage.saveUserid(userid);

      // Emit authenticated state with real user
      emit(AuthAuthenticated(
          user: user, //,
          token: user.token ?? '',
          username: user.username ?? '',
          userid: user.userid ?? ''));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
      LogoutRequested event, Emitter<AuthState> emit) async {
    await storage.clearToken();
    emit(AuthInitial());
  }
}
