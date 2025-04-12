import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _FavouriteScreenView();
  }
}

class _FavouriteScreenView extends StatefulWidget {
  const _FavouriteScreenView();

  @override
  State<_FavouriteScreenView> createState() => _FavouriteScreenViewState();
}

class _FavouriteScreenViewState extends State<_FavouriteScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Favourite')));
  }
}
