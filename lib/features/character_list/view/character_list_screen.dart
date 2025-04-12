import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/character_list/widgets/character_card.dart';

@RoutePage()
class CharacterListScreen extends StatelessWidget {
  const CharacterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _MyWidgetView();
    // return MultiBlocProvider(providers: [], child: _MyWidgetView());
  }
}

class _MyWidgetView extends StatefulWidget {
  const _MyWidgetView();

  @override
  State<_MyWidgetView> createState() => _MyWidgetViewState();
}

class _MyWidgetViewState extends State<_MyWidgetView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rick and Morty'), actions: [

        ],
      ),
      body: RefreshIndicator(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return CharacterCard();
                },
                itemCount: 10,
              ),
            ),
          ],
        ),
        onRefresh: () async {},
      ),
    );
  }
}
