import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:riki_and_morti/core/mixins/pagination_mixin.dart';
import 'package:riki_and_morti/domain/entities/character_entity.dart';
import 'package:riki_and_morti/domain/usecases/set_favourite_character_usecase.dart';
import 'package:riki_and_morti/domain/usecases/get_page_character_usecase.dart';
import 'package:riki_and_morti/domain/usecases/watch_favourites_usecase.dart';
import 'package:riki_and_morti/presentation/screens/home/bloc/home_event.dart';
import 'package:riki_and_morti/presentation/screens/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>
    with PaginationMixin<CharacterEntity> {
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
    on<LoadFirstCharactersEvent>(_loadFirstPageCharacters);
    on<LoadNextPageEvent>(_loadNextPageCharacters);
    on<SetFavouriteEvent>(_setFavourite);
    on<FavouritesUpdated>(_onFavouritesChanged);
    on<HomeStarted>(_onStarted);
  }

  FutureOr<void> _onStarted(HomeStarted event, Emitter<HomeState> emit) async {
    await emit.forEach<List<CharacterEntity>>(
      await watchFavouritesUsecase.call(),
      onData: (favourites) {
        _syncFavourites(favourites);
        return _buildLoadedState();
      },
      onError: (error, _) => HomeErrorState(message: error.toString()),
    );
  }

  void _syncFavourites(List<CharacterEntity> favourites) {
    final favouriteIds = favourites.map((e) => e.id).toSet();

    items.replaceRange(
      0,
      items.length,
      items.map((e) => e.copyWith(isFavourite: favouriteIds.contains(e.id))),
    );
  }

  HomeLoadedState _buildLoadedState() {
    return HomeLoadedState(
      characters: List.from(items),
      isLoadingMore: isLoading,
      hasNext: hasNext,
    );
  }

  @override
  Future<void> close() {
    _favouritesSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _onFavouritesChanged(
    FavouritesUpdated event,
    Emitter<HomeState> emit,
  ) {
    final favouriteIds = event.favourites.map((e) => e.id).toSet();

    items.replaceRange(
      0,
      items.length,
      items.map((e) => e.copyWith(isFavourite: favouriteIds.contains(e.id))),
    );

    if (state is HomeLoadedState) {
      emit(
        HomeLoadedState(
          characters: List.from(items),
          isLoadingMore: isLoading,
          hasNext: hasNext,
        ),
      );
    }
  }

  FutureOr<void> _loadFirstPageCharacters(
    LoadFirstCharactersEvent event,
    Emitter<HomeState> emit,
  ) async {
    resetPagination();
    emit(HomeLoadingState());

    try {
      final result = await getPageCharacterUseCase.call(params: page);

      hasNext = result.hasNext;
      items.addAll(
        result.items.map(
          (e) => e.copyWith(isFavourite: _favouriteIds.contains(e.id)),
        ),
      );

      emit(
        HomeLoadedState(
          characters: List.from(items),
          isLoadingMore: false,
          hasNext: hasNext,
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
    if (!canLoadNext) return;

    isLoading = true;
    emit((state as HomeLoadedState).copyWith(isLoadingMore: true));

    try {
      final result = await getPageCharacterUseCase.call(params: ++page);

      hasNext = result.hasNext;
      items.addAll(
        result.items.map(
          (e) => e.copyWith(isFavourite: _favouriteIds.contains(e.id)),
        ),
      );
    } catch (_) {
    } finally {
      isLoading = false;
    }

    emit(
      HomeLoadedState(
        characters: List.from(items),
        isLoadingMore: false,
        hasNext: hasNext,
      ),
    );
  }

  FutureOr<void> _setFavourite(
    SetFavouriteEvent event,
    Emitter<HomeState> emit,
  ) async {
    // items.replaceRange(
    //   0,
    //   items.length,
    //   items.map(
    //     (e) => e.id == event.id ? e.copyWith(isFavourite: event.value) : e,
    //   ),
    // );

    // setFavouriteCharacterUsecase.call(params: [event.id, event.value]);

    // emit(
    //   HomeLoadedState(
    //     characters: List.from(items),
    //     isLoadingMore: false,
    //     hasNext: hasNext,
    //   ),
    // );
    setFavouriteCharacterUsecase.call(params: [event.id, event.value]);
  }
}
