
import 'package:bug/lag_event.dart';
import 'package:bug/lag_state.dart';
import 'package:bug/isolate_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LagBloc extends Bloc<LagEvent, LagState> {
  LagBloc() : super(const LagState()) {
    on<LagEvent>(_addIsolate);
  }
  void _addIsolate(
      final LagEvent event, final Emitter<LagState> emit) {
    List<IsolateHandler> list = List.from(state.isolateHandlers);
    if (event.isolates != null) {
      list.addAll(event.isolates!);
    }

    emit(LagState(isolateHandlers: list));
  }
}