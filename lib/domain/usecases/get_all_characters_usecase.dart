import 'package:riki_and_morti/core/utils/usecases/usecase.dart';
import 'package:riki_and_morti/domain/entities/character_entity.dart';
import 'package:riki_and_morti/domain/repositories/character_repository.dart';

class GetAllCharactersUseCase extends UseCase<List<CharacterEntity>, int> {
  final CharacterRepository repository;

  GetAllCharactersUseCase({required this.repository});

  @override
  Future<List<CharacterEntity>> call({required int params}) async {
    // ? 0 ?
    final result = await repository.getCharacters(page: params);
    return result.items;
  }
}