
import 'package:bug/isolate_handler.dart';
import 'package:equatable/equatable.dart';

class LagState extends Equatable {
  final List<IsolateHandler> isolateHandlers;
  const LagState({this.isolateHandlers = const []});
  @override
  List<Object?> get props => [isolateHandlers];
}