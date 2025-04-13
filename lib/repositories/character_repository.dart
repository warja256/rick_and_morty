// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:rick_and_morty/repositories/abstract_character_repository.dart';
import 'package:rick_and_morty/repositories/models/character.dart';

class CharacterRepository implements AbstractCharacterRepository {
  final Dio dio;
  final Box<Character> rickAndMortyBox;

  CharacterRepository({required this.dio, required this.rickAndMortyBox});

  @override
  Future<List<Character>> getCharacterList({int page = 1}) async {
    List<Character> cachedCharacters = [];

    try {
      cachedCharacters = rickAndMortyBox.values.toList();
      if (cachedCharacters.isNotEmpty) {
        return cachedCharacters;
      }

      final response = await dio.get(
        'https://rickandmortyapi.com/api/character',
        queryParameters: {'page': page},
      );

      final characters =
          (response.data['results'] as List)
              .map((characterJson) => Character.fromJson(characterJson))
              .toList();

      for (var character in characters) {
        await rickAndMortyBox.put(character.id, character);
      }

      return characters;
    } catch (e) {
      if (cachedCharacters.isNotEmpty) {
        return cachedCharacters;
      } else {
        throw Exception('Error loading characters');
      }
    }
  }
}
