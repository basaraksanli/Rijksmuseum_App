import 'package:rijksmuseum_app/core/params/CollectionRequestParams.dart';
import 'package:rijksmuseum_app/core/resources/DataState.dart';
import 'package:rijksmuseum_app/core/use_case/usecase.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/model/ArtObject.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/repository/ArtRepository.dart';

class GetCollection
    implements UseCase<DataState<List<ArtObject>>, CollectionRequestParams> {
  final ArtRepository _artRepository;

  GetCollection(this._artRepository);

  @override
  Future<DataState<List<ArtObject>>> call(
      {CollectionRequestParams params =
          const CollectionRequestParams(0, "en")}) async {
    return await _artRepository.getCollection(params.page,
        language: params.language);
  }
}
