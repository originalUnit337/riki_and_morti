import 'package:riki_and_morti/config/dependencies/init.dart';
import 'package:riki_and_morti/features/home/domain/usecases/get_all_characters_usecase.dart';
import 'package:riki_and_morti/features/home/domain/usecases/get_page_character_usecase.dart';

void initUseCases() {
  sl.registerFactory(() => GetAllCharactersUseCase(repository: sl()));
  sl.registerFactory(() => GetPageCharacterUsecase(repository: sl()));
}