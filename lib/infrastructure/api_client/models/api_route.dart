import 'package:flutter_clean_arch_riverpod/infrastructure/api_client/models/http_methods.dart';

/// Defines an API route with a path and HTTP method.
class ApiRoute {
  /// Creates an instance of [ApiRoute] with the specified [path] and [method].
  const ApiRoute(this.path, this.method);

  /// The path of the API route, e.g., '/api/v3/ticker/24hr'.
  final String path;

  /// The HTTP method to be used for the API route, e.g., GET, POST, etc.
  final HttpMethod method;
}
