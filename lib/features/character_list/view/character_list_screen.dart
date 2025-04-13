import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_and_morty/features/character_list/bloc/character_list_bloc.dart';
import 'package:rick_and_morty/features/character_list/bloc/character_list_event.dart';
import 'package:rick_and_morty/features/character_list/bloc/character_list_state.dart';
import 'package:rick_and_morty/features/character_list/widgets/character_card.dart';
import 'package:rick_and_morty/features/favourite/bloc/favourite_bloc.dart';
import 'package:rick_and_morty/features/favourite/bloc/favourite_event.dart';
import 'package:rick_and_morty/features/favourite/bloc/favourite_state.dart';
import 'package:rick_and_morty/repositories/abstract_character_repository.dart';
import 'package:rick_and_morty/repositories/character_repository.dart';
import 'package:rick_and_morty/repositories/models/character.dart';

@RoutePage()
class CharacterListScreen extends StatelessWidget {
  const CharacterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              CharacterListBloc(GetIt.I<AbstractCharacterRepository>())
                ..add(LoadCharacterList()),
      child: _MyWidgetView(),
    );
  }
}

class _MyWidgetView extends StatefulWidget {
  const _MyWidgetView();

  @override
  State<_MyWidgetView> createState() => _MyWidgetViewState();
}

class _MyWidgetViewState extends State<_MyWidgetView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final thresholdReached =
        _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200;

    if (thresholdReached) {
      final bloc = context.read<CharacterListBloc>();
      final state = bloc.state;

      if (state is CharacterListLoaded &&
          !state.isLoadingMore &&
          state.hasNextPage) {
        bloc.add(LoadMoreCharacters());
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _characterListBloc = context.read<CharacterListBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Rick and Morty'),
        actions: [],
        shadowColor: Colors.blueGrey,
        elevation: 3,
      ),
      body: RefreshIndicator(
        child: BlocBuilder<CharacterListBloc, CharacterListState>(
          builder: (context, state) {
            if (state is CharacterListLoaded) {
              List<Character> characters = state.characters;
              return characters.isEmpty
                  ? const Center(child: Text('No results found'))
                  : ListView.builder(
                    controller: _scrollController,
                    itemCount: characters.length + 1,
                    itemBuilder: (context, index) {
                      if (index < characters.length) {
                        final character = characters[index];
                        return CharacterCard(
                          character: character,
                          onFavoriteToggle: () {
                            final isFavorite =
                                context.read<FavBloc>().state
                                    is FavListLoaded &&
                                (context.read<FavBloc>().state as FavListLoaded)
                                    .favCharacterList
                                    .contains(character);
                            if (isFavorite) {
                              context.read<FavBloc>().add(
                                RemoveFromFav(character: character),
                              );
                            } else {
                              context.read<FavBloc>().add(
                                AddToFav(character: character),
                              );
                            }
                          },
                        );
                      } else {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                    },
                  );
            }
            if (state is CharacterListError) {
              return _ErrorView(
                retry: () {
                  _characterListBloc.add(LoadCharacterList(completer: null));
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
        onRefresh: () async {
          final completerCharacterList = Completer();
          _characterListBloc.add(
            LoadCharacterList(completer: completerCharacterList),
          );
          await Future.wait([completerCharacterList.future]);
        },
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final VoidCallback retry;
  const _ErrorView({required this.retry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Something went wrong',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 10),
          Text(
            'Please try again later',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 16,
              color: Colors.white54,
            ),
          ),
          const SizedBox(height: 30),
          TextButton(onPressed: retry, child: const Text('Try again')),
        ],
      ),
    );
  }
}
