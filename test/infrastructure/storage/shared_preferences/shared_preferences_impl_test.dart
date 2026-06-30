import 'package:flutter_clean_arch_riverpod/infrastructure/storage/shared_preferences/shared_preferences_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../mocks/mock_shared_preferences.dart';

void main() {
  late MockSharedPreferences mockPrefs;
  late SharedPreferencesImpl storage;

  setUpAll(() {
    registerFallbackValue(<String>[]);
  });

  setUp(() {
    mockPrefs = MockSharedPreferences();
    storage = SharedPreferencesImpl(mockPrefs);
  });

  group('SharedPreferencesImpl.create', () {
    test('cria instância via SharedPreferences.getInstance', () async {
      SharedPreferences.setMockInitialValues(<String, Object>{});
      final SharedPreferencesImpl instance = await SharedPreferencesImpl.create();
      expect(instance, isA<SharedPreferencesImpl>());
    });
  });

  group('SharedPreferencesImpl.setString/getString', () {
    test('grava e lê um valor string', () async {
      when(
        () => mockPrefs.setString('key', 'value'),
      ).thenAnswer((_) async => true);
      when(() => mockPrefs.getString('key')).thenReturn('value');

      await storage.setString(key: 'key', value: 'value');
      final String? result = storage.getString(key: 'key');

      verify(() => mockPrefs.setString('key', 'value')).called(1);
      expect(result, equals('value'));
    });

    test('relança erro quando setString falha', () {
      when(
        () => mockPrefs.setString('key', 'value'),
      ).thenThrow(Exception('falha ao gravar'));

      expect(
        () => storage.setString(key: 'key', value: 'value'),
        throwsException,
      );
    });

    test('relança erro quando getString falha', () {
      when(() => mockPrefs.getString('key')).thenThrow(Exception('falha'));

      expect(() => storage.getString(key: 'key'), throwsException);
    });
  });

  group('SharedPreferencesImpl.setBool/getBool', () {
    test('grava e lê um valor booleano', () async {
      when(
        () => mockPrefs.setBool('key', true),
      ).thenAnswer((_) async => true);
      when(() => mockPrefs.getBool('key')).thenReturn(true);

      await storage.setBool(key: 'key', value: true);
      final bool? result = storage.getBool(key: 'key');

      verify(() => mockPrefs.setBool('key', true)).called(1);
      expect(result, isTrue);
    });

    test('relança erro quando setBool falha', () {
      when(
        () => mockPrefs.setBool('key', true),
      ).thenThrow(Exception('falha'));

      expect(
        () => storage.setBool(key: 'key', value: true),
        throwsException,
      );
    });

    test('relança erro quando getBool falha', () {
      when(() => mockPrefs.getBool('key')).thenThrow(Exception('falha'));

      expect(() => storage.getBool(key: 'key'), throwsException);
    });
  });

  group('SharedPreferencesImpl.setDouble/getDouble', () {
    test('grava e lê um valor double', () async {
      when(
        () => mockPrefs.setDouble('key', 1.5),
      ).thenAnswer((_) async => true);
      when(() => mockPrefs.getDouble('key')).thenReturn(1.5);

      await storage.setDouble(key: 'key', value: 1.5);
      final double? result = storage.getDouble(key: 'key');

      verify(() => mockPrefs.setDouble('key', 1.5)).called(1);
      expect(result, equals(1.5));
    });

    test('relança erro quando setDouble falha', () {
      when(
        () => mockPrefs.setDouble('key', 1.5),
      ).thenThrow(Exception('falha'));

      expect(
        () => storage.setDouble(key: 'key', value: 1.5),
        throwsException,
      );
    });

    test('relança erro quando getDouble falha', () {
      when(() => mockPrefs.getDouble('key')).thenThrow(Exception('falha'));

      expect(() => storage.getDouble(key: 'key'), throwsException);
    });
  });

  group('SharedPreferencesImpl.getList', () {
    test('retorna lista vazia quando não há valor salvo', () {
      when(() => mockPrefs.getStringList('key')).thenReturn(null);

      final List<String> result = storage.getList(key: 'key');

      expect(result, isEmpty);
    });

    test('retorna lista salva', () {
      when(
        () => mockPrefs.getStringList('key'),
      ).thenReturn(<String>['a', 'b']);

      final List<String> result = storage.getList(key: 'key');

      expect(result, equals(<String>['a', 'b']));
    });

    test('relança erro quando getList falha', () {
      when(() => mockPrefs.getStringList('key')).thenThrow(Exception('falha'));

      expect(() => storage.getList(key: 'key'), throwsException);
    });
  });

  group('SharedPreferencesImpl.addToList', () {
    test('adiciona valor inédito à lista e persiste', () async {
      when(() => mockPrefs.getStringList('key')).thenReturn(<String>['a']);
      when(
        () => mockPrefs.setStringList('key', <String>['a', 'b']),
      ).thenAnswer((_) async => true);

      final List<String> result = await storage.addToList(
        key: 'key',
        value: 'b',
      );

      expect(result, equals(<String>['a', 'b']));
      verify(
        () => mockPrefs.setStringList('key', <String>['a', 'b']),
      ).called(1);
    });

    test('não duplica valor já presente na lista', () async {
      when(() => mockPrefs.getStringList('key')).thenReturn(<String>['a']);

      final List<String> result = await storage.addToList(
        key: 'key',
        value: 'a',
      );

      expect(result, equals(<String>['a']));
      verifyNever(() => mockPrefs.setStringList(any(), any()));
    });

    test('relança erro quando addToList falha', () {
      when(() => mockPrefs.getStringList('key')).thenThrow(Exception('falha'));

      expect(
        () => storage.addToList(key: 'key', value: 'x'),
        throwsException,
      );
    });
  });

  group('SharedPreferencesImpl.removeFromList', () {
    test('remove valor existente da lista e persiste', () async {
      when(
        () => mockPrefs.getStringList('key'),
      ).thenReturn(<String>['a', 'b']);
      when(
        () => mockPrefs.setStringList('key', <String>['b']),
      ).thenAnswer((_) async => true);

      final List<String> result = await storage.removeFromList(
        key: 'key',
        value: 'a',
      );

      expect(result, equals(<String>['b']));
      verify(() => mockPrefs.setStringList('key', <String>['b'])).called(1);
    });

    test('relança erro quando removeFromList falha', () {
      when(() => mockPrefs.getStringList('key')).thenThrow(Exception('falha'));

      expect(
        () => storage.removeFromList(key: 'key', value: 'a'),
        throwsException,
      );
    });
  });
}
