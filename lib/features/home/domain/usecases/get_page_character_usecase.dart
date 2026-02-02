import 'package:riki_and_morti/core/common/paged_result.dart';
import 'package:riki_and_morti/core/utils/usecases/usecase.dart';
import 'package:riki_and_morti/features/home/domain/entities/character_entity.dart';
import 'package:riki_and_morti/features/home/domain/repositories/character_repository.dart';

class GetPageCharacterUsecase
    extends UseCase<PagedResult<CharacterEntity>, int> {
  final CharacterRepository repository;

  GetPageCharacterUsecase({required this.repository});

  @override
  Future<PagedResult<CharacterEntity>> call({required int params}) {
    return repository.getCharacters(page: params);
  }
}
