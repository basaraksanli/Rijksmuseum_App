import 'package:rijksmuseum_app/core/params/ThumbnailImageRequestParams.dart';

import '../../../core/resources/DataState.dart';
import '../../../core/use_case/usecase.dart';
import '../repository/ArtRepository.dart';

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
