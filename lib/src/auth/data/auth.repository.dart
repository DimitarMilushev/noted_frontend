import 'package:dio/dio.dart';
import 'package:noted_frontend/src/auth/data/dto/sign-in.dto.dart';
import 'package:noted_frontend/src/shared/dio.provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "auth.repository.g.dart";

@Riverpod()
AuthRepository authRepository(AuthRepositoryRef ref) => AuthRepository(
      client: ref.read(dioProvider),
    );

class AuthRepository {
  final Dio client;
  AuthRepository({required this.client});

  Future<void> signIn(String email, String password) async {
    final signInDto = SignInDto(email: email, password: password);
    // final response =
    //     await client.post('/api/v1/auth/sign-in', data: signInDto.toJson());
    // print(response);
    // return UserSessionModel.fromJson(response.data);
    // return UserSessionModel(email: email, role: "User");
  }

  Future<void> signUp({
    required String email,
    required String username,
    required String password,
  }) {
    throw UnimplementedError();
  }

  Future<void> signOut() => client.get('/api/auth/sign-out');
}
