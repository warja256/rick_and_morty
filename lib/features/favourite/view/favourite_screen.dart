import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/character_list/widgets/character_card.dart';
import 'package:rick_and_morty/features/favourite/bloc/favourite_bloc.dart';
import 'package:rick_and_morty/features/favourite/bloc/favourite_event.dart';
import 'package:rick_and_morty/features/favourite/bloc/favourite_state.dart';
import 'package:rick_and_morty/repositories/models/character.dart';

@RoutePage()
class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _FavouriteScreenView();
  }
}

class _FavouriteScreenView extends StatefulWidget {
  const _FavouriteScreenView();

  @override
  State<_FavouriteScreenView> createState() => _FavouriteScreenViewState();
}

class _FavouriteScreenViewState extends State<_FavouriteScreenView> {
  String? _selectedStatus;

  @override
  Widget build(BuildContext context) {
    final _favBloc = context.read<FavBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite'),
        shadowColor: Colors.blueGrey,
        elevation: 3,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                const Text('Filter by status:', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: _selectedStatus,
                  hint: const Text('Select status'),
                  items: const [
                    DropdownMenuItem(value: 'Alive', child: Text('Alive')),
                    DropdownMenuItem(value: 'Dead', child: Text('Dead')),
                    DropdownMenuItem(value: 'unknown', child: Text('Unknown')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedStatus = value;
                    });
                  },
                ),
                if (_selectedStatus != null)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _selectedStatus = null;
                      });
                    },
                  ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () {
                final completer = Completer();
                _favBloc.add(LoadFavList(completer: completer));
                return completer.future;
              },
              child: BlocBuilder<FavBloc, FavState>(
                builder: (context, state) {
                  if (state is FavListLoaded) {
                    List<Character> characters = state.favCharacterList;

                    if (_selectedStatus != null) {
                      characters =
                          characters
                              .where(
                                (c) =>
                                    c.status.toLowerCase() ==
                                    _selectedStatus!.toLowerCase(),
                              )
                              .toList();
                    }

                    if (characters.isEmpty) {
                      return const Center(
                        child: Text('No favorite characters'),
                      );
                    }

                    return ListView.builder(
                      itemCount: characters.length,
                      itemBuilder: (context, i) {
                        final favCharacter = characters[i];
                        return CharacterCard(
                          character: favCharacter,
                          onFavoriteToggle: () {
                            final isFavorite =
                                context.read<FavBloc>().state
                                    is FavListLoaded &&
                                (context.read<FavBloc>().state as FavListLoaded)
                                    .favCharacterList
                                    .contains(favCharacter);

                            if (isFavorite) {
                              context.read<FavBloc>().add(
                                RemoveFromFav(character: favCharacter),
                              );
                            } else {
                              context.read<FavBloc>().add(
                                AddToFav(character: favCharacter),
                              );
                            }
                          },
                        );
                      },
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
