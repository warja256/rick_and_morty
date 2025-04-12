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
          child: Container(
            padding: EdgeInsets.only(top: 10),
            height: 102,
            child: BottomNavigationBar(
              onTap: tabsRouter.setActiveIndex,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
              ],
            ),
          ),
        );
      },
    );
  }
}
