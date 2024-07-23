import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noted_frontend/src/auth/presentation/views/sign-in.view.dart';
import 'package:noted_frontend/src/shared/constants/environment.constants.dart';
import 'package:noted_frontend/src/shared/dtos/api-exception.dto.dart';
import 'package:noted_frontend/src/shared/providers/auth/session.provider.dart';
import 'package:noted_frontend/src/shared/router.provider.dart';
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
  instance.interceptors.add(HttpInterceptor(ref));
  return instance;
}

final _qaOptions = BaseOptions(
  baseUrl: EnvironmentConstants.appURI,
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
    if (err.response?.data != null) {
      final data = ApiExceptionDto.fromJson(err.response?.data);
      if (_shouldAuthenticate(data.status)) handleUnauthencated();
    }

    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  bool _shouldAuthenticate(int statusCode) {
    return statusCode == HttpStatus.unauthorized &&
        ref.read(sessionProvider.notifier).isLoggedIn;
  }

  void handleUnauthencated() {
    ref.read(sessionProvider.notifier).endSession();
    ref.read(routerProvider).go(SignInView.route);
  }
}
