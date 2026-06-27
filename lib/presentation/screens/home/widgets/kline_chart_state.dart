import 'package:flutter/material.dart';
import 'package:flutter_clean_arch_riverpod/application/quotes/get_klines_usecase.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/kline_entity.dart';
import 'package:flutter_clean_arch_riverpod/presentation/providers/klines/kline_notifier.dart';
import 'package:flutter_clean_arch_riverpod/presentation/providers/klines/kline_state.dart';
import 'package:flutter_clean_arch_riverpod/presentation/screens/home/widgets/chart_widget.dart';
import 'package:flutter_clean_arch_riverpod/presentation/screens/home/widgets/kline_chart_widget.dart';
import 'package:flutter_clean_arch_riverpod/presentation/screens/home/widgets/kline_interval.dart';
import 'package:provider/provider.dart';

/// State class for the [KlineChart] widget, responsible for managing the state
/// of the kline chart, including fetching data and handling user interactions
/// such as switching between different time intervals for the chart data.
class KlineChartState extends State<KlineChart> {
  late final KlineNotifier _notifier;

  @override
  void initState() {
    super.initState();
    _notifier = KlineNotifier(
      getKlinesUseCase: context.read<GetKlinesUseCase>(),
      symbol: widget.symbol,
    );
  }

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => ListenableBuilder(
    listenable: _notifier,
    builder: (final BuildContext context, _) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        IntervalSelector(
          current: _notifier.currentInterval,
          onSelected: (final String interval) => _notifier.switchInterval(
            symbol: widget.symbol,
            interval: interval,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: switch (_notifier.state) {
            KlineStateInitial() || KlineStateLoading() => const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            KlineStateFailure(:final String message) => Center(
              child: Text(message, style: const TextStyle(color: Colors.grey)),
            ),
            KlineStateSuccess(:final List<Kline> klines) => Chart(
              klines: klines,
            ),
          },
        ),
      ],
    ),
  );
}
