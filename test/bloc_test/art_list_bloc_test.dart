import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/retrofit.dart';
import 'package:rijksmuseum_app/core/config/pref_manager.dart';
import 'package:rijksmuseum_app/di/app_module.dart';
import 'package:rijksmuseum_app/feature_art_list/data/remote/art_api.dart';
import 'package:rijksmuseum_app/feature_art_list/data/remote/dto/collection_dto.dart';
import 'package:rijksmuseum_app/feature_art_list/data/repository/album_repository_impl.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/repository/art_repository.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/use_case/art_use_cases.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/use_case/get_art_object_detail.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/use_case/get_collection.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/use_case/get_thumnnail_image.dart';
import 'package:rijksmuseum_app/feature_art_list/presentation/art_list_screen/bloc/art_list_screen_bloc.dart';

import '../TestResultConstants.dart';
import 'art_list_bloc_test.mocks.dart';

@GenerateMocks([ArtApi])
void main() {
  late final ArtApi api = MockArtApi();
  late ArtListScreenBloc artListScreenBloc;
  setUpAll(() {
    locator.registerSingleton<BasePref>(PrefManager());
    locator.registerLazySingleton<ArtApi>(() => api);
    locator.registerLazySingleton<ArtRepository>(
        () => ArtRepositoryImpl(locator()));
    locator.registerLazySingleton<ArtUseCases>(() => ArtUseCases(
        GetCollection(locator()),
        GetThumbnailImage(locator()),
        GetArtObjectDetail(locator())));
  });

  group("art_list_bloc test", () {
    test("initial state should be Loading and next one should be Loaded",
        () async {
      when(api.getCollection(page: 1, language: "nl")).thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 1));
        return HttpResponse(
            CollectionDto.fromJson(TestResultConstants.exampleCollectionResult),
            Response(
                statusCode: 200, requestOptions: RequestOptions(path: "")));
      });
      when(api.getImage(id: "SK-A-2815", language: "en")).thenAnswer(
          (_) async => HttpResponse(
              TestResultConstants.getImageCallResultEmpty,
              Response(
                  statusCode: 200, requestOptions: RequestOptions(path: ""))));
      when(api.getImage(id: "SK-A-3059", language: "en")).thenAnswer((_) async {
        return HttpResponse(
            TestResultConstants.getImageCallResultEmpty,
            Response(
                statusCode: 200, requestOptions: RequestOptions(path: "")));
      });
      when(api.getImage(id: "SK-A-3148", language: "en")).thenAnswer(
          (_) async => HttpResponse(
              TestResultConstants.getImageCallResultEmpty,
              Response(
                  statusCode: 200, requestOptions: RequestOptions(path: ""))));
      artListScreenBloc = ArtListScreenBloc(locator());
      expect(artListScreenBloc.state, isA<ArtListScreenLoading>());
      expectLater(
          artListScreenBloc.stream, emitsInOrder([isA<ArtListItemsLoaded>()]));
      when(artListScreenBloc.state is ArtListItemsLoaded);
    });
    test("If api can't retrieve the data, bloc will emit ArtListScreenNetwork Error",
        () async {
      when(api.getCollection(page: 1, language: "nl")).thenThrow(Exception());

      artListScreenBloc = ArtListScreenBloc(locator());
      expect(artListScreenBloc.state, isA<ArtListScreenLoading>());
      expectLater(artListScreenBloc.stream,
          emitsInOrder([isA<ArtListScreenNetworkError>()]));
      when(artListScreenBloc.state is ArtListItemsLoaded);
    });
    test("if the scroll swipe down to the end, bloc will load more items with the states MoreArtListItemsLoading and ArtListItemsLoaded",
        () async {
      when(api.getCollection(page: 1, language: "nl")).thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 1));
        return HttpResponse(
            CollectionDto.fromJson(TestResultConstants.exampleCollectionResult),
            Response(
                statusCode: 200, requestOptions: RequestOptions(path: "")));
      });
      when(api.getImage(id: "SK-A-2815", language: "en")).thenAnswer(
          (_) async => HttpResponse(
              TestResultConstants.getImageCallResultEmpty,
              Response(
                  statusCode: 200, requestOptions: RequestOptions(path: ""))));
      when(api.getImage(id: "SK-A-3059", language: "en")).thenAnswer((_) async {
        return HttpResponse(
            TestResultConstants.getImageCallResultEmpty,
            Response(
                statusCode: 200, requestOptions: RequestOptions(path: "")));
      });
      when(api.getImage(id: "SK-A-3148", language: "en")).thenAnswer(
          (_) async => HttpResponse(
              TestResultConstants.getImageCallResultEmpty,
              Response(
                  statusCode: 200, requestOptions: RequestOptions(path: ""))));
      when(api.getCollection(page: 2, language: "nl")).thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 1));
        return HttpResponse(
            CollectionDto.fromJson({}),
            Response(
                statusCode: 200, requestOptions: RequestOptions(path: "")));
      });

      artListScreenBloc = ArtListScreenBloc(locator());
      expect(artListScreenBloc.state, isA<ArtListScreenLoading>(),);
      expectLater(artListScreenBloc.stream,
          emitsInOrder([ isA<MoreArtListItemsLoading>(), isA<ArtListItemsLoaded>(),]));
      artListScreenBloc.add(LoadMoreItems());
    });
    test("if there is no more items left to retrieve, the bloc will emit ArtListScreenNoItemsToLoadError",
            () async {
          when(api.getCollection(page: 1, language: "nl")).thenAnswer((_) async {
            await Future.delayed(const Duration(seconds: 1));
            return HttpResponse(
                CollectionDto.fromJson(TestResultConstants.exampleCollectionResult),
                Response(
                    statusCode: 200, requestOptions: RequestOptions(path: "")));
          });
          when(api.getImage(id: "SK-A-2815", language: "en")).thenAnswer(
                  (_) async => HttpResponse(
                  TestResultConstants.getImageCallResultEmpty,
                  Response(
                      statusCode: 200, requestOptions: RequestOptions(path: ""))));
          when(api.getImage(id: "SK-A-3059", language: "en")).thenAnswer((_) async {
            return HttpResponse(
                TestResultConstants.getImageCallResultEmpty,
                Response(
                    statusCode: 200, requestOptions: RequestOptions(path: "")));
          });
          when(api.getImage(id: "SK-A-3148", language: "en")).thenAnswer(
                  (_) async => HttpResponse(
                  TestResultConstants.getImageCallResultEmpty,
                  Response(
                      statusCode: 200, requestOptions: RequestOptions(path: ""))));
          when(api.getCollection(page: 2, language: "nl")).thenAnswer((_) async {
            await Future.delayed(const Duration(seconds: 1));
            return HttpResponse(
                CollectionDto.fromJson({}),
                Response(
                    statusCode: 200, requestOptions: RequestOptions(path: "")));
          });

          artListScreenBloc = ArtListScreenBloc(locator());
          artListScreenBloc.page= 2;
          expect(artListScreenBloc.state, isA<ArtListScreenLoading>(),);
          expectLater(artListScreenBloc.stream,
              emitsInOrder([ isA<MoreArtListItemsLoading>(), isA<ArtListScreenNoItemsToLoadError>(),]));
          artListScreenBloc.add(LoadMoreItems());
        });
  });
}
