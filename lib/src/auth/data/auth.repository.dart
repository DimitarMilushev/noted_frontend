import 'package:dio/dio.dart';
import 'package:noted_frontend/src/auth/data/dto/sign-in.dto.dart';
import 'package:noted_frontend/src/auth/data/dto/sign-in.response.dart';
import 'package:noted_frontend/src/auth/data/dto/sign-up.dto.dart';
import 'package:noted_frontend/src/shared/dio.provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "auth.repository.g.dart";

@Riverpod()
AuthRepository authRepository(AuthRepositoryRef ref) => AuthRepository(
      client: ref.read(dioProvider),
    );

class AuthRepository {
  final Dio _client;
  AuthRepository({required Dio client}) : _client = client;

  Future<SignInResponse> signIn(String email, String password) async {
    final signInDto = SignInDto(email: email, password: password);
    final response =
        await _client.post('/api/v1/auth/sign-in', data: signInDto.toJson());
    return SignInResponse.fromJson(response.data);
  }

  Future<void> signUp({
    required String email,
    required String username,
    required String password,
  }) async {
    final signUpDto = SignUpDto(
      email: email,
      username: username,
      password: password,
    );

    await _client.post('/api/v1/auth/sign-up', data: signUpDto.toJson());
  }

  Future<void> signOut() async {
    await _client.get('/api/v1/auth/sign-out');
  }
}
