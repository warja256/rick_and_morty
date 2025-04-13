import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick_and_morty/features/favourite/bloc/favourite_bloc.dart';
import 'package:rick_and_morty/features/favourite/bloc/favourite_event.dart';
import 'package:rick_and_morty/repositories/abstract_character_repository.dart';
import 'package:rick_and_morty/repositories/character_repository.dart';
import 'package:rick_and_morty/repositories/models/character.dart';
import 'package:rick_and_morty/rick_and_morty_app.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_settings.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

const rickAndMortyBoxName = 'rick_and_morty_box';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    final talker = TalkerFlutter.init();
    GetIt.I.registerSingleton(talker);
    GetIt.I<Talker>().debug('Talker started...');

    final dio = Dio();

    dio.interceptors.add(
      TalkerDioLogger(
        talker: talker,
        settings: TalkerDioLoggerSettings(printResponseData: false),
      ),
    );

    Bloc.observer = TalkerBlocObserver(
      talker: talker,
      settings: TalkerBlocLoggerSettings(printStateFullData: false),
    );

    await Hive.initFlutter();
    Hive.registerAdapter(CharacterAdapter());

    final characterNameBox = await Hive.openBox<Character>(rickAndMortyBoxName);

    GetIt.I.registerLazySingleton<AbstractCharacterRepository>(
      () => CharacterRepository(dio: dio, rickAndMortyBox: characterNameBox),
    );

    FlutterError.onError =
        (details) => GetIt.I<Talker>().handle(details.exception, details.stack);

    // Now run the app after all async setup is complete
    runApp(
      BlocProvider(
        create: (context) => FavBloc()..add(LoadFavList(completer: null)),
        child: RickAndMortyApp(),
      ),
    );
  }, (e, st) => GetIt.I<Talker>().handle(e, st));
}
