import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:riki_and_morti/features/home/domain/entities/character_entity.dart';
import 'package:riki_and_morti/features/home/domain/usecases/get_page_character_usecase.dart';
import 'package:riki_and_morti/features/home/presentation/bloc/home_event.dart';
import 'package:riki_and_morti/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  int _page = 1;
  bool _hasNext = true;
  bool _isLoading = false;

  List<CharacterEntity> characters = [];

  final GetPageCharacterUsecase getPageCharacterUseCase;

  HomeBloc(this.getPageCharacterUseCase) : super(HomeInitial()) {
    on<LoadFirstCharactersEvent>(_loadFirstPageCharacters);
    on<LoadNextPageEvent>(_loadNextPageCharacters);
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
}
