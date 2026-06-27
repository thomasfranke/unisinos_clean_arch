import 'package:flutter_clean_arch_riverpod/data/data_objects/kline_dto.dart';
import 'package:flutter_clean_arch_riverpod/data/data_sources/kline_datasource.dart';
import 'package:flutter_clean_arch_riverpod/data/mappers/kline_mapper.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/kline_entity.dart';
import 'package:flutter_clean_arch_riverpod/domain/repositories/kline_repository_interface.dart';

/// Repository implementation for fetching kline (candlestick) data
/// using a [KlineDatasource].
class KlineRepositoryImpl implements KlineRepository {
  /// Creates a [KlineRepositoryImpl] with the given [datasource].
  const KlineRepositoryImpl({required this.datasource});

  /// Data source used to fetch kline data from an API.
  final KlineDatasource datasource;

  @override
  Future<List<Kline>> getKlines({
    required final String symbol,
    required final String interval,
    final int limit = 24,
  }) async {
    final List<KlineDTO> dtos = await datasource.getKlines(
      symbol: symbol,
      interval: interval,
      limit: limit,
    );
    return dtos.map((KlineDTO dto) => dto.toEntity()).toList();
  }
}
