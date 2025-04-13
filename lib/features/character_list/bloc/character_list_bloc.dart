import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_and_morty/features/character_list/bloc/character_list_event.dart';
import 'package:rick_and_morty/features/character_list/bloc/character_list_state.dart';
import 'package:rick_and_morty/repositories/abstract_character_repository.dart';
import 'package:rick_and_morty/repositories/models/character.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CharacterListBloc extends Bloc<CharacterListEvent, CharacterListState> {
  CharacterListBloc(this.characterRepository) : super(CharacterListInitial()) {
    on<LoadCharacterList>((event, emit) async {
      try {
        if (state is CharacterListLoaded) {
          emit(CharacterListLoading());
        }
        List<Character> characters =
            await characterRepository.getCharacterList();
        print(
          "✅ Загружено: ${characters.length} персонажей, данные: $characters",
        );
        emit(CharacterListLoaded(characters: characters));
      } catch (e, st) {
        print("❌ Ошибка при загрузке персонажей: $e\n$st");
        emit(CharacterListLoadingFailure(exception: e));
        GetIt.I<Talker>().handle(e, st);
      } finally {
        event.completer?.complete();
      }
    });
  }

  final AbstractCharacterRepository characterRepository;

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
