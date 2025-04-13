import 'dart:async';

import 'package:equatable/equatable.dart';

abstract class CharacterListEvent extends Equatable {
  const CharacterListEvent();

  @override
  List<Object?> get props => [];
}

class LoadCharacterList extends CharacterListEvent {
  final Completer? completer;
  const LoadCharacterList({this.completer});
}

class LoadMoreCharacters extends CharacterListEvent {}
