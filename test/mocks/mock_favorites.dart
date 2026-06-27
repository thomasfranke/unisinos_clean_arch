import 'package:flutter_clean_arch_riverpod/application/favorites/get_favorites_usecase.dart';
import 'package:flutter_clean_arch_riverpod/application/favorites/toggle_favorite_usecase.dart';
import 'package:flutter_clean_arch_riverpod/data/data_sources/favorites_datasource.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/favorite_entity.dart';
import 'package:flutter_clean_arch_riverpod/domain/repositories/favorites_repository_interface.dart';
import 'package:mocktail/mocktail.dart';

class MockFavoritesRepository extends Mock implements FavoritesRepository {}

class MockFavoritesDatasource extends Mock implements FavoritesDatasource {}

class MockGetFavoritesUseCase extends Mock implements GetFavoritesUseCase {}

class MockToggleFavoriteUseCase extends Mock implements ToggleFavoriteUseCase {}

const List<String> tFavoriteSymbols = <String>['BTCUSDT', 'ETHUSDT'];

const List<FavoriteEntity> tFavoriteEntities = <FavoriteEntity>[
  FavoriteEntity(symbol: 'BTCUSDT'),
  FavoriteEntity(symbol: 'ETHUSDT'),
];
