part of 'art_list_screen_bloc.dart';

abstract class ArtListScreenState extends Equatable {
  const ArtListScreenState();
}

class ArtListScreenLoading extends ArtListScreenState {
  @override
  List<Object> get props => [];
}
class ArtListItemsLoaded extends ArtListScreenState {
  final List<ArtObject> artObjectList;
  const ArtListItemsLoaded(this.artObjectList);
  @override
  List<Object> get props => [artObjectList.length];
}
class MoreArtListItemsLoading extends ArtListScreenState{
  final List<ArtObject> artObjectList;
  const MoreArtListItemsLoading(this.artObjectList);
  @override
  List<Object> get props => [artObjectList.length];
}
class MoreArtListItemsLoaded extends ArtListScreenState {
  final List<ArtObject> artObjectList;
  const MoreArtListItemsLoaded(this.artObjectList);
  @override
  List<Object> get props => [artObjectList.length];
}
class ArtListScreenNetworkError extends ArtListScreenState {
  @override
  List<Object> get props => [];
}
