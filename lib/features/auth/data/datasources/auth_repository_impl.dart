
import 'package:Piratecoin/features/auth/domain/repositories/auth_repository.dart';
import 'package:Piratecoin/features/auth/domain/entities/user.dart';
import 'package:Piratecoin/features/auth/data/datasources/auth_remote_datasource.dart';
import '../../../../../services/storage/secure_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final SecureStorage storage;

  AuthRepositoryImpl({
    required this.remote,
    required this.storage,
  });

  @override
  Future<User> login(String email, String password) async {
    // Remote already returns a User
    final user = await remote.login(email, password);

    final token = user.token ?? '';
    final userid = user.userid ?? '';
    final username = user.username ?? '';

    // Save token & other info securely
    await storage.saveToken(token);
    await storage.saveUsername(username);
    await storage.saveUserid(userid);

    return user;
  }

  @override
  Future<User?> getCurrentUser() async {
    final token = await storage.getToken();
    final username = await storage.getUsername();
    final userid = await storage.getUserid();

    if (token == null || token.isEmpty) return null;

    return User(
      token: token,
      username: username,
      userid: userid,
    );
  }

  @override
  Future<void> logout(String token) async {
    await remote.logout(token);
    await storage.clearToken();
  }
}
