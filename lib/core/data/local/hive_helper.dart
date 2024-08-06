
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'entity/point_entity.dart';

class HiveHelper {
  static late final Box<PointEntity> boxPoints;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.registerAdapter(PointEntityAdapter());
    boxPoints = await Hive.openBox<PointEntity>('points');
  }

  void addPoint(PointEntity point) {
    boxPoints.put(point.hashCode, point);
  }

  List<PointEntity> getAllPoints() => boxPoints.values.toList();

}