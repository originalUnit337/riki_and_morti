import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:riki_and_morti/domain/entities/character_entity.dart';
import 'package:riki_and_morti/domain/usecases/set_favourite_character_usecase.dart';
import 'package:riki_and_morti/domain/usecases/get_page_character_usecase.dart';
import 'package:riki_and_morti/presentation/blocs/home_bloc/home_event.dart';
import 'package:riki_and_morti/presentation/blocs/home_bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  int _page = 1;
  bool _hasNext = true;
  bool _isLoading = false;

  List<CharacterEntity> characters = [];

  final GetPageCharacterUsecase getPageCharacterUseCase;
  final SetFavouriteCharacterUsecase setFavouriteCharacterUsecase;

  HomeBloc({
    required this.getPageCharacterUseCase,
    required this.setFavouriteCharacterUsecase,
  }) : super(HomeInitial()) {
    on<LoadFirstCharactersEvent>(_loadFirstPageCharacters);
    on<LoadNextPageEvent>(_loadNextPageCharacters);
    on<SetFavouriteEvent>(_setFavourite);
  }

  FutureOr<void> _loadFirstPageCharacters(
    LoadFirstCharactersEvent event,
    Emitter<HomeState> emit,
  ) async {
    _page = 1;
    _hasNext = true;
    emit(HomeLoadingState());
    try {
      final newCharacters = await getPageCharacterUseCase.call(params: _page);
      _hasNext = newCharacters.hasNext;
      characters.addAll(newCharacters.items);
      emit(
        HomeLoadedState(
          characters: characters,
          isLoadingMore: false,
          hasNext: _hasNext,
        ),
      );
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  FutureOr<void> _loadNextPageCharacters(
    LoadNextPageEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (_isLoading || !_hasNext) return;
    _isLoading = true;

    emit((state as HomeLoadedState).copyWith(isLoadingMore: true));

    try {
      final result = await getPageCharacterUseCase.call(params: ++_page);
      _hasNext = result.hasNext;
      _isLoading = false;

      characters.addAll(result.items);

      emit(
        HomeLoadedState(
          characters: characters,
          isLoadingMore: false,
          hasNext: _hasNext,
        ),
      );
    } catch (e) {
      _isLoading = false;
      emit((state as HomeLoadedState).copyWith(isLoadingMore: false));
    }
  }

  FutureOr<void> _setFavourite(
    SetFavouriteEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      characters = characters
          .map(
            (e) => e.id == event.id ? e.copyWith(isFavourite: event.value) : e,
          )
          .toList();
      setFavouriteCharacterUsecase.call(params: [event.id, event.value]);
      emit(
        HomeLoadedState(
          characters: characters,
          isLoadingMore: false,
          hasNext: _hasNext,
        ),
      );
    } catch (e) {}
  }
}
