import 'package:riki_and_morti/config/dependencies/init.dart';
import 'package:riki_and_morti/features/favourites/presentation/bloc/favourite_bloc.dart';
import 'package:riki_and_morti/features/home/presentation/bloc/home_bloc.dart';

void initBloc() {
  sl.registerFactory<HomeBloc>(
    () => HomeBloc(
      getPageCharacterUseCase: sl(),
      setFavouriteCharacterUsecase: sl(),
    ),
  );

  sl.registerFactory<FavouriteBloc>(() => FavouriteBloc(watchFavouritesUsecase: sl()));
}
