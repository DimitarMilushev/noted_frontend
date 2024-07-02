import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/browser.dart';
import 'package:dio/dio.dart';

part 'dio.provider.g.dart';

@Riverpod(keepAlive: true)
Dio dio(DioRef ref) {
  late final Dio instance;
  if (kIsWeb) {
    instance = DioForBrowser(_qaOptions)
      ..options.extra['withCredentials'] = true;
  } else {
    instance = Dio(_qaOptions)..interceptors.add(CookieManager(CookieJar()));
  }

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
