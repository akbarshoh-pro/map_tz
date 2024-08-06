
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_tz/presentation/blocs/select_location/select_location_event.dart';
import 'package:map_tz/presentation/blocs/select_location/select_location_state.dart';

import '../../../di/di.dart';
import '../../../domain/repository.dart';


class SelectLocationBloc extends Bloc<SelectLocationEvent, SelectLocationState> {
  SelectLocationBloc() : super(SelectLocationState()) {
    Repository repo = di<Repository>();
    on<SavePoint>((event, emit) {
      repo.addPoint(event.point);
    });
  }
}
