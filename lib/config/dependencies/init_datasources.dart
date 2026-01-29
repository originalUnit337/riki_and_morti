import 'package:riki_and_morti/config/dependencies/init.dart';
import 'package:riki_and_morti/features/home/data/data_source/local/character_drift.dart';
import 'package:riki_and_morti/features/home/data/data_source/local/character_drift_impl.dart';
import 'package:riki_and_morti/features/home/data/data_source/remote/character_api.dart';
import 'package:riki_and_morti/features/home/data/data_source/remote/character_api_impl.dart';

void initDataSources() {
  sl.registerLazySingleton<CharacterApi>(() => CharacterApiImpl(client: sl()));
  sl.registerLazySingleton<CharacterDrift>(() => CharacterDriftImpl(db: sl()));
}
