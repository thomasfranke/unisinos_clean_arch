import 'package:flutter_clean_arch_riverpod/application/quotes/get_klines_usecase.dart';
import 'package:flutter_clean_arch_riverpod/data/data_objects/kline_dto.dart';
import 'package:flutter_clean_arch_riverpod/data/data_sources/kline_datasource.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/kline_entity.dart';
import 'package:flutter_clean_arch_riverpod/domain/repositories/kline_repository_interface.dart';
import 'package:mocktail/mocktail.dart';

class MockKlineRepository extends Mock implements KlineRepository {}

class MockKlineDatasource extends Mock implements KlineDatasource {}

class MockGetKlinesUseCase extends Mock implements GetKlinesUseCase {}

final List<Kline> tKlines = <Kline>[
  Kline(
    openTime: DateTime.fromMillisecondsSinceEpoch(1704067200000),
    closeTime: DateTime.fromMillisecondsSinceEpoch(1704070800000),
    open: 50000,
    high: 51000,
    low: 49000,
    close: 50500,
    volume: 1000,
    numberOfTrades: 500,
  ),
];

final List<KlineDTO> tKlineDTOs = <KlineDTO>[
  const KlineDTO(
    openTime: 1704067200000,
    open: '50000',
    high: '51000',
    low: '49000',
    close: '50500',
    volume: '1000',
    closeTime: 1704070800000,
    numberOfTrades: 500,
  ),
];

/// Raw list posicional retornado pela API da Binance para um kline.
final List<dynamic> tRawKlineList = <dynamic>[
  1704067200000, // 0: openTime
  '50000', // 1: open
  '51000', // 2: high
  '49000', // 3: low
  '50500', // 4: close
  '1000', // 5: volume
  1704070800000, // 6: closeTime
  '50500000', // 7: quoteVolume (não utilizado em fromList)
  500, // 8: numberOfTrades
];
