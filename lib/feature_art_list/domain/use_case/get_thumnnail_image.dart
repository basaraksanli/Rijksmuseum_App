import 'package:rijksmuseum_app/core/params/art_object_request_params.dart';

import '../../../core/resources/data_state.dart';
import '../../../core/use_case/usecase.dart';
import '../repository/art_repository.dart';

class GetThumbnailImage
    implements UseCase<DataState<String?>, ArtObjectRequestParams> {
  final ArtRepository _artRepository;

  GetThumbnailImage(this._artRepository);

  @override
  Future<DataState<String?>> call(
      {ArtObjectRequestParams params =
          const ArtObjectRequestParams("", "en")}) async {
    return await _artRepository.getThumbnailImage(params.id,
        language: params.language);
  }
}
