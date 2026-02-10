import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:riki_and_morti/domain/entities/character_entity.dart';
import 'package:riki_and_morti/domain/usecases/set_favourite_character_usecase.dart';
import 'package:riki_and_morti/domain/usecases/watch_favourites_usecase.dart';
import 'package:riki_and_morti/presentation/screens/favourite/bloc/favourite_event.dart';
import 'package:riki_and_morti/presentation/screens/favourite/bloc/favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final WatchFavouritesUsecase watchFavouritesUsecase;
  final SetFavouriteCharacterUsecase setFavouriteCharacterUsecase;

  FavouriteBloc({
    required this.watchFavouritesUsecase,
    required this.setFavouriteCharacterUsecase,
  }) : super(FavouriteInitial()) {
    on<FavouritesStarted>(_onStarted);
    on<SetFavouriteEvent>(_setFavourite);
  }

  FutureOr<void> _onStarted(
    FavouritesStarted event,
    Emitter<FavouriteState> emit,
  ) async {
    await emit.forEach<List<CharacterEntity>>(
      await watchFavouritesUsecase.call(),
      onData: (items) => FavouritesLoaded(items: items),
      onError: (message, _) =>
          FavouritesErrorState(message: message.toString()),
    );
  }

  FutureOr<void> _setFavourite(
    SetFavouriteEvent event,
    Emitter<FavouriteState> emit,
  ) async {
    try {
      setFavouriteCharacterUsecase.call(params: [event.id, event.value]);
    } catch (e) {
      emit(FavouritesErrorState(message: e.toString()));
    }
  }
}
