import 'dart:isolate';

import 'package:equatable/equatable.dart';

class IOSFreezeState extends Equatable {
  final int counter;
  final List<Isolate> isolateList;
  const IOSFreezeState({this.counter = 0, this.isolateList = const []});
  @override
  List<Object?> get props => [counter, isolateList];
}