
import 'package:dio/dio.dart';
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
    throw DioException.badResponse(statusCode: 401, requestOptions: RequestOptions(), response: Response(
      requestOptions: RequestOptions(),
      data: "rip"));
    // final signInDto = SignInDto(email: email, password: password);
    // final response = await client.post('/api/auth/sign-in', data: signInDto.toJson());
    // return UserSessionModel.fromJson(response.data);
    // return UserSessionModel(email: email, role: "User");
  }

  Future<void> signOut() => client.get('/api/auth/sign-out');
}