import 'package:flutter_clean_arch_riverpod/domain/entities/kline_entity.dart';
import 'package:flutter_clean_arch_riverpod/domain/repositories/kline_repository_interface.dart';

/// Use case for fetching the list of klines for a given symbol and interval.
class GetKlinesUseCase {
  /// Creates an instance of [GetKlinesUseCase] with the
  /// provided [repository].
  const GetKlinesUseCase({required this.repository});

  /// The repository used to fetch the list of klines for a given
  /// symbol and interval.
  final KlineRepository repository;

  /// Fetches the list of klines for a given symbol and interval.
  Future<List<Kline>> call({
    required final String symbol,
    required final String interval,
    final int limit = 24,
  }) => repository.getKlines(symbol: symbol, interval: interval, limit: limit);
}
