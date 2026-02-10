import 'package:equatable/equatable.dart';
import 'package:riki_and_morti/domain/entities/character_entity.dart';

sealed class HomeEvent extends Equatable {}

class HomeStarted extends HomeEvent {
  @override
  List<Object?> get props => [];
}

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

class FavouritesUpdated extends HomeEvent {
  final List<CharacterEntity> favourites;
  FavouritesUpdated(this.favourites);

  @override
  List<Object?> get props => [favourites];
}
