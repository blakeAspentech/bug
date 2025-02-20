
import 'dart:isolate';

import 'package:bug/isolate_handler.dart';
import 'package:equatable/equatable.dart';

class IOSFreezeEvent extends Equatable {
  const IOSFreezeEvent({this.isolates});
  final List<IsolateHandler>? isolates;
  @override
  List<Object?> get props => [isolates];
}