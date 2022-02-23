import 'package:rijksmuseum_app/feature_art_list/domain/use_case/GetArtObjectDetail.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/use_case/GetCollection.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/use_case/GetThumbnailImage.dart';

class ArtUseCases{
  final GetCollection getCollection;
  final GetThumbnailImage getThumbnailImage;
  final GetArtObjectDetail getArtObjectDetail;

  ArtUseCases(this.getCollection, this.getThumbnailImage, this.getArtObjectDetail);
}
