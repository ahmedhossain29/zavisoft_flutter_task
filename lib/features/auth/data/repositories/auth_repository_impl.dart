import '../../domain/repositories/auth_repository.dart';
import '../datasource/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<String> login(String username, String password) {
    return remote.login(username: username, password: password);
  }
}