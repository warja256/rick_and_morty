import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/repositories/models/character.dart';

abstract class CharacterListState extends Equatable {
  const CharacterListState();

  @override
  List<Object?> get props => [];
}

class CharacterListInitial extends CharacterListState {}

class CharacterListLoading extends CharacterListState {}

class CharacterListLoaded extends CharacterListState {
  final List<Character> characters;

  CharacterListLoaded({required this.characters});

  @override
  List<Object?> get props => [characters];
}

class CharacterListLoadingFailure extends CharacterListState {
  final Object exception;
  const CharacterListLoadingFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
