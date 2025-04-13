import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/character_list/bloc/character_list_event.dart';
import 'package:rick_and_morty/features/character_list/bloc/character_list_state.dart';
import 'package:rick_and_morty/repositories/character_repository.dart';
import 'package:bloc/bloc.dart';

class CharacterListBloc extends Bloc<CharacterListEvent, CharacterListState> {
  final CharacterRepository repository;

  // Modify the constructor to take the concrete repository, not the abstract one
  CharacterListBloc({required this.repository})
    : super(CharacterListInitial()) {
    on<LoadCharacterList>(_onLoadInitialCharacters);
    on<LoadMoreCharacters>(_onLoadMoreCharacters);
  }

  Future<void> _onLoadInitialCharacters(
    LoadCharacterList event,
    Emitter<CharacterListState> emit,
  ) async {
    emit(CharacterListLoading());

    try {
      final characters = await repository.getCharacterList(page: 1);
      emit(
        CharacterListLoaded(
          characters: characters,
          currentPage: 1,
          isLoadingMore: false,
          hasNextPage: characters.isNotEmpty,
        ),
      );
    } catch (e) {
      emit(CharacterListError('Error loading characters: $e'));
    }
  }

  Future<void> _onLoadMoreCharacters(
    LoadMoreCharacters event,
    Emitter<CharacterListState> emit,
  ) async {
    final currentState = state;
    if (currentState is CharacterListLoaded &&
        !currentState.isLoadingMore &&
        currentState.hasNextPage) {
      emit(currentState.copyWith(isLoadingMore: true));

      try {
        final nextPage = currentState.currentPage + 1;
        final newCharacters = await repository.getCharacterList(page: nextPage);

        emit(
          currentState.copyWith(
            characters: [...currentState.characters, ...newCharacters],
            currentPage: nextPage,
            isLoadingMore: false,
            hasNextPage: newCharacters.isNotEmpty,
          ),
        );
      } catch (e) {
        emit(currentState.copyWith(isLoadingMore: false));
      }
    }
  }
}
