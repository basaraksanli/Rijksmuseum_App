import 'dart:convert';
import 'dart:io';


import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:rijksmuseum_app/core/resources/DataState.dart';
import 'package:rijksmuseum_app/di/AppModule.dart';
import 'package:rijksmuseum_app/feature_art_list/data/remote/dto/ImagesDto.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/model/ArtObject.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/repository/ArtRepository.dart';

import '../remote/art_api.dart';

class ArtRepositoryImpl extends ArtRepository {
  final _api = locator.get<ArtApi>();

  @override
  Future<DataState<List<ArtObject>>> getCollection(int page,
      {required String language}) async {
    try {
      final httpResponse =
          await _api.getCollection(page: page, language: language);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        var result =
            httpResponse.data.artObjects.map((e) => e.toArtObject()).toList();
        return DataSuccess(result);
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<String?>> getThumbnailImage(String id,
      {required String language}) async {
    try {
      final httpResponse = await _api.getImage(id: id, language: language);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        var data = ImagesDto.fromJson(json
            .decode(httpResponse.data));
        var levels = data.levels;
        var result = levels..sort((a, b) => b.name.compareTo(a.name));

        return DataSuccess(result.first.tiles.first.url);
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }
  @override
  Future<DataState<ArtObject>> getArtObjectDetail(String id,
      {required String language}) async {
    try {
      final httpResponse = await _api.getArtObjectDetail(id: id, language: language);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        var data = httpResponse.data;

        if(data.artObject != null) {
          return DataSuccess(data.artObject!.toArtObject());
        }else {
          Logger().e("Art Object Detail: "+ id +" Data is null");
          return DataFailed(Exception("Data is null"));
        }
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }
}
