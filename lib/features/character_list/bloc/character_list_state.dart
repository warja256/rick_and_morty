import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/repositories/models/character.dart';

abstract class CharacterListState extends Equatable {
  const CharacterListState();

  @override
  List<Object> get props => [];
}

class CharacterListInitial extends CharacterListState {}

class CharacterListLoading extends CharacterListState {}

class CharacterListLoaded extends CharacterListState {
  final List<Character> characters;
  final int currentPage;
  final bool isLoadingMore;
  final bool hasNextPage;

  const CharacterListLoaded({
    required this.characters,
    required this.currentPage,
    required this.isLoadingMore,
    required this.hasNextPage,
  });

  CharacterListLoaded copyWith({
    List<Character>? characters,
    int? currentPage,
    bool? isLoadingMore,
    bool? hasNextPage,
  }) {
    return CharacterListLoaded(
      characters: characters ?? this.characters,
      currentPage: currentPage ?? this.currentPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }

  @override
  List<Object> get props => [
    characters,
    currentPage,
    isLoadingMore,
    hasNextPage,
  ];
}

class CharacterListError extends CharacterListState {
  final String message;

  const CharacterListError(this.message);

  @override
  List<Object> get props => [message];
}
