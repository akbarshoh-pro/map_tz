import 'package:flutter/material.dart';

import 'app/my_app.dart';
import 'core/data/local/hive_helper.dart';
import 'di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUp();
  await HiveHelper.init();
  runApp(const MyApp());
}
