import 'package:riki_and_morti/core/utils/usecases/usecase.dart';
import 'package:riki_and_morti/domain/entities/character_entity.dart';
import 'package:riki_and_morti/domain/repositories/favourite_character_repository.dart';

class WatchFavouritesUsecase extends UseCase<Stream<List<CharacterEntity>>, void> {
 
  final FavouriteCharacterRepository repository;

  WatchFavouritesUsecase({required this.repository});
  @override
  Future<Stream<List<CharacterEntity>>> call({void params}) async {
    return repository.watchFavourites();
  }
}