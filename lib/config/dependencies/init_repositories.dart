import 'package:riki_and_morti/config/dependencies/init.dart';
import 'package:riki_and_morti/data/repositories/favourite_character_repository_impl.dart';
import 'package:riki_and_morti/domain/repositories/favourite_character_repository.dart';
import 'package:riki_and_morti/data/repositories/character_repository_impl.dart';
import 'package:riki_and_morti/domain/repositories/character_repository.dart';

void initRepositories() {
  sl.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(remote: sl(), local: sl()),
  );

  sl.registerLazySingleton<FavouriteCharacterRepository>(
    () => FavouriteCharacterRepositoryImpl(local: sl()),
  );
}
