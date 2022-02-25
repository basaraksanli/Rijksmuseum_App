
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/retrofit.dart';
import 'package:rijksmuseum_app/core/params/art_object_request_params.dart';
import 'package:rijksmuseum_app/core/params/collection_request_params.dart';
import 'package:rijksmuseum_app/core/resources/DataState.dart';
import 'package:rijksmuseum_app/di/app_module.dart';
import 'package:rijksmuseum_app/feature_art_list/data/remote/art_api.dart';
import 'package:rijksmuseum_app/feature_art_list/data/remote/dto/art_object_detail_result_dto.dart';
import 'package:rijksmuseum_app/feature_art_list/data/remote/dto/collection_dto.dart';
import 'package:rijksmuseum_app/feature_art_list/data/repository/album_repository_impl.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/model/art_object.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/repository/art_repository.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/use_case/art_use_cases.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/use_case/get_art_object_detail.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/use_case/get_collection.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/use_case/get_thumnnail_image.dart';



import '../TestResultConstants.dart';
import 'retrofit_call_result.mocks.dart';

@GenerateMocks([ArtApi])
void main() {
  late final ArtApi api = MockArtApi();
  setUpAll(() {
    locator.registerLazySingleton<ArtApi>(() => api);
    locator.registerLazySingleton<ArtRepository>(
        () => ArtRepositoryImpl(locator()));
    locator.registerLazySingleton<ArtUseCases>(() => ArtUseCases(
        GetCollection(locator()),
        GetThumbnailImage(locator()),
        GetArtObjectDetail(locator())));
  });
  group('Fetch the Art Object Images and find the smallest image for thumbnail',
      () {
    test('returns z6.url if the call completes successfully', () async {
      when(api.getImage(id: "", language: "en")).thenAnswer((_) async =>
          HttpResponse(
              TestResultConstants.getImageCallResultZ6,
              Response(
                  statusCode: 200, requestOptions: RequestOptions(path: ""))));
      ArtUseCases artUseCases = locator();
      var urlResult = await artUseCases.getThumbnailImage
          .call(params: const ArtObjectRequestParams("", "en"));
      expect(urlResult.data, "z6.url");
    });

    test('returns z3.url if the call completes successfully', () async {
      when(api.getImage(id: "", language: "en")).thenAnswer((_) async =>
          HttpResponse(
              TestResultConstants.getImageCallResultZ3,
              Response(
                  statusCode: 200, requestOptions: RequestOptions(path: ""))));
      ArtUseCases artUseCases = locator();
      var urlResult = await artUseCases.getThumbnailImage
          .call(params: const ArtObjectRequestParams("", "en"));
      expect(urlResult.data, "z3.url");
    });
    test(
        'returns an exception with empty list string if the call completes successfully',
        () async {
      when(api.getImage(id: "", language: "en")).thenAnswer((_) async =>
          HttpResponse(
              TestResultConstants.getImageCallResultEmpty,
              Response(
                  statusCode: 200, requestOptions: RequestOptions(path: ""))));
      ArtUseCases artUseCases = locator();
      var urlResult = await artUseCases.getThumbnailImage
          .call(params: const ArtObjectRequestParams("", "en"));
      expect(urlResult.error.toString(),
          DataFailed(Exception("empty list")).error.toString());
    });
  });
  group("Get Collection Test", () {
    test('returns an object instance of List<ArtObject> if the call completes successfully',
        () async {
      when(api.getCollection(page: 1, language: "en")).thenAnswer((_) async =>
          HttpResponse(
              CollectionDto.fromJson(
                  TestResultConstants.exampleCollectionResult),
              Response(
                  statusCode: 200, requestOptions: RequestOptions(path: ""))));
      ArtUseCases artUseCases = locator();
      var result = await artUseCases.getCollection
          .call(params: const CollectionRequestParams(1, "en"));
      expect(result.data!, isA<List<ArtObject>>());
    });
    test('returns an empty list of ArtObject if the call completes successfully and the result is empty',
        () async {
      when(api.getCollection(page: 1, language: "en")).thenAnswer((_) async =>
          HttpResponse(
              CollectionDto.fromJson({}),
              Response(
                  statusCode: 200, requestOptions: RequestOptions(path: ""))));
      ArtUseCases artUseCases = locator();
      var result = await artUseCases.getCollection
          .call(params: const CollectionRequestParams(1, "en"));
      expect(result.data!, <ArtObject>[]);
    });
  });
  group("Get ArtObjectDetail Test", (){
    test('returns an object instance of ArtObject if the call completes successfully',
            () async {
          when(api.getArtObjectDetail(id: "", language: "en")).thenAnswer((_) async =>
              HttpResponse(
                  ArtObjectDetailResultDto.fromJson(
                      TestResultConstants.exampleArtObjectDetailResult),
                  Response(
                      statusCode: 200, requestOptions: RequestOptions(path: ""))));
          ArtUseCases artUseCases = locator();
          var result = await artUseCases.getArtObjectDetail
              .call(params: const ArtObjectRequestParams("", "en"));
          expect(result.data!, isA<ArtObject>());
        });
    test('returns an object instance of ArtObject if the call completes successfully',
            () async {
          when(api.getArtObjectDetail(id: "", language: "en")).thenAnswer((_) async =>
              HttpResponse(
                  ArtObjectDetailResultDto.fromJson(
                      {}),
                  Response(
                      statusCode: 200, requestOptions: RequestOptions(path: ""))));
          ArtUseCases artUseCases = locator();
          var result = await artUseCases.getArtObjectDetail
              .call(params: const ArtObjectRequestParams("", "en"));
          expect(result.error.toString(), DataFailed(Exception("Data is null")).error.toString());
        });
  });
}
