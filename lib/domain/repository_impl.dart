

import 'package:map_tz/domain/repository.dart';

import '../core/data/local/entity/point_entity.dart';
import '../core/data/local/hive_helper.dart';
import '../di/di.dart';

class RepositoryImpl extends Repository {
  final HiveHelper hiveHelper = di<HiveHelper>();

  @override
  void addPoint(PointEntity point) =>
    hiveHelper.addPoint(point);

  @override
  List<PointEntity> getAllPoints() =>
      hiveHelper.getAllPoints();

}