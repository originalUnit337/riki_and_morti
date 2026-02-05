import 'package:riki_and_morti/config/dependencies/init.dart';
import 'package:riki_and_morti/domain/usecases/get_all_characters_usecase.dart';
import 'package:riki_and_morti/domain/usecases/get_page_character_usecase.dart';
import 'package:riki_and_morti/domain/usecases/set_favourite_character_fav_repo_usecase.dart';
import 'package:riki_and_morti/domain/usecases/set_favourite_character_usecase.dart';
import 'package:riki_and_morti/domain/usecases/watch_favourites_usecase.dart';

void initUseCases() {
  // HOME UseCases
  sl.registerFactory(() => GetAllCharactersUseCase(repository: sl()));
  sl.registerFactory(() => GetPageCharacterUsecase(repository: sl()));
  sl.registerFactory(() => SetFavouriteCharacterUsecase(repository: sl()));

  // Favourites UseCases
  sl.registerFactory(() => WatchFavouritesUsecase(repository: sl()));
  sl.registerFactory(() => SetFavouriteCharacterFavRepoUsecase(repository: sl()));
}