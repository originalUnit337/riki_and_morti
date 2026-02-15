import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:riki_and_morti/core/pagination/paged_result.dart';
import 'package:riki_and_morti/core/pagination/bloc_pagination_mixin.dart';
import 'package:riki_and_morti/domain/entities/character_entity.dart';
import 'package:riki_and_morti/domain/usecases/set_favourite_character_usecase.dart';
import 'package:riki_and_morti/domain/usecases/get_page_character_usecase.dart';
import 'package:riki_and_morti/domain/usecases/watch_favourites_usecase.dart';
import 'package:riki_and_morti/presentation/screens/home/bloc/home_event.dart';
import 'package:riki_and_morti/presentation/screens/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>
    with BlocPaginationMixin<CharacterEntity> {
  final GetPageCharacterUsecase getPageCharacterUseCase;
  final SetFavouriteCharacterUsecase setFavouriteCharacterUsecase;

  final WatchFavouritesUsecase watchFavouritesUsecase;

  late final StreamSubscription<List<CharacterEntity>> _favouritesSubscription;

  final Set<int> _favouriteIds = {};

  HomeBloc({
    required this.getPageCharacterUseCase,
    required this.setFavouriteCharacterUsecase,
    required this.watchFavouritesUsecase,
  }) : super(HomeInitial()) {
    setFavouriteIdsCallback(() => _favouriteIds);
    on<LoadFirstCharactersEvent>(_onLoadFirst);
    on<LoadNextPageEvent>(_onLoadNext);
    on<SetFavouriteEvent>(_setFavourite);
    on<FavouritesUpdated>(_onFavouritesChanged);
    on<HomeStarted>(_onStarted);
  }

  Future<PagedResult<CharacterEntity>> _fetchCharacters(int page) =>
      getPageCharacterUseCase.call(params: page);

  CharacterEntity _updateCharacter(CharacterEntity char, Set<int> favourites) =>
      char.copyWith(isFavourite: favourites.contains(char.id));

  FutureOr<void> _onStarted(HomeStarted event, Emitter<HomeState> emit) async {
    await emit.forEach<List<CharacterEntity>>(
      await watchFavouritesUsecase.call(),
      onData: (favourites) {
        _syncFavourites(favourites);
        return HomeLoadedState(
          characters: List.from(items),
          isLoadingMore: isLoading,
          hasNext: hasNext,
        );
      },
      onError: (error, _) => HomeErrorState(message: error.toString()),
    );
  }

  void _syncFavourites(List<CharacterEntity> favourites) {
    _favouriteIds.clear();
    _favouriteIds.addAll(favourites.map((e) => e.id).toSet());

    for (int i = 0; i < items.length; i++) {
      items[i] = items[i].copyWith(
        isFavourite: _favouriteIds.contains(items[i].id),
      );
    }
  }

  @override
  Future<void> close() {
    _favouritesSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _onFavouritesChanged(
    FavouritesUpdated event,
    Emitter<HomeState> emit,
  ) async {
    _syncFavourites(event.favourites);
    if (state is HomeLoadedState) {
      _emitCurrentState(emit);
    }
  }

  FutureOr<void> _onLoadFirst(
    LoadFirstCharactersEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    try {
      await loadFirstPage(
        fetchData: _fetchCharacters,
        updateItem: _updateCharacter,
      );
      _emitCurrentState(emit);
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  FutureOr<void> _onLoadNext(
    LoadNextPageEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (!canLoadNext) return;

    emit((state as HomeLoadedState).copyWith(isLoadingMore: true));
    try {
      await loadNextPage(
        fetchData: _fetchCharacters,
        updateItem: _updateCharacter,
      );
      _emitCurrentState(emit);
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  void _emitCurrentState(Emitter<HomeState> emit) {
    emit(
      HomeLoadedState(
        characters: List.from(items),
        isLoadingMore: isLoading,
        hasNext: hasNext,
      ),
    );
  }

  FutureOr<void> _setFavourite(
    SetFavouriteEvent event,
    Emitter<HomeState> emit,
  ) async {
    setFavouriteCharacterUsecase.call(params: [event.id, event.value]);
  }
}
