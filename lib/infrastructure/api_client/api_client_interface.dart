import 'package:flutter_clean_arch_riverpod/infrastructure/api_client/models/api_route.dart';
import 'package:flutter_clean_arch_riverpod/infrastructure/api_client/models/response.dart';

/// Interface for an API client that can make HTTP requests to a specified
/// API route.
abstract interface class ApiClientInterface {
  /// Makes an HTTP request to the specified [apiRoute] with optional parameters
  Future<ApiResponse<dynamic>> request({
    required final ApiRoute apiRoute,
    final Object? data,
    final Map<String, dynamic>? queryParameters,
    final String? customBaseUrl,
    final void Function(double progress)? onProgress,
  });

  /// Closes the API client and releases any resources it holds.
  void close();
}
