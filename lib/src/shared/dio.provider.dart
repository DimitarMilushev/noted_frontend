import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio.provider.g.dart';

@Riverpod(keepAlive: true)
Dio dio(DioRef ref) {
  final instance = Dio(_qaOptions)
    ..interceptors.addAll([
      // HttpInterceptor(ref),
    ]);

  // instance.interceptors.add(ref.read(cookieManagerProvider));
  return instance;
}

final _qaOptions = BaseOptions(
  baseUrl: dotenv.get("APP_URI"),
  contentType: "application/json",
  responseType: ResponseType.json,
  receiveTimeout: const Duration(seconds: 8),
  connectTimeout: const Duration(seconds: 5),
);

class HttpInterceptor implements Interceptor {
  final Ref ref;
  HttpInterceptor(this.ref);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.error != null) {
      print(err.error);
      print(err.message);
    }

    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('Request');
    print(options.extra);
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('response');
    print(response.data);

    handler.next(response);
  }
}