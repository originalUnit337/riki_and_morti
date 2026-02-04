import 'package:equatable/equatable.dart';

sealed class HomeEvent extends Equatable {}

class LoadFirstCharactersEvent extends HomeEvent {
  LoadFirstCharactersEvent();

  @override
  List<Object?> get props => [];
}

class LoadNextPageEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class SetFavouriteEvent extends HomeEvent {
  final int id;
  final bool value;

  SetFavouriteEvent({required this.id, required this.value});
  @override
  List<Object?> get props => [];
}
