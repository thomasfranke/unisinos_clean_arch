import 'package:flutter_clean_arch_riverpod/data/data_objects/kline_dto.dart';
import 'package:flutter_clean_arch_riverpod/data/mappers/kline_mapper.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/kline_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/mock_klines.dart';

void main() {
  group('KlineDTOMapper.toEntity', () {
    test('converte DTO em entidade com valores corretos', () {
      final KlineDTO dto = KlineDTO.fromList(tRawKlineList);
      final Kline entity = dto.toEntity();

      expect(entity.open, equals(50000.0));
      expect(entity.high, equals(51000.0));
      expect(entity.low, equals(49000.0));
      expect(entity.close, equals(50500.0));
      expect(entity.volume, equals(1000.0));
      expect(entity.numberOfTrades, equals(500));
      expect(
        entity.openTime,
        equals(DateTime.fromMillisecondsSinceEpoch(1704067200000)),
      );
      expect(
        entity.closeTime,
        equals(DateTime.fromMillisecondsSinceEpoch(1704070800000)),
      );
    });

    test('usa zeros como fallback para strings inválidas', () {
      const KlineDTO dto = KlineDTO(
        openTime: 0,
        open: 'invalid',
        high: 'invalid',
        low: 'invalid',
        close: 'invalid',
        volume: 'invalid',
        closeTime: 0,
        numberOfTrades: 0,
      );

      final Kline entity = dto.toEntity();

      expect(entity.open, equals(0.0));
      expect(entity.high, equals(0.0));
      expect(entity.close, equals(0.0));
    });
  });
}
