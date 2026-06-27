import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_clean_arch_riverpod/application/quotes/get_klines_usecase.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/kline_entity.dart';
import 'package:flutter_clean_arch_riverpod/presentation/providers/klines/kline_state.dart';

/// Notifier for managing the state of kline (candlestick) data.
class KlineNotifier extends ChangeNotifier {
  /// Creates an instance of [KlineNotifier] with the required use case and
  /// initiates the loading of kline (candlestick) data for the specified
  /// symbol and default interval.
  KlineNotifier({required this.getKlinesUseCase, required String symbol}) {
    unawaited(loadKlines(symbol: symbol, interval: _interval));
  }

  /// Use case for fetching kline (candlestick) data.
  final GetKlinesUseCase getKlinesUseCase;

  KlineState _state = const KlineStateLoading();

  /// Current state of kline (candlestick) data.
  KlineState get state => _state;

  String _interval = '1h';

  /// Current interval for kline (candlestick) data.
  String get currentInterval => _interval;

  /// Loads kline (candlestick) data for the specified [symbol] and [interval],
  /// and updates the state accordingly.
  Future<void> loadKlines({
    required final String symbol,
    required final String interval,
  }) async {
    _state = const KlineStateLoading();
    _interval = interval;
    notifyListeners();
    try {
      final List<Kline> klines = await getKlinesUseCase.call(
        symbol: symbol,
        interval: interval,
      );
      _state = KlineStateSuccess(klines);
    } on Object catch (e) {
      _state = KlineStateFailure(e.toString());
    } finally {
      notifyListeners();
    }
  }

  /// Switches the interval for kline (candlestick) data to the specified
  /// [interval] for the given [symbol] and reloads the data accordingly.
  Future<void> switchInterval({
    required final String symbol,
    required final String interval,
  }) => loadKlines(symbol: symbol, interval: interval);
}
