import 'package:dio/dio.dart';
import 'package:flutter_clean_arch_riverpod/infrastructure/api_client/dio/dio_impl.dart';
import 'package:flutter_clean_arch_riverpod/infrastructure/api_client/models/api_route.dart';
import 'package:flutter_clean_arch_riverpod/infrastructure/api_client/models/http_methods.dart';
import 'package:flutter_clean_arch_riverpod/infrastructure/api_client/models/response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_dio.dart';

void main() {
  late MockDio mockDio;
  late ApiClientDioImpl apiClient;

  setUpAll(() {
    registerFallbackValue(FakeOptions());
  });

  setUp(() {
    mockDio = MockDio();
    apiClient = ApiClientDioImpl(dio: mockDio);
  });

  Response<dynamic> responseWith(dynamic data, [int statusCode = 200]) =>
      Response<dynamic>(
        requestOptions: RequestOptions(path: '/test'),
        data: data,
        statusCode: statusCode,
      );

  group('ApiClientDioImpl.request', () {
    test('faz GET e retorna ApiResponse com dados e status code', () async {
      when(
        () => mockDio.get<dynamic>(
          any(),
          queryParameters: any(named: 'queryParameters'),
          cancelToken: any(named: 'cancelToken'),
          options: any(named: 'options'),
          onReceiveProgress: any(named: 'onReceiveProgress'),
        ),
      ).thenAnswer((_) async => responseWith(<String, dynamic>{'ok': true}));

      final ApiResponse<dynamic> result = await apiClient.request(
        apiRoute: const ApiRoute('/quotes', HttpMethod.get),
      );

      expect(result.data, equals(<String, dynamic>{'ok': true}));
      expect(result.statusCode, equals(200));
    });

    test('resolve customBaseUrl contra o path da rota', () async {
      when(
        () => mockDio.get<dynamic>(
          any(),
          queryParameters: any(named: 'queryParameters'),
          cancelToken: any(named: 'cancelToken'),
          options: any(named: 'options'),
          onReceiveProgress: any(named: 'onReceiveProgress'),
        ),
      ).thenAnswer((_) async => responseWith(<String, dynamic>{}));

      await apiClient.request(
        apiRoute: const ApiRoute('/quotes', HttpMethod.get),
        customBaseUrl: 'https://api.example.com/',
      );

      final List<dynamic> captured = verify(
        () => mockDio.get<dynamic>(
          captureAny(),
          queryParameters: any(named: 'queryParameters'),
          cancelToken: any(named: 'cancelToken'),
          options: any(named: 'options'),
          onReceiveProgress: any(named: 'onReceiveProgress'),
        ),
      ).captured;

      expect(captured.single, equals('https://api.example.com/quotes'));
    });

    test('encaminha onProgress proporcional aos bytes recebidos', () async {
      late final void Function(int, int) onReceiveProgress;

      when(
        () => mockDio.get<dynamic>(
          any(),
          queryParameters: any(named: 'queryParameters'),
          cancelToken: any(named: 'cancelToken'),
          options: any(named: 'options'),
          onReceiveProgress: any(named: 'onReceiveProgress'),
        ),
      ).thenAnswer((Invocation invocation) async {
        onReceiveProgress =
            invocation.namedArguments[#onReceiveProgress]
                as void Function(int, int);
        return responseWith(<String, dynamic>{});
      });

      final List<double> progressValues = <double>[];
      await apiClient.request(
        apiRoute: const ApiRoute('/quotes', HttpMethod.get),
        onProgress: progressValues.add,
      );

      onReceiveProgress(50, 100);

      expect(progressValues, equals(<double>[0.5]));
    });

    test('faz POST com o método correto', () async {
      when(
        () => mockDio.post<dynamic>(
          any(),
          data: any(named: 'data'),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenAnswer((_) async => responseWith(<String, dynamic>{}));

      await apiClient.request(
        apiRoute: const ApiRoute('/quotes', HttpMethod.post),
        data: <String, dynamic>{'a': 1},
      );

      verify(
        () => mockDio.post<dynamic>(
          '/quotes',
          data: <String, dynamic>{'a': 1},
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).called(1);
    });

    test('faz PUT com o método correto', () async {
      when(
        () => mockDio.put<dynamic>(
          any(),
          data: any(named: 'data'),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenAnswer((_) async => responseWith(<String, dynamic>{}));

      await apiClient.request(
        apiRoute: const ApiRoute('/quotes', HttpMethod.put),
      );

      verify(
        () => mockDio.put<dynamic>(
          '/quotes',
          data: any(named: 'data'),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).called(1);
    });

    test('faz PATCH com o método correto', () async {
      when(
        () => mockDio.patch<dynamic>(
          any(),
          data: any(named: 'data'),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenAnswer((_) async => responseWith(<String, dynamic>{}));

      await apiClient.request(
        apiRoute: const ApiRoute('/quotes', HttpMethod.patch),
      );

      verify(
        () => mockDio.patch<dynamic>(
          '/quotes',
          data: any(named: 'data'),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).called(1);
    });

    test('faz DELETE com o método correto', () async {
      when(
        () => mockDio.delete<dynamic>(
          any(),
          data: any(named: 'data'),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenAnswer((_) async => responseWith(<String, dynamic>{}));

      await apiClient.request(
        apiRoute: const ApiRoute('/quotes', HttpMethod.delete),
      );

      verify(
        () => mockDio.delete<dynamic>(
          '/quotes',
          data: any(named: 'data'),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).called(1);
    });

    test('relança DioException', () async {
      when(
        () => mockDio.get<dynamic>(
          any(),
          queryParameters: any(named: 'queryParameters'),
          cancelToken: any(named: 'cancelToken'),
          options: any(named: 'options'),
          onReceiveProgress: any(named: 'onReceiveProgress'),
        ),
      ).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/quotes')),
      );

      expect(
        () => apiClient.request(
          apiRoute: const ApiRoute('/quotes', HttpMethod.get),
        ),
        throwsA(isA<DioException>()),
      );
    });

    test('relança erro desconhecido', () async {
      when(
        () => mockDio.get<dynamic>(
          any(),
          queryParameters: any(named: 'queryParameters'),
          cancelToken: any(named: 'cancelToken'),
          options: any(named: 'options'),
          onReceiveProgress: any(named: 'onReceiveProgress'),
        ),
      ).thenThrow(Exception('falha inesperada'));

      expect(
        () => apiClient.request(
          apiRoute: const ApiRoute('/quotes', HttpMethod.get),
        ),
        throwsException,
      );
    });
  });

  group('ApiClientDioImpl.close', () {
    test('fecha o cliente dio subjacente', () {
      when(() => mockDio.close()).thenReturn(null);

      apiClient.close();

      verify(() => mockDio.close()).called(1);
    });
  });
}
