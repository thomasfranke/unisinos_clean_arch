import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_arch_riverpod/infrastructure/api_client/api_client_interface.dart';
import 'package:flutter_clean_arch_riverpod/infrastructure/api_client/models/api_route.dart';
import 'package:flutter_clean_arch_riverpod/infrastructure/api_client/models/http_methods.dart';
import 'package:flutter_clean_arch_riverpod/infrastructure/api_client/models/response.dart';

/// Implementation of [ApiClientInterface] using the dio package.
class ApiClientDioImpl implements ApiClientInterface {
  /// Creates an instance of [ApiClientDioImpl] with the provided
  /// [dio] instance.
  ApiClientDioImpl({required this.dio});

  /// Dio instance used to make HTTP requests.
  final Dio dio;

  @override
  Future<ApiResponse<dynamic>> request({
    required final ApiRoute apiRoute,
    final String? customBaseUrl,
    final Object? data,
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final CancelToken? cancelToken,
    final void Function(double progress)? onProgress,
  }) async {
    try {
      late final Response<dynamic> response;

      final String endpoint = customBaseUrl != null
          ? Uri.parse(customBaseUrl).resolve(apiRoute.path).toString()
          : apiRoute.path;

      log('Request | ${apiRoute.method} -> $endpoint', name: 'APICLIENT');

      switch (apiRoute.method) {
        case HttpMethod.get:
          response = await dio.get(
            endpoint,
            queryParameters: queryParameters,
            cancelToken: cancelToken,
            options: options,
            onReceiveProgress: (final int received, final int total) {
              if (onProgress != null && total != 0) {
                onProgress((received / total).clamp(0.0, 1.0));
              }
            },
          );
        case HttpMethod.post:
          response = await dio.post(
            endpoint,
            data: data,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
          );
        case HttpMethod.put:
          response = await dio.put(
            endpoint,
            data: data,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
          );
        case HttpMethod.patch:
          response = await dio.patch(
            endpoint,
            data: data,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
          );
        case HttpMethod.delete:
          response = await dio.delete(
            endpoint,
            data: data,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
          );
      }

      log(
        'Request | ${apiRoute.method} -> ${apiRoute.path} | Success',
        name: 'APICLIENT',
      );
      return ApiResponse<dynamic>(
        data: response.data,
        statusCode: response.statusCode ?? 0,
      );
    } on DioException catch (e, st) {
      if (e.response?.statusCode != 401) {
        debugPrint('Error: $e');
        debugPrintStack(stackTrace: st);
        log(
          'Request | ${apiRoute.method} -> ${apiRoute.path} | DioException',
          name: 'APICLIENT',
        );
      }
      rethrow;
    } on Object catch (e, st) {
      debugPrint('Error: $e');
      debugPrintStack(stackTrace: st);
      log(
        'Request | ${apiRoute.method} -> ${apiRoute.path} | Unknown Failure',
        name: 'APICLIENT',
      );
      rethrow;
    }
  }

  @override
  void close() => dio.close();
}
