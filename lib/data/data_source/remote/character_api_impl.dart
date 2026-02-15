import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:riki_and_morti/core/pagination/paged_result.dart';
import 'package:riki_and_morti/data/data_source/remote/character_api.dart';
import 'package:riki_and_morti/data/models/character_model.dart';

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
