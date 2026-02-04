import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riki_and_morti/features/favourites/presentation/bloc/favourite_bloc.dart';
import 'package:riki_and_morti/features/favourites/presentation/bloc/favourite_event.dart';
import 'package:riki_and_morti/features/favourites/presentation/bloc/favourite_state.dart';
import 'package:riki_and_morti/shared/presentation/widgets/character_card.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favourites')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<FavouriteBloc, FavouriteState>(
          builder: (context, state) {
            return switch (state) {
              FavouriteInitial() => Center(child: CircularProgressIndicator()),
              FavouritesLoaded() =>
                state.items.isNotEmpty
                    ? _gridViewBuild(state, context)
                    : Center(child: Text('There is nothing here :(')),
              FavouritesErrorState() => Center(child: Text(state.message)),
            };
          },
        ),
      ),
    );
  }

  GridView _gridViewBuild(FavouritesLoaded state, BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: state.items.length,
      itemBuilder: (_, i) {
        try {
          final character = state.items[i];
          return CharacterCard(
            character: character,
            onFavoriteTap: () => context.read<FavouriteBloc>().add(
              SetFavouriteEvent(
                id: character.id,
                value: !character.isFavourite,
              ),
            ),
          );
        } catch (e) {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
