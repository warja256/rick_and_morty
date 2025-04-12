import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
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

    FlutterError.onError =
        (details) => GetIt.I<Talker>().handle(details.exception, details.stack);
    runApp(RickAndMortyApp());
  }, (e, st) => GetIt.I<Talker>().handle(e, st));
}
