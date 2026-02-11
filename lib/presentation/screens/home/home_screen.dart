import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riki_and_morti/config/dependencies/init.dart';
import 'package:riki_and_morti/presentation/screens/home/bloc/home_bloc.dart';
import 'package:riki_and_morti/presentation/screens/home/bloc/home_event.dart';
import 'package:riki_and_morti/presentation/screens/home/home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) {
        return sl<HomeBloc>()
          ..add(LoadFirstCharactersEvent())
          ..add(HomeStarted());
      },
      child: const HomeBody(),
    );
  }
}
