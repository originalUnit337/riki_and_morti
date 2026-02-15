import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riki_and_morti/config/dependencies/init.dart';
import 'package:riki_and_morti/presentation/screens/favourite/bloc/favourite_bloc.dart';
import 'package:riki_and_morti/presentation/screens/home/bloc/home_bloc.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

void initBloc() {
  Bloc.observer = TalkerBlocObserver(
    talker: sl.get<Talker>(),
    settings: TalkerBlocLoggerSettings(printStateFullData: false),
  );
  sl.registerFactory<HomeBloc>(
    () => HomeBloc(
      getPageCharacterUseCase: sl(),
      setFavouriteCharacterUsecase: sl(),
      watchFavouritesUsecase: sl(),
    ),
  );

  sl.registerFactory<FavouriteBloc>(
    () => FavouriteBloc(
      watchFavouritesUsecase: sl(),
      setFavouriteCharacterUsecase: sl(),
    ),
  );
}
