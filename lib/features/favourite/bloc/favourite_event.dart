import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/repositories/models/character.dart';

abstract class FavEvent extends Equatable {
  const FavEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavList extends FavEvent {
  final Completer? completer;
  const LoadFavList({this.completer});
}

class AddToFav extends FavEvent {
  final Character character;
  const AddToFav({required this.character});

  @override
  List<Object?> get props => [character];
}

class RemoveFromFav extends FavEvent {
  final Character character;
  const RemoveFromFav({required this.character});

  @override
  List<Object?> get props => [character];
}
