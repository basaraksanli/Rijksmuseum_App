import 'package:rijksmuseum_app/core/params/ArtObjectRequestParams.dart';

import '../../../core/resources/DataState.dart';
import '../../../core/use_case/usecase.dart';
import '../model/ArtObject.dart';
import '../repository/ArtRepository.dart';

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
