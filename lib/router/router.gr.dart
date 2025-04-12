// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:rick_and_morty/features/character_list/view/character_list_screen.dart'
    as _i1;
import 'package:rick_and_morty/features/favourite/view/favourite_screen.dart'
    as _i2;
import 'package:rick_and_morty/features/home/home_page.dart' as _i3;

/// generated route for
/// [_i1.CharacterListScreen]
class CharacterListRoute extends _i4.PageRouteInfo<void> {
  const CharacterListRoute({List<_i4.PageRouteInfo>? children})
    : super(CharacterListRoute.name, initialChildren: children);

  static const String name = 'CharacterListRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.CharacterListScreen();
    },
  );
}

/// generated route for
/// [_i2.FavouriteScreen]
class FavouriteRoute extends _i4.PageRouteInfo<void> {
  const FavouriteRoute({List<_i4.PageRouteInfo>? children})
    : super(FavouriteRoute.name, initialChildren: children);

  static const String name = 'FavouriteRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.FavouriteScreen();
    },
  );
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute({List<_i4.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomePage();
    },
  );
}
