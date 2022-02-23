
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:rijksmuseum_app/core/params/ArtObjectRequestParams.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/model/ArtObject.dart';

import '../../../../core/config/pref_manager.dart';
import '../../../../core/resources/DataState.dart';
import '../../../domain/use_case/ArtUseCases.dart';

part 'art_detail_event.dart';

part 'art_detail_state.dart';

class ArtDetailBloc extends Bloc<ArtDetailEvent, ArtDetailState> {
  final ArtUseCases _artUseCases;
  final String _id;

  ArtDetailBloc(this._id, this._artUseCases) : super(ArtDetailLoading()) {
    on<LoadArtDetailScreen>(
        (event, emit) => _mapArtObjectDetailLoaded(event, emit));
    add(LoadArtDetailScreen());
  }

  _mapArtObjectDetailLoaded(event, Emitter<ArtDetailState> emit) async {
    try {
      var response = await _artUseCases.getArtObjectDetail.call(
          params: ArtObjectRequestParams(_id, PrefManager().getLanguageCode()));
      if (response is DataSuccess) {
        if (response.data != null) {
          emit(ArtDetailLoaded(response.data!));
        } else {
          Logger().e("Art Detail Object is null");
          emit(const ArtDetailNetworkError());
        }
      }
    } on Exception catch (e) {
      Logger().e(e);
      emit(const ArtDetailNetworkError());
    }
  }
}
