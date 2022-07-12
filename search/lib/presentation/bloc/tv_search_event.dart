part of 'tv_search_bloc.dart';

abstract class TvSearchEvent extends Equatable {
  const TvSearchEvent();

  @override
  List<Object> get props => [];
}

class GetTvSearchEvent extends TvSearchEvent {
  final String query;

  GetTvSearchEvent({required this.query});

  @override
  List<Object> get props => [query];
}
