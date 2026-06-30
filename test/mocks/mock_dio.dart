import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

/// Fallback value para [Options], necessário para uso com any(named: ...).
class FakeOptions extends Fake implements Options {}
