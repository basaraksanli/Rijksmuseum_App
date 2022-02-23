part of 'art_detail_bloc.dart';

abstract class ArtDetailEvent extends Equatable {
  const ArtDetailEvent();
}
class LoadArtDetailScreen extends ArtDetailEvent{
  @override
  List<Object> get props => [];
}
