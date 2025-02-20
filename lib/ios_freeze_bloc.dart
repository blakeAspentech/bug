import 'dart:isolate';

import 'package:bug/ios_freeze_event.dart';
import 'package:bug/ios_freeze_state.dart';
import 'package:bug/isolate_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IOSFreezeBloc extends Bloc<IOSFreezeEvent, IOSFreezeState> {
  IOSFreezeBloc() : super(const IOSFreezeState()) {
    on<IOSFreezeEvent>(_addIsolate);
  }
  void _addIsolate(
      final IOSFreezeEvent event, final Emitter<IOSFreezeState> emit) {
    List<IsolateHandler> list = List.from(state.isolateHandlers);
    if (event.isolates != null) {
      list.addAll(event.isolates!);
    }

    emit(IOSFreezeState(isolateHandlers: list));
  }
}