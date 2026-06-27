import 'package:flutter_clean_arch_riverpod/infrastructure/api_client/api_client_interface.dart';
import 'package:flutter_clean_arch_riverpod/infrastructure/api_client/models/api_route.dart';
import 'package:flutter_clean_arch_riverpod/infrastructure/api_client/models/http_methods.dart';
import 'package:mocktail/mocktail.dart';

class MockApiClientInterface extends Mock implements ApiClientInterface {}

/// Fallback value para [ApiRoute], necessário para uso com any(named: ...).
const ApiRoute kFallbackApiRoute = ApiRoute('', HttpMethod.get);
