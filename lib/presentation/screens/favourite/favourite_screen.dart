import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riki_and_morti/config/dependencies/init.dart';
import 'package:riki_and_morti/presentation/screens/favourite/bloc/favourite_bloc.dart';
import 'package:riki_and_morti/presentation/screens/favourite/bloc/favourite_event.dart';
import 'package:riki_and_morti/presentation/screens/favourite/favourite_body.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return sl<FavouriteBloc>()..add(FavouritesStarted());
      },
      child: const FavouriteBody(),
    );
  }
}
