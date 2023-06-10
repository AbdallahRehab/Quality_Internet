import 'package:get_it/get_it.dart';
import 'package:internet_speed_test/di/repositories_di.dart';
import 'package:internet_speed_test/di/use_cases_di.dart';

import 'data_sources_di.dart';

GetIt di = GetIt.instance;

Future diInit() async {
  await initializeDataSources();
  await initializeRepositories();
  await initializeUseCases();
}
