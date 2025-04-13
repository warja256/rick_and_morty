import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/router/router.gr.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [CharacterListRoute(), FavouriteRoute()],
      bottomNavigationBuilder: (__, tabsRouter) {
        return SafeArea(
          bottom: false,
          child: Material(
            elevation: 12,
            shadowColor: Colors.blueGrey,
            child: BottomNavigationBar(
              currentIndex: tabsRouter.activeIndex,
              onTap: tabsRouter.setActiveIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, size: 30),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite, size: 30),
                  label: '',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
