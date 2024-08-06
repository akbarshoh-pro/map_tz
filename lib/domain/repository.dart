

import '../core/data/local/entity/point_entity.dart';

abstract class Repository {
  void addPoint(PointEntity point);

  List<PointEntity> getAllPoints();
}