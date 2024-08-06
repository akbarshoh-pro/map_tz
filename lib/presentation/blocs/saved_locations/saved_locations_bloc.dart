
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_tz/presentation/blocs/saved_locations/saved_locations_event.dart';
import 'package:map_tz/presentation/blocs/saved_locations/saved_locations_state.dart';

import '../../../di/di.dart';
import '../../../domain/repository.dart';
import '../../../utils/screen_state.dart';

class SavedLocationsBloc extends Bloc<SavedLocationsEvent, SavedLocationsState> {
  SavedLocationsBloc() : super(SavedLocationsState(screenState: ScreenState.initial)) {
    Repository repo = di<Repository>();
    on<GetAllPoints>((event, emit) {
      var list = repo.getAllPoints();
      print("GetAllPoints -> ${list.length}");
      emit(state.copyWith(screenState: ScreenState.success, points: list, isEmpty: list.isEmpty));
    });

    on<DeletePoint>((event, emit) {
      var point = event.point;
      point.delete();
      var list = repo.getAllPoints();
      emit(state.copyWith(screenState: ScreenState.success, points: list, isEmpty: list.isEmpty));
    });
  }
}
