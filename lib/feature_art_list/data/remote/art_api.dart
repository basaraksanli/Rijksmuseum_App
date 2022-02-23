import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';
import 'package:rijksmuseum_app/core/util/constants/constants.dart';
import 'package:rijksmuseum_app/feature_art_list/data/remote/dto/ArtObjectDetailResultDto.dart';
import 'package:rijksmuseum_app/feature_art_list/data/remote/dto/CollectionDto.dart';
import 'package:rijksmuseum_app/feature_art_list/data/remote/dto/ImagesDto.dart';

part 'art_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class ArtApi {
  static const String apiKey = Constants.apiKey;

  factory ArtApi(Dio dio, {String baseUrl}) = _ArtApi;

  @GET("{language}/collection?key=$apiKey")
  Future<HttpResponse<CollectionDto>> getCollection(
      {@Query("p") int page = 1,
      @Path() String language = "en",
      @Query("imgonly") bool imgOnly = true});

  @GET("{language}/collection/{id}/tiles?key=$apiKey")
  Future<HttpResponse<String>> getImage(
      {@Path() required String language, @Path() required String id});

  @GET("{language}/collection/{id}/?key=$apiKey")
  Future<HttpResponse<ArtObjectDetailResultDto>> getArtObjectDetail(
      {@Path() required String language, @Path() required String id});
}
