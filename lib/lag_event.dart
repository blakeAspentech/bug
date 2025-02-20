

import 'package:bug/isolate_handler.dart';
import 'package:equatable/equatable.dart';

class LagEvent extends Equatable {
  const LagEvent({this.isolates});
  final List<IsolateHandler>? isolates;
  @override
  List<Object?> get props => [isolates];
}