part of 'art_list_screen_bloc.dart';

abstract class ArtListScreenEvent extends Equatable {
  const ArtListScreenEvent();
}
class LoadArtItems extends ArtListScreenEvent{
  @override
  List<Object?> get props => [];
}
class LoadMoreItems extends ArtListScreenEvent{
  @override
  List<Object?> get props => [];
}
class StartFetchMoreItems extends ArtListScreenEvent{
  @override
  List<Object?> get props => [];
}