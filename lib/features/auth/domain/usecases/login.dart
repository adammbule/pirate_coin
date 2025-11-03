import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  Future<User> call(String email, String password) async {
    final user = await authRepository.login(email, password);
    return user;
  }
}
