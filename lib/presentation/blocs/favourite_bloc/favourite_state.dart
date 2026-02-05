import 'package:equatable/equatable.dart';
import 'package:riki_and_morti/domain/entities/character_entity.dart';

sealed class FavouriteState extends Equatable {}

class FavouriteInitial extends FavouriteState {
  @override
  List<Object?> get props => [];

}

class FavouritesLoaded extends FavouriteState {
  final List<CharacterEntity> items;

  FavouritesLoaded({required this.items});

  @override
  List<Object?> get props => [items];
}

class FavouritesErrorState extends FavouriteState {
  final String message;

  FavouritesErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}