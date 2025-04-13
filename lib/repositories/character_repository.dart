import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_and_morty/repositories/abstract_character_repository.dart';
import 'package:rick_and_morty/repositories/models/character.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CharacterRepository extends AbstractCharacterRepository {
  final _dio = Dio();
  final String baseUrl = 'https://rickandmortyapi.com/api/';

  @override
  Future<List<Character>> getCharacterList({int page = 1}) async {
    try {
      final response = await _dio.get(
        'baseUrl/character',
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
}
