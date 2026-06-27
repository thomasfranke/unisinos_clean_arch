import 'package:flutter_clean_arch_riverpod/domain/entities/crypto_quote_entity.dart';
import 'package:flutter_clean_arch_riverpod/domain/repositories/crypto_quotes_repository_interface.dart';
import 'package:mocktail/mocktail.dart';

class MockCryptoQuoteRepository extends Mock implements CryptoQuoteRepository {}

/// Quotes fixas para uso nos testes.
final List<CryptoQuoteEntity> tQuotes = <CryptoQuoteEntity>[
  const CryptoQuoteEntity(
    symbol: 'BTCUSDT',
    lastPrice: 50000,
    priceChange: 1000,
    priceChangePct: 2,
    highPrice: 51000,
    lowPrice: 49000,
    volume: 1000,
    quoteVolume: 50000000,
  ),
  const CryptoQuoteEntity(
    symbol: 'ETHUSDT',
    lastPrice: 3000,
    priceChange: -50,
    priceChangePct: -1.6,
    highPrice: 3100,
    lowPrice: 2900,
    volume: 5000,
    quoteVolume: 15000000,
  ),
];
