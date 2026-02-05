import 'package:riki_and_morti/core/utils/usecases/usecase.dart';
import 'package:riki_and_morti/domain/repositories/favourite_character_repository.dart';

class SetFavouriteCharacterFavRepoUsecase extends UseCase<void, List<dynamic>> {
  final FavouriteCharacterRepository repository;

  SetFavouriteCharacterFavRepoUsecase({required this.repository});
  @override
  Future<void> call({required List<dynamic> params}) {
    return repository.setFavourite(params[0], params[1]);
  }  
}