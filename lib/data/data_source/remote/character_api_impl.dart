import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:riki_and_morti/config/dependencies/init.dart';
import 'package:riki_and_morti/core/pagination/paged_result.dart';
import 'package:riki_and_morti/data/data_source/remote/character_api.dart';
import 'package:riki_and_morti/data/models/character_model.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CharacterApiImpl implements CharacterApi {
  final GraphQLClient client;

  CharacterApiImpl({required this.client});

  @override
  Future<PagedResult<CharacterModel>> getCharacters({required int page}) async {
    String _charactersQuery = r'''
      query Characters($page: Int!) {
          characters(page: $page) {
            info {
              count
              pages
              next
              prev
            }
            results {
              id
              name
              status
              species
              image
              type
              gender
              created
              origin {
                name
              }
              location {
                name
              }
              episode {
                episode
              }
            }
          }
        }
    ''';

    final result = await client.query(
      QueryOptions(
        document: gql(_charactersQuery),
        variables: {'page': page},
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      // sl.get<Talker>()
      //   ..error(
      //     '[1/2]GraphQL query error',
      //     result.exception,
      //     result.exception!.originalStackTrace,
      //   )
      //   ..error('''[2/2]GraphQL query error: \n
      //   ${result.exception!.graphqlErrors} \n
      //   [LINK EXCEPTION] ${result.exception!.linkException}
      //   ''');
        sl.get<Talker>().error(result.exception.toString());
      throw result.exception!;
    }

    final data = result.data!['characters'];

    final results = (data['results'] as List)
        .map((json) => CharacterModel.fromJson(json))
        .toList();

    final hasNext = data['info']['next'] != null;

    return PagedResult(items: results, hasNext: hasNext);
  }
}
