import 'package:rijksmuseum_app/core/params/collection_request_params.dart';
import 'package:rijksmuseum_app/core/resources/data_state.dart';
import 'package:rijksmuseum_app/core/use_case/usecase.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/model/art_object.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/repository/art_repository.dart';

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
