import 'package:flutter_clean_arch_riverpod/data/data_objects/kline_dto.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/kline_entity.dart';

/// Extension to map [KlineDTO] to domain entities.
extension KlineDTOMapper on KlineDTO {
  /// Converts this DTO to a [Kline] domain entity.
  Kline toEntity() => Kline(
    openTime: DateTime.fromMillisecondsSinceEpoch(openTime),
    closeTime: DateTime.fromMillisecondsSinceEpoch(closeTime),
    open: double.tryParse(open) ?? 0.0,
    high: double.tryParse(high) ?? 0.0,
    low: double.tryParse(low) ?? 0.0,
    close: double.tryParse(close) ?? 0.0,
    volume: double.tryParse(volume) ?? 0.0,
    numberOfTrades: numberOfTrades,
  );
}
