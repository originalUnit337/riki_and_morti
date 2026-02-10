import 'package:riki_and_morti/config/dependencies/init.dart';
import 'package:riki_and_morti/presentation/screens/favourite/bloc/favourite_bloc.dart';
import 'package:riki_and_morti/presentation/screens/home/bloc/home_bloc.dart';

void initBloc() {
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
