import 'package:flutter_clean_arch_riverpod/data/data_objects/crypto_quote_dto.dart';
import 'package:flutter_clean_arch_riverpod/data/repositories_impl/crypto_quotes_repository_impl.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/crypto_quote_entity.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/quote_result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_crypto_quotes_local_datasource.dart';
import '../../mocks/mock_crypto_quotes_remote_datasource.dart';

void main() {
  late MockCryptoQuotesRemoteDatasource mockRemoteDatasource;
  late MockCryptoQuotesLocalDatasource mockLocalDatasource;
  late CryptoQuotesRepositoryImpl repository;

  setUp(() {
    mockRemoteDatasource = MockCryptoQuotesRemoteDatasource();
    mockLocalDatasource = MockCryptoQuotesLocalDatasource();
    repository = CryptoQuotesRepositoryImpl(
      remoteDatasource: mockRemoteDatasource,
      localDatasource: mockLocalDatasource,
    );
  });

  group('CryptoQuotesRepositoryImpl.getQuotes', () {
    test(
      'retorna quotes da rede e salva no cache quando bem-sucedido',
      () async {
        when(
          () => mockRemoteDatasource.getQuotes(),
        ).thenAnswer((_) async => tDTOs);
        when(
          () => mockLocalDatasource.saveQuotes(tDTOs),
        ).thenAnswer((_) async {});

        final QuoteResult result = await repository.getQuotes();

        expect(result.fromCache, isFalse);
        expect(result.quotes, hasLength(tDTOs.length));
        expect(result.quotes.first.symbol, equals('BTCUSDT'));
        verify(() => mockRemoteDatasource.getQuotes()).called(1);
        verify(() => mockLocalDatasource.saveQuotes(tDTOs)).called(1);
      },
    );

    test('converte DTOs em entidades corretamente', () async {
      when(
        () => mockRemoteDatasource.getQuotes(),
      ).thenAnswer((_) async => tDTOs);
      when(
        () => mockLocalDatasource.saveQuotes(any()),
      ).thenAnswer((_) async {});

      final QuoteResult result = await repository.getQuotes();

      final CryptoQuoteEntity btc = result.quotes.first;
      expect(btc.symbol, equals('BTCUSDT'));
      expect(btc.lastPrice, equals(50000.0));
      expect(btc.priceChange, equals(1000.0));
      expect(btc.priceChangePct, equals(2.0));
      expect(btc.highPrice, equals(51000.0));
      expect(btc.lowPrice, equals(49000.0));
    });

    test('retorna quotes do cache quando datasource remoto falha', () async {
      when(
        () => mockRemoteDatasource.getQuotes(),
      ).thenThrow(Exception('sem rede'));
      when(() => mockLocalDatasource.getQuotes()).thenReturn(tDTOs);

      final QuoteResult result = await repository.getQuotes();

      expect(result.fromCache, isTrue);
      expect(result.quotes, hasLength(tDTOs.length));
      verify(() => mockLocalDatasource.getQuotes()).called(1);
      verifyNever(() => mockLocalDatasource.saveQuotes(any()));
    });

    test(
      'propaga exceção quando datasource remoto falha e cache está vazio',
      () async {
        when(
          () => mockRemoteDatasource.getQuotes(),
        ).thenThrow(Exception('sem rede'));
        when(
          () => mockLocalDatasource.getQuotes(),
        ).thenReturn(<CryptoQuoteDTO>[]);

        expect(() => repository.getQuotes(), throwsException);
      },
    );
  });

  group('CryptoQuotesRepositoryImpl.getQuote', () {
    const String tSymbol = 'BTCUSDT';
    final CryptoQuoteDTO tDto = tDTOs.first;

    test('retorna entidade corretamente para o símbolo solicitado', () async {
      when(
        () => mockRemoteDatasource.getQuote(tSymbol),
      ).thenAnswer((_) async => tDto);

      final CryptoQuoteEntity result = await repository.getQuote(tSymbol);

      expect(result.symbol, equals('BTCUSDT'));
      expect(result.lastPrice, equals(50000.0));
      verify(() => mockRemoteDatasource.getQuote(tSymbol)).called(1);
    });

    test('propaga exceção quando datasource lança erro', () async {
      when(
        () => mockRemoteDatasource.getQuote(tSymbol),
      ).thenThrow(Exception('símbolo inválido'));

      expect(() => repository.getQuote(tSymbol), throwsException);
    });
  });
}
