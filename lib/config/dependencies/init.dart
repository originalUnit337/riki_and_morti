import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:riki_and_morti/config/dependencies/init_datasources.dart';
import 'package:riki_and_morti/config/dependencies/init_repositories.dart';
import 'package:riki_and_morti/config/dependencies/init_usecases.dart';
import 'package:riki_and_morti/core/database/app_database.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final database = AppDatabase();
  sl.registerLazySingleton<AppDatabase>(() => database);

  final httpLink = HttpLink('https://rickandmortyapi.com/graphql');
  final graphQLClient = GraphQLClient(link: httpLink, cache: GraphQLCache());
  sl.registerLazySingleton<GraphQLClient>(() => graphQLClient);

  initDataSources();
  initRepositories();
  initUseCases();
}
