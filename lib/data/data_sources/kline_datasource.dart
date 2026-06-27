import 'package:flutter/foundation.dart';
import 'package:flutter_clean_arch_riverpod/data/data_objects/kline_dto.dart';
import 'package:flutter_clean_arch_riverpod/infrastructure/api_client/api_client_interface.dart';
import 'package:flutter_clean_arch_riverpod/infrastructure/api_client/models/api_route.dart';
import 'package:flutter_clean_arch_riverpod/infrastructure/api_client/models/http_methods.dart';
import 'package:flutter_clean_arch_riverpod/infrastructure/api_client/models/response.dart';

/// Datasource for fetching kline (candlestick) data from the Binance API.
class KlineDatasource {
  /// Creates a [KlineDatasource] with the given [apiClient].
  const KlineDatasource({required this.apiClient});

  /// API client used to make requests to the Binance API for kline data.
  final ApiClientInterface apiClient;

  /// Fetches a list of kline data for a specific cryptocurrency symbol and
  /// interval from the Binance API.
  Future<List<KlineDTO>> getKlines({
    required final String symbol,
    required final String interval,
    final int limit = 24,
  }) async {
    final ApiResponse<dynamic> response = await apiClient.request(
      apiRoute: const ApiRoute('/api/v3/klines', HttpMethod.get),
      queryParameters: <String, dynamic>{
        'symbol': symbol,
        'interval': interval,
        'limit': limit,
      },
    );
    try {
      return (response.data as List<dynamic>)
          .map<KlineDTO>((dynamic e) => KlineDTO.fromList(e as List<dynamic>))
          .toList();
    } on Object catch (e, st) {
      debugPrint('Error: $e');
      debugPrintStack(stackTrace: st);
      rethrow;
    }
  }
}
