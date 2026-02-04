import 'package:equatable/equatable.dart';

sealed class FavouriteEvent extends Equatable {}

class FavouritesStarted extends FavouriteEvent {
  @override
  List<Object?> get props => [];
}

class SetFavouriteEvent extends FavouriteEvent {
  final int id;
  final bool value;

  SetFavouriteEvent({required this.id, required this.value});
  @override
  List<Object?> get props => [];
}