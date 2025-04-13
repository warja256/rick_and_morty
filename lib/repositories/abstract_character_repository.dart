import 'package:rick_and_morty/repositories/models/character.dart';

abstract class AbstractCharacterRepository {
  Future<List<Character>> getCharacterList({int page});
}
