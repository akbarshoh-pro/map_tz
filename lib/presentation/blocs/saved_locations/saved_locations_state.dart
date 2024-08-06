


import '../../../core/data/local/entity/point_entity.dart';
import '../../../utils/screen_state.dart';

class SavedLocationsState {
  ScreenState screenState;
  List<PointEntity>? points;
  bool? isEmpty;

  SavedLocationsState({
    required this.screenState,
    this.points,
    this.isEmpty
  });

  SavedLocationsState copyWith({
    ScreenState? screenState,
    List<PointEntity>? points,
    bool? isEmpty
  }) => SavedLocationsState(
    screenState: screenState ?? this.screenState,
      points: points ?? this.points,
    isEmpty: isEmpty ?? this.isEmpty
  );
}

