import 'package:riki_and_morti/core/utils/usecases/usecase.dart';
import 'package:riki_and_morti/features/favourites/domain/repositories/favourite_character_repository.dart';
import 'package:riki_and_morti/shared/domain/entities/character_entity.dart';

class WatchFavouritesUsecase extends UseCase<Stream<List<CharacterEntity>>, void> {
 
  final FavouriteCharacterRepository repository;

  WatchFavouritesUsecase({required this.repository});
  @override
  Future<Stream<List<CharacterEntity>>> call({void params}) async {
    return repository.watchFavourites();
  }
}