import 'package:flutter/foundation.dart';
import 'package:flutter_clean_arch_riverpod/data/data_objects/crypto_quote_dto.dart';
import 'package:flutter_clean_arch_riverpod/infrastructure/api_client/api_client_interface.dart';
import 'package:flutter_clean_arch_riverpod/infrastructure/api_client/models/api_route.dart';
import 'package:flutter_clean_arch_riverpod/infrastructure/api_client/models/http_methods.dart';
import 'package:flutter_clean_arch_riverpod/infrastructure/api_client/models/response.dart';

/// Data source for fetching cryptocurrency quotes from an API.
class CryptoQuotesRemoteDatasource {
  /// Creates a [CryptoQuotesRemoteDatasource] with the given [apiClient].
  const CryptoQuotesRemoteDatasource({required this.apiClient});

  /// API client used to make requests to the cryptocurrency API.
  final ApiClientInterface apiClient;

  /// Fetches a list of cryptocurrency quotes from the API.
  Future<List<CryptoQuoteDTO>> getQuotes() async {
    final ApiResponse<dynamic> response = await apiClient.request(
      apiRoute: const ApiRoute('/api/v3/ticker/24hr', HttpMethod.get),
    );
    try {
      return (response.data as List<dynamic>)
          .map<CryptoQuoteDTO>(
            (dynamic e) => CryptoQuoteDTO.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } on Object catch (e, st) {
      debugPrint('Error: $e');
      debugPrintStack(stackTrace: st);
      rethrow;
    }
  }

  /// Fetches a specific cryptocurrency quote by its symbol from the API.
  Future<CryptoQuoteDTO> getQuote(final String symbol) async {
    final ApiResponse<dynamic> response = await apiClient.request(
      apiRoute: const ApiRoute('/api/v3/ticker/24hr', HttpMethod.get),
      queryParameters: <String, dynamic>{'symbol': symbol},
    );
    try {
      return CryptoQuoteDTO.fromJson(response.data as Map<String, dynamic>);
    } on Object catch (e, st) {
      debugPrint('Error: $e');
      debugPrintStack(stackTrace: st);
      rethrow;
    }
  }
}
