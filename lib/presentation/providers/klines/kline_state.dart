import 'package:flutter_clean_arch_riverpod/domain/entities/kline_entity.dart';

/// Base class for representing the state of kline (candlestick) data.
sealed class KlineState {
  const KlineState();
}

/// State representing the initial state of kline (candlestick) data.
class KlineStateInitial extends KlineState {
  /// Creates an instance of [KlineStateInitial].
  const KlineStateInitial();
}

/// State representing the loading state of kline (candlestick) data.
class KlineStateLoading extends KlineState {
  /// Creates an instance of [KlineStateLoading].
  const KlineStateLoading();
}

/// State representing the successful retrieval of kline (candlestick) data.
class KlineStateSuccess extends KlineState {
  /// Creates an instance of [KlineStateSuccess].
  const KlineStateSuccess(this.klines);

  /// List of retrieved kline (candlestick) data.
  final List<Kline> klines;
}

/// State representing the failure to retrieve kline (candlestick) data.
class KlineStateFailure extends KlineState {
  /// Creates an instance of [KlineStateFailure].
  const KlineStateFailure(this.message);

  /// Error message describing the failure to retrieve kline (candlestick) data.
  final String message;
}
