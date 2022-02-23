part of 'art_detail_bloc.dart';

abstract class ArtDetailState extends Equatable {
  const ArtDetailState();
}

class ArtDetailLoading extends ArtDetailState {
  @override
  List<Object> get props => [];
}
class ArtDetailLoaded extends ArtDetailState {
  final ArtObject artObject;
  const ArtDetailLoaded(this.artObject);
  @override
  List<Object> get props => [artObject];
}
class ArtDetailNetworkError extends ArtDetailState{
  const ArtDetailNetworkError();

  @override
  List<Object> get props => [];
}
