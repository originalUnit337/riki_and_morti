import 'package:riki_and_morti/config/dependencies/init.dart';
import 'package:riki_and_morti/features/favourites/domain/usecases/set_favourite_character_usecase.dart' as favourite;
import 'package:riki_and_morti/features/favourites/domain/usecases/watch_favourites_usecase.dart';
import 'package:riki_and_morti/features/home/domain/usecases/get_all_characters_usecase.dart';
import 'package:riki_and_morti/features/home/domain/usecases/get_page_character_usecase.dart';
import 'package:riki_and_morti/features/home/domain/usecases/set_favourite_character_usecase.dart' as home;

void initUseCases() {
  // HOME UseCases
  sl.registerFactory(() => GetAllCharactersUseCase(repository: sl()));
  sl.registerFactory(() => GetPageCharacterUsecase(repository: sl()));
  sl.registerFactory(() => home.SetFavouriteCharacterUsecase(repository: sl()));

  // Favourites UseCases
  sl.registerFactory(() => WatchFavouritesUsecase(repository: sl()));
  sl.registerFactory(() => favourite.SetFavouriteCharacterUsecase(repository: sl()));
}