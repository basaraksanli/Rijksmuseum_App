import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rijksmuseum_app/core/params/art_object_request_params.dart';
import 'package:rijksmuseum_app/core/params/collection_request_params.dart';
import 'package:rijksmuseum_app/core/resources/data_state.dart';
import 'package:rijksmuseum_app/di/app_module.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/model/art_object.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/use_case/art_use_cases.dart';

import '../test_mocks_constants.dart';

void main(){
  setUpAll((){
    setupDi();
  });
  group("Retrofit Real Calls tests", (){
    test("Get Art Object Detail test, returns an ArtObject type object", () async {
      ArtUseCases artUseCases = locator();
      var result =await artUseCases.getArtObjectDetail(params: const ArtObjectRequestParams("SK-C-5","en"));
      expect(result.data is ArtObject, true);
    });
    test("Get Art Object Detail test when there is nothing to search, returns an DataFailed Exception with Data is null", () async {
      ArtUseCases artUseCases = locator();
      var result =await artUseCases.getArtObjectDetail(params: const ArtObjectRequestParams("","en"));
      expect(result.error.toString(), DataFailed(Exception("Data is null")).error.toString());
    });
    test("Get Collection test, returns an list of ArtObject type object", () async {
      ArtUseCases artUseCases = locator();
      var result =await artUseCases.getCollection(params: const CollectionRequestParams(0,"en"));
      expect(result.data is List<ArtObject>, true);
    });
    test("Get Collection test with a page does not exist, returns an list of ArtObject type object", () async {
      ArtUseCases artUseCases = locator();
      var result =await artUseCases.getCollection(params: const CollectionRequestParams(5000,"en"));
      expect(result.data, []);
    });
    test("Get Thumbnail image test, returns an exact URL", () async {
      ArtUseCases artUseCases = locator();
      var result =await artUseCases.getThumbnailImage(params: const ArtObjectRequestParams("SK-C-5","en"));
      expect(result.data, TestMocksConstants.getThumbnailResultRealExample);
    });
    test("Get Art Object Detail test when there is no object, returns Dio error", () async {
      ArtUseCases artUseCases = locator();
      var result =await artUseCases.getThumbnailImage(params: const ArtObjectRequestParams("","en"));
      expect(result.error is DioError, true );
    });
  });
}