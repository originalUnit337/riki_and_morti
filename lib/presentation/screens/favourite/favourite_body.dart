import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riki_and_morti/presentation/screens/favourite/bloc/favourite_bloc.dart';
import 'package:riki_and_morti/presentation/screens/favourite/bloc/favourite_event.dart';
import 'package:riki_and_morti/presentation/screens/favourite/bloc/favourite_state.dart';
import 'package:riki_and_morti/presentation/widgets/character_card.dart';

class FavouriteBody extends StatelessWidget {
  const FavouriteBody({super.key});

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
                    ? _FavouriteGrid(state: state)
                    : Center(child: Text('There is nothing here :(')),
              FavouritesErrorState() => Center(child: Text(state.message)),
            };
          },
        ),
      ),
    );
  }
}

class _FavouriteGrid extends StatelessWidget {
  final FavouritesLoaded state;

  const _FavouriteGrid({required this.state});
  @override
  Widget build(BuildContext context) {
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
