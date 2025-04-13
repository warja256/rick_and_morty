import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_and_morty/features/favourite/bloc/favourite_event.dart';
import 'package:rick_and_morty/features/favourite/bloc/favourite_state.dart';
import 'package:rick_and_morty/repositories/models/character.dart';
import 'package:talker_flutter/talker_flutter.dart';

class FavBloc extends Bloc<FavEvent, FavState> {
  final List<Character> _favCharacterList = [];

  FavBloc() : super(FavStateInitial()) {
    on<LoadFavList>((event, emit) {
      try {
        GetIt.I<Talker>().debug('Загрузка избранных персонажей');
        emit(FavListLoading());
        emit(
          FavListLoaded(favCharacterList: List.from(_favCharacterList)),
        ); // копия списка
      } catch (e, st) {
        GetIt.I<Talker>().error('Ошибка загрузка избранных персонажей');
        emit(FavListLoadingFailure(exception: e));
        GetIt.I<Talker>().handle(e, st);
      } finally {
        event.completer?.complete();
      }
    });

    on<AddToFav>((event, emit) {
      if (!_favCharacterList.contains(event.character)) {
        _favCharacterList.add(event.character);
        GetIt.I<Talker>().debug(
          'Персонаж добавлен в избранное: ${event.character.name}',
        );
        emit(FavListLoaded(favCharacterList: List.from(_favCharacterList)));
      }
    });

    on<RemoveFromFav>((event, emit) {
      if (_favCharacterList.contains(event.character)) {
        _favCharacterList.remove(event.character);
        GetIt.I<Talker>().debug(
          'Персонаж удалён из избранное: ${event.character.name}',
        );
        emit(FavListLoaded(favCharacterList: List.from(_favCharacterList)));
      }
    });
  }
}
