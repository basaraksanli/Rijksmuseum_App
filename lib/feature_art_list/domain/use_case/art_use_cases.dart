import 'package:rijksmuseum_app/feature_art_list/domain/use_case/get_art_object_detail.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/use_case/get_collection.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/use_case/get_thumnnail_image.dart';

class ArtUseCases{
  final GetCollection getCollection;
  final GetThumbnailImage getThumbnailImage;
  final GetArtObjectDetail getArtObjectDetail;

  ArtUseCases(this.getCollection, this.getThumbnailImage, this.getArtObjectDetail);
}
