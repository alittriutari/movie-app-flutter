part of '../tv_detail_bloc.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();

  @override
  List<Object> get props => [];
}

class GetTvDetailEvent extends TvDetailEvent {
  final int id;

  const GetTvDetailEvent(this.id);

  @override
  List<Object> get props => [id];
}
