import 'package:flutter_clean_arch_riverpod/data/data_objects/kline_dto.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/mock_klines.dart';

void main() {
  group('KlineDTO.fromList', () {
    test('parseia lista posicional da API corretamente', () {
      final KlineDTO dto = KlineDTO.fromList(tRawKlineList);

      expect(dto.openTime, equals(1704067200000));
      expect(dto.open, equals('50000'));
      expect(dto.high, equals('51000'));
      expect(dto.low, equals('49000'));
      expect(dto.close, equals('50500'));
      expect(dto.volume, equals('1000'));
      expect(dto.closeTime, equals(1704070800000));
      expect(dto.numberOfTrades, equals(500));
    });
  });
}
