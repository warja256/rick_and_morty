import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/repositories/models/character.dart';

abstract class FavState extends Equatable {
  const FavState();

  @override
  List<Object?> get props => [];
}

class FavStateInitial extends FavState {}

class FavListLoading extends FavState {}

class FavListLoaded extends FavState {
  final List<Character> favCharacterList;

  const FavListLoaded({required this.favCharacterList});

  @override
  List<Object?> get props => [favCharacterList];
}

class FavListLoadingFailure extends FavState {
  final Object exception;
  const FavListLoadingFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
