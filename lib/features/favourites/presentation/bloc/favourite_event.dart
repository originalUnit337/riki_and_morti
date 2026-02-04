import 'package:equatable/equatable.dart';

sealed class FavouriteEvent extends Equatable {}

class FavouritesStarted extends FavouriteEvent {
  @override
  List<Object?> get props => [];
}