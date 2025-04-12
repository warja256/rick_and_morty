import 'package:auto_route/auto_route.dart';
import 'package:rick_and_morty/router/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: HomeRoute.page,
      path: '/',
      children: [
        AutoRoute(page: FavouriteRoute.page, path: 'fav'),
        AutoRoute(page: CharacterListRoute.page, path: 'list'),
      ],
    ),
  ];
}
