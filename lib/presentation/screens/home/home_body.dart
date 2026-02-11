import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:riki_and_morti/config/navigation/app_routes.dart';
import 'package:riki_and_morti/presentation/screens/home/bloc/home_bloc.dart';
import 'package:riki_and_morti/presentation/screens/home/bloc/home_event.dart';
import 'package:riki_and_morti/presentation/screens/home/bloc/home_state.dart';
import 'package:riki_and_morti/presentation/widgets/character_card.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riki & Morti'),
        actions: [
          IconButton(
            onPressed: () => context.goNamed(AppRoutes.favourites.name),
            icon: Icon(Icons.star),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (BuildContext context, HomeState state) {
            return switch (state) {
              HomeInitial() => Center(child: CircularProgressIndicator()),
              HomeLoadingState() => Center(child: CircularProgressIndicator()),
              HomeLoadedState() =>
                state.characters.isNotEmpty
                    ? _CharacterGrid(state: state)
                    : Center(child: Text('No characters found')),
              HomeErrorState() => Text('Error: ${state.message}'),
            };
          },
        ),
      ),
    );
  }
}

class _CharacterGrid extends StatefulWidget {
  const _CharacterGrid({required this.state});

  final HomeLoadedState state;

  @override
  State<_CharacterGrid> createState() => _CharacterGridState();
}

class _CharacterGridState extends State<_CharacterGrid> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<HomeBloc>().add(LoadNextPageEvent());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: _scrollController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount:
          widget.state.characters.length + (widget.state.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= widget.state.characters.length) {
          return const Center(child: CircularProgressIndicator());
        }
        final character = widget.state.characters[index];

        return CharacterCard(
          character: character,
          onFavoriteTap: () {
            context.read<HomeBloc>().add(
              SetFavouriteEvent(
                id: character.id,
                value: !character.isFavourite,
              ),
            );
          },
        );
      },
    );
  }
}
