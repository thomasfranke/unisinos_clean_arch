/// Generic response wrapper, isolating the underlying HTTP client
/// implementation (e.g. dio) from the rest of the application.
class ApiResponse<T> {
  /// Creates an [ApiResponse] with the given [data] and [statusCode].
  const ApiResponse({required this.data, required this.statusCode});

  /// The data returned from the API, of generic type [T].
  final T data;

  /// The HTTP status code of the API response.
  final int statusCode;
}
