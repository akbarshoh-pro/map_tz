
import 'package:hive/hive.dart';

part 'point_entity.g.dart';

@HiveType(typeId: 1)
class PointEntity extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  double latitude;
  @HiveField(2)
  double longitude;

  PointEntity({
    required this.name,
    required this.latitude,
    required this.longitude
  });
}