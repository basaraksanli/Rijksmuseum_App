import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rijksmuseum_app/core/config/pref_manager.dart';
import 'package:rijksmuseum_app/feature_art_list/data/repository/album_repository_impl.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/repository/art_repository.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/use_case/art_use_cases.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/use_case/get_art_object_detail.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/use_case/get_collection.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/use_case/get_thumnnail_image.dart';

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
