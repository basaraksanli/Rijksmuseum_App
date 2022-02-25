

import 'package:rijksmuseum_app/feature_art_list/domain/model/art_object.dart';

import '../../../core/resources/data_state.dart';


abstract class ArtRepository{
  Future<DataState<List<ArtObject>>> getCollection(int page, {required String language});
  Future<DataState<String?>> getThumbnailImage(String id, {required String language});
  Future<DataState<ArtObject>> getArtObjectDetail(String id, {required String language});
}