import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:rijksmuseum_app/core/config/pref_manager.dart';
import 'package:rijksmuseum_app/core/params/CollectionRequestParams.dart';
import 'package:rijksmuseum_app/core/params/ThumbnailImageRequestParams.dart';
import 'package:rijksmuseum_app/core/resources/DataState.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/model/ArtObject.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/use_case/ArtUseCases.dart';

part 'art_list_screen_event.dart';

part 'art_list_screen_state.dart';

class ArtListScreenBloc extends Bloc<ArtListScreenEvent, ArtListScreenState> {
  final ArtUseCases _artUseCases;
  final List<ArtObject> _artList = [];
  bool isNewItemsLoading = false;

  int page = 1;

  ArtListScreenBloc(this._artUseCases) : super(ArtListScreenLoading()) {
    on<LoadArtItems>(_mapLoadArtItems);
    on<LoadMoreItems>((event, emit) => emit(MoreArtListItemsLoading(_artList)),);
    on<StartFetchItems>(_mapLoadArtItems);
    add(LoadArtItems());
  }

  _mapLoadArtItems(event, Emitter<ArtListScreenState> emit) async {
    isNewItemsLoading = true;
    try {
      var response = await _artUseCases.getCollection.call(
          params:
          CollectionRequestParams(page, PrefManager().getLanguageCode()));

      if (response is DataSuccess) {
        List<Future> futures = [];
        response.data!.forEach((element) async {
          futures.add(updateThumbnails(element));
        });
        await Future.wait(futures);
        isNewItemsLoading = false;
        page++;
        emit(ArtListItemsLoaded(_artList));
      } else {
        isNewItemsLoading = false;
        emit(ArtListScreenNetworkError());
      }
    } on Exception catch (e) {
      Logger().e(e);
      isNewItemsLoading = false;
      emit(ArtListScreenNetworkError());
    }
  }

  Future<void> updateThumbnails(ArtObject artObject) async {
    try {
      var url = (await _artUseCases.getThumbnailImage.call(
        params: ArtObjectRequestParams(artObject.id, "en"),
      ))
          .data;
      artObject.thumbnail = url;
      _artList.add(artObject);
    } on Exception catch (e) {
      Logger().e(e);
    }
  }
}
