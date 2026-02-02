import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riki_and_morti/features/home/presentation/bloc/home_bloc.dart';
import 'package:riki_and_morti/features/home/presentation/bloc/home_event.dart';
import 'package:riki_and_morti/features/home/presentation/bloc/home_state.dart';
import 'package:riki_and_morti/features/home/presentation/widgets/character_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
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
    return Scaffold(
      appBar: AppBar(title: Text('Riki & Morti'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (BuildContext context, HomeState state) {
            return switch (state) {
              HomeInitial() => Center(child: CircularProgressIndicator()),
              HomeLoadingState() => Center(child: CircularProgressIndicator()),
              HomeLoadedState() => _buildGridView(state),
              HomeErrorState() => Text('Error: ${state.message}'),
            };
          },
        ),
      ),
    );
  }

  Widget _buildGridView(HomeLoadedState state) {
    return state.characters.isNotEmpty
        ? GridView.builder(
            controller: _scrollController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: state.characters.length + (state.isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index >= state.characters.length) {
                return const Center(child: CircularProgressIndicator());
              }
              final character = state.characters[index];

              return CharacterCard(character: character, onFavoriteTap: () {});
            },
          )
        : Center(child: Text('No characters found'));
  }
}
