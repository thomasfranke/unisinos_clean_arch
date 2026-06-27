import 'package:flutter_clean_arch_riverpod/application/quotes/get_crypto_quotes_usecase.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/quote_result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_crypto_quote_repository.dart';

void main() {
  late MockCryptoQuoteRepository mockRepository;
  late GetCryptoQuotesUseCase useCase;

  setUp(() {
    mockRepository = MockCryptoQuoteRepository();
    useCase = GetCryptoQuotesUseCase(repository: mockRepository);
  });

  group('GetCryptoQuotesUseCase', () {
    test('retorna quotes da rede quando bem-sucedido', () async {
      when(
        () => mockRepository.getQuotes(),
      ).thenAnswer((_) async => QuoteResult(tQuotes));

      final QuoteResult result = await useCase.call();

      expect(result.quotes, equals(tQuotes));
      expect(result.fromCache, isFalse);
      verify(() => mockRepository.getQuotes()).called(1);
    });

    test('retorna quotes do cache quando fromCache é true', () async {
      when(
        () => mockRepository.getQuotes(),
      ).thenAnswer((_) async => QuoteResult(tQuotes, fromCache: true));

      final QuoteResult result = await useCase.call();

      expect(result.quotes, equals(tQuotes));
      expect(result.fromCache, isTrue);
    });

    test('propaga exceção quando repositório lança erro', () async {
      when(() => mockRepository.getQuotes()).thenThrow(Exception('sem rede'));

      expect(() => useCase.call(), throwsException);
    });
  });
}
