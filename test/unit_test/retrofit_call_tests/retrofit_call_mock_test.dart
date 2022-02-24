
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/retrofit.dart';
import 'package:rijksmuseum_app/core/params/ArtObjectRequestParams.dart';
import 'package:rijksmuseum_app/core/params/CollectionRequestParams.dart';
import 'package:rijksmuseum_app/core/resources/DataState.dart';
import 'package:rijksmuseum_app/di/AppModule.dart';
import 'package:rijksmuseum_app/feature_art_list/data/remote/art_api.dart';
import 'package:rijksmuseum_app/feature_art_list/data/remote/dto/ArtObjectDetailResultDto.dart';
import 'package:rijksmuseum_app/feature_art_list/data/remote/dto/CollectionDto.dart';
import 'package:rijksmuseum_app/feature_art_list/data/repository/AlbumRepositoryImpl.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/model/ArtObject.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/repository/ArtRepository.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/use_case/ArtUseCases.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/use_case/GetArtObjectDetail.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/use_case/GetCollection.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/use_case/GetThumbnailImage.dart';



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
