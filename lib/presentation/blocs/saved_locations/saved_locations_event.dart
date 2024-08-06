

import '../../../core/data/local/entity/point_entity.dart';

abstract class SavedLocationsEvent {}

class GetAllPoints extends SavedLocationsEvent {}

class DeletePoint extends SavedLocationsEvent {
  final int index;
  final PointEntity point;
  DeletePoint({
    required this.index,
    required this.point
  });
}
