

import 'package:get_it/get_it.dart';

import '../core/data/local/hive_helper.dart';
import '../domain/repository.dart';
import '../domain/repository_impl.dart';

final di = GetIt.instance;

void setUp() {
  di.registerSingleton<HiveHelper>(HiveHelper());
  di.registerSingleton<Repository>(RepositoryImpl());
}