part of '../on_air_tv_bloc.dart';

abstract class OnAirTvEvent extends Equatable {
  const OnAirTvEvent();

  @override
  List<Object> get props => [];
}

class GetOnAirTvListEvent extends OnAirTvEvent {}
