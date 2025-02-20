import 'dart:isolate';

import 'package:bug/isolate_handler.dart';
import 'package:equatable/equatable.dart';

class IOSFreezeState extends Equatable {
  final List<IsolateHandler> isolateHandlers;
  const IOSFreezeState({this.isolateHandlers = const []});
  @override
  List<Object?> get props => [isolateHandlers];
}