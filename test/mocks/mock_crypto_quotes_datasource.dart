import 'package:flutter_clean_arch_riverpod/data/data_objects/crypto_quote_dto.dart';
import 'package:flutter_clean_arch_riverpod/data/data_sources/crypto_quotes_datasource.dart';
import 'package:mocktail/mocktail.dart';

class MockCryptoQuoteDatasource extends Mock implements CryptoQuoteDatasource {}

/// DTOs fixos para uso nos testes.
final List<CryptoQuoteDTO> tDTOs = <CryptoQuoteDTO>[
  const CryptoQuoteDTO(
    symbol: 'BTCUSDT',
    lastPrice: '50000',
    priceChange: '1000',
    priceChangePercent: '2',
    highPrice: '51000',
    lowPrice: '49000',
    volume: '1000',
    quoteVolume: '50000000',
  ),
  const CryptoQuoteDTO(
    symbol: 'ETHUSDT',
    lastPrice: '3000',
    priceChange: '-50',
    priceChangePercent: '-1.6',
    highPrice: '3100',
    lowPrice: '2900',
    volume: '5000',
    quoteVolume: '15000000',
  ),
];
