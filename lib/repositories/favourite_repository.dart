import 'package:hive/hive.dart';
import 'package:rick_and_morty/repositories/models/character.dart';

class FavouriteRepository {
  final Box<Character> _favouritesBox;

  FavouriteRepository(this._favouritesBox);

  Future<void> saveToFavourites(Character character) async {
    await _favouritesBox.put(character.id, character);
  }
}
