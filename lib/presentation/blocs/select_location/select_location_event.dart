

import '../../../core/data/local/entity/point_entity.dart';

abstract class SelectLocationEvent {}

class SavePoint extends SelectLocationEvent {
  PointEntity point;

  SavePoint({required this.point});
}
class GetLocation extends SelectLocationEvent{
  final String placeName;
  GetLocation({required this.placeName});
}
