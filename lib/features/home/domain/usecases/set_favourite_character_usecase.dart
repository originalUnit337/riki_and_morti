import 'package:riki_and_morti/core/utils/usecases/usecase.dart';
import 'package:riki_and_morti/features/home/domain/repositories/character_repository.dart';

class SetFavouriteCharacterUsecase extends UseCase<void, List<dynamic>> {
  final CharacterRepository repository;

  SetFavouriteCharacterUsecase({required this.repository});
  @override
  Future<void> call({required List<dynamic> params}) {
    return repository.setFavourite(params[0], params[1]);
  }  
}