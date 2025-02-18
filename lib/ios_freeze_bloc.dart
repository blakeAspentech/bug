import 'dart:isolate';

import 'package:bug/ios_freeze_event.dart';
import 'package:bug/ios_freeze_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IOSFreezeBloc extends Bloc<IOSFreezeEvent, IOSFreezeState> {
  IOSFreezeBloc() : super(const IOSFreezeState()) {
    on<IOSFreezeEvent>(_addIsolate);
  }
  void _addIsolate(
      final IOSFreezeEvent event, final Emitter<IOSFreezeState> emit) {
    List<Isolate> list = List.from(state.isolateList);
    if (event.isolate != null) {
      list.add(event.isolate!);
    }

    emit(IOSFreezeState(counter: state.counter + 1, isolateList: list));
  }
}