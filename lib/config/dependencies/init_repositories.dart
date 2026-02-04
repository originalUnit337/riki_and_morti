import 'package:riki_and_morti/config/dependencies/init.dart';
import 'package:riki_and_morti/features/favourites/data/repositories/favourite_character_repository_impl.dart';
import 'package:riki_and_morti/features/favourites/domain/repositories/favourite_character_repository.dart';
import 'package:riki_and_morti/features/home/data/repositories/character_repository_impl.dart';
import 'package:riki_and_morti/features/home/domain/repositories/character_repository.dart';

void initRepositories() {
  sl.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(remote: sl(), local: sl()),
  );

  sl.registerLazySingleton<FavouriteCharacterRepository>(
    () => FavouriteCharacterRepositoryImpl(local: sl()),
  );
}
