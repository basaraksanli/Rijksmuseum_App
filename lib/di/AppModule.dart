import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rijksmuseum_app/core/config/pref_manager.dart';
import 'package:rijksmuseum_app/feature_art_list/data/repository/AlbumRepositoryImpl.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/repository/ArtRepository.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/use_case/ArtUseCases.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/use_case/GetArtObjectDetail.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/use_case/GetCollection.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/use_case/GetThumbnailImage.dart';

import '../feature_art_list/data/remote/art_api.dart';

var locator = GetIt.instance;
var _isInitialized = false;

void setupDi() {
  if (_isInitialized) {
    return;
  }
  locator.registerSingleton<BasePref>(PrefManager());
  locator.registerLazySingleton<Dio>(() => Dio());

  locator.registerLazySingleton<ArtApi>(() => ArtApi(locator()));
  locator.registerLazySingleton<ArtRepository>(() => ArtRepositoryImpl(locator()));
  locator.registerLazySingleton<ArtUseCases>(() =>
      ArtUseCases(GetCollection(locator()), GetThumbnailImage(locator()), GetArtObjectDetail(locator())));

  _isInitialized = true;
}
