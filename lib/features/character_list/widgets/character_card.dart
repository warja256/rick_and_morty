// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/favourite/bloc/favourite_bloc.dart';
import 'package:rick_and_morty/features/favourite/bloc/favourite_event.dart';
import 'package:rick_and_morty/features/favourite/bloc/favourite_state.dart';
import 'package:rick_and_morty/repositories/models/character.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({
    Key? key,
    required this.character,
    required this.onFavoriteToggle,
  }) : super(key: key);

  final Character character;
  final VoidCallback onFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavBloc, FavState>(
      builder: (context, state) {
        bool isFavorite = false;
        if (state is FavListLoaded) {
          isFavorite = state.favCharacterList.contains(character);
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
          child: SizedBox(
            width: 540,
            height: 200,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.antiAlias,
              child: Row(
                children: [
                  // Левая часть — текст и звезда
                  Expanded(
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                character.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Text(
                                character.status,
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text(
                                character.species,
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text(
                                character.type,
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 40),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 0,
                          bottom: 0,
                          child: IconButton(
                            onPressed: () {
                              final favBloc = context.read<FavBloc>();
                              if (isFavorite) {
                                favBloc.add(
                                  RemoveFromFav(character: character),
                                );
                              } else {
                                favBloc.add(AddToFav(character: character));
                              }
                              onFavoriteToggle();
                            },
                            icon: Icon(
                              isFavorite ? Icons.star : Icons.star_border,
                              color: isFavorite ? Colors.green : Colors.grey,
                              size: 34,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    child: Image.network(
                      character.image,
                      fit: BoxFit.cover,
                      width: 170,
                      height: 200,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
