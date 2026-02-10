import 'package:equatable/equatable.dart';
import 'package:riki_and_morti/domain/entities/character_entity.dart';

sealed class HomeState extends Equatable {}

class HomeInitial extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoadedState extends HomeState {
  final List<CharacterEntity> characters;
  final bool isLoadingMore;
  final bool hasNext;

  HomeLoadedState({
    required this.characters,
    required this.isLoadingMore,
    required this.hasNext,
  });

  @override
  List<Object?> get props => [characters, isLoadingMore, hasNext];

  HomeLoadedState copyWith({
    List<CharacterEntity>? characters,
    bool? isLoadingMore,
    bool? hasNext,
  }) {
    return HomeLoadedState(
      characters: characters ?? this.characters,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasNext: hasNext ?? this.hasNext,
    );
  }
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
