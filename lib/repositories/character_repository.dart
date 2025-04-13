// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:rick_and_morty/repositories/abstract_character_repository.dart';
import 'package:rick_and_morty/repositories/models/character.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CharacterRepository extends AbstractCharacterRepository {
  final Dio dio;
  final Box<Character> rickAndMortyBox;

  CharacterRepository({required this.dio, required this.rickAndMortyBox});

  final String baseUrl = 'https://rickandmortyapi.com/api/';

  Future<List<Character>> fetchCharacterListFromApi({int page = 1}) async {
    try {
      final response = await dio.get(
        '${baseUrl}character/',
        queryParameters: {'page': page},
      );

      final data = response.data['results'];

      List<Character> characters =
          (data as List).map((json) => Character.fromJson(json)).toList();

      return characters;
    } catch (e) {
      GetIt.I<Talker>().error('Ошибка при получении данных $e');
      throw Exception('Ошибка при загрузке персонажей');
    }
  }

  @override
  Future<List<Character>> getCharacterList({int page = 1}) async {
    try {
      final characterList = await fetchCharacterListFromApi(page: page);

      final charactersMap = {for (var e in characterList) e.id: e};
      await rickAndMortyBox.putAll(charactersMap);

      return characterList;
    } on Exception catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
      return rickAndMortyBox.values.toList();
    }
  }
}
