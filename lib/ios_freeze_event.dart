
import 'dart:isolate';

import 'package:equatable/equatable.dart';

class IOSFreezeEvent extends Equatable {
  const IOSFreezeEvent({this.isolate});
  final Isolate? isolate;
  @override
  List<Object?> get props => [isolate];
}