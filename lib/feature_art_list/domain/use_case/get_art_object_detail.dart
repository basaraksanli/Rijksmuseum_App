import 'package:rijksmuseum_app/core/params/art_object_request_params.dart';

import '../../../core/resources/data_state.dart';
import '../../../core/use_case/usecase.dart';
import '../model/art_object.dart';
import '../repository/art_repository.dart';

class GetArtObjectDetail
    implements UseCase<DataState<ArtObject>, ArtObjectRequestParams> {
  final ArtRepository _artRepository;

  GetArtObjectDetail(this._artRepository);

  @override
  Future<DataState<ArtObject>> call(
      {ArtObjectRequestParams params =
          const ArtObjectRequestParams("", "en")}) async {
    return await _artRepository.getArtObjectDetail(params.id,
        language: params.language);
  }
}
