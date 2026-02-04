import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:riki_and_morti/features/favourites/domain/usecases/watch_favourites_usecase.dart';
import 'package:riki_and_morti/features/favourites/presentation/bloc/favourite_event.dart';
import 'package:riki_and_morti/features/favourites/presentation/bloc/favourite_state.dart';
import 'package:riki_and_morti/shared/domain/entities/character_entity.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final WatchFavouritesUsecase watchFavouritesUsecase;

  FavouriteBloc({required this.watchFavouritesUsecase})
    : super(FavouriteInitial()) {
    on<FavouritesStarted>(_onStarted);
  }

  FutureOr<void> _onStarted(
    FavouritesStarted event,
    Emitter<FavouriteState> emit,
  ) async {
    await emit.forEach<List<CharacterEntity>>(
      await watchFavouritesUsecase.call(),
      onData: (items) => FavouritesLoaded(items: items),
      onError: (message, __) =>
          FavouritesErrorState(message: message.toString()),
    );
  }
}
