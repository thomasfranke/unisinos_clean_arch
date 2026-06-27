import 'package:flutter_clean_arch_riverpod/domain/entities/quote_result.dart';
import 'package:flutter_clean_arch_riverpod/presentation/providers/crypto_quote/crypto_quote_notifier.dart';
import 'package:flutter_clean_arch_riverpod/presentation/providers/crypto_quote/crypto_quote_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_crypto_quote_repository.dart';
import '../../../mocks/mock_get_crypto_quotes_usecase.dart';

void main() {
  late MockGetCryptoQuotesUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockGetCryptoQuotesUseCase();
  });

  group('CryptoQuoteState', () {
    test('CryptoQuoteStateInitial pode ser instanciada', () {
      expect(const CryptoQuoteStateInitial(), isA<CryptoQuoteStateInitial>());
    });
  });

  group('CryptoQuoteNotifier', () {
    test('inicia em loading e transiciona para success', () async {
      when(
        () => mockUseCase.call(),
      ).thenAnswer((_) async => QuoteResult(tQuotes));

      final CryptoQuoteNotifier notifier = CryptoQuoteNotifier(
        getQuotesUseCase: mockUseCase,
      );

      expect(notifier.state, isA<CryptoQuoteStateLoading>());

      await Future<void>.delayed(Duration.zero);

      expect(notifier.state, isA<CryptoQuoteStateSuccess>());
      final CryptoQuoteStateSuccess success =
          notifier.state as CryptoQuoteStateSuccess;
      expect(success.quotes, equals(tQuotes));
      expect(success.fromCache, isFalse);
    });

    test('transiciona para success com fromCache quando vem do cache',
        () async {
      when(
        () => mockUseCase.call(),
      ).thenAnswer((_) async => QuoteResult(tQuotes, fromCache: true));

      final CryptoQuoteNotifier notifier = CryptoQuoteNotifier(
        getQuotesUseCase: mockUseCase,
      );

      await Future<void>.delayed(Duration.zero);

      final CryptoQuoteStateSuccess success =
          notifier.state as CryptoQuoteStateSuccess;
      expect(success.fromCache, isTrue);
    });

    test('transiciona para failure quando use case lança exceção', () async {
      when(
        () => mockUseCase.call(),
      ).thenThrow(Exception('sem rede e sem cache'));

      final CryptoQuoteNotifier notifier = CryptoQuoteNotifier(
        getQuotesUseCase: mockUseCase,
      );

      await Future<void>.delayed(Duration.zero);

      expect(notifier.state, isA<CryptoQuoteStateFailure>());
    });

    test('fetchQuotes atualiza estado corretamente ao ser chamado novamente',
        () async {
      when(
        () => mockUseCase.call(),
      ).thenAnswer((_) async => QuoteResult(tQuotes));

      final CryptoQuoteNotifier notifier = CryptoQuoteNotifier(
        getQuotesUseCase: mockUseCase,
      );

      await Future<void>.delayed(Duration.zero);
      await notifier.fetchQuotes();

      verify(() => mockUseCase.call()).called(2);
      expect(notifier.state, isA<CryptoQuoteStateSuccess>());
    });
  });
}
