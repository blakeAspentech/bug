import 'dart:async';
import 'dart:isolate';

import 'package:bug/temp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:equatable/equatable.dart";

void main()
{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(final BuildContext context) {
    return MultiBlocProvider(providers: [BlocProvider<IOSFreezeBloc>(create: (final context)=> IOSFreezeBloc(),)],
      child: MaterialApp(home: IOSFreeze(key: key)),);
  }
}

class IOSFreezeBloc extends Bloc<IOSFreezeEvent, IOSFreezeState>{
  IOSFreezeBloc() : super(const IOSFreezeState()){
    on<IOSFreezeEvent>(_addIsolate);
  }
  void _addIsolate(final IOSFreezeEvent event, final Emitter<IOSFreezeState> emit)
  {
    List<Isolate> list = List.from(state.isolateList);
    if (event.isolate != null)
    {
      list.add(event.isolate!);
    }
    
    emit(IOSFreezeState(counter: state.counter+1,isolateList: list ));
  }
}

class IOSFreezeState extends Equatable{
  final int counter;
  final List<Isolate> isolateList;
  const IOSFreezeState({this.counter = 0, this.isolateList = const []});
  @override
  List<Object?> get props => [counter, isolateList];
}

class IOSFreezeEvent extends Equatable {
  const IOSFreezeEvent({this.isolate});
  final Isolate? isolate;
  @override
  List<Object?> get props => [isolate];
}

class IOSFreeze extends StatelessWidget {
  
  IOSFreeze({super.key});

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();


  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<IOSFreezeBloc, IOSFreezeState>(
        builder: (final context, final state) {
          return Scaffold(
      appBar: AppBar(title: const Text('iOS Freeze 18.3.1')),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        color: Colors.white,
        backgroundColor: Colors.blue,
        strokeWidth: 4.0,
        onRefresh: () async {
          // Replace this delay with the code to be executed during refresh
          // and return a Future when code finishes execution.
          unawaited(Future<void>.delayed(const Duration(seconds: 30)));
          return Future<void>.delayed(const Duration(seconds: 1));
        },
        // Pull from top to show refresh indicator.
        child: ListView.builder(
          itemCount: state.isolateList.length,
          itemBuilder: (BuildContext context, int index) {
            Isolate isolate = state.isolateList[index];
            print("building list item $index");
            return ListTile(title: Text("${isolate.debugName} : ${isolate.pauseCapability != null} : ${isolate.terminateCapability != null}"));
          },
        )
        
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // Show refresh indicator programmatically on button tap.
          WidgetsFlutterBinding.ensureInitialized();
          String path = await rootBundle.loadString("assets/bee_movie_script.txt");
          NewIsolateInfo info = NewIsolateInfo("isolate${state.counter}",path, ServicesBinding.rootIsolateToken!);
          print("Creating new isolate ${state.counter}");
          Isolate newIsolate = await Isolate.spawn(initIsolate, info,debugName: "isolate${state.counter}" );
          
          BlocProvider.of<IOSFreezeBloc>(context).add(IOSFreezeEvent(isolate: newIsolate));
          //print("there are now ${state.isolateList.length} isolates");
          _refreshIndicatorKey.currentState?.show();
          
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Isolate'),
      ),
    );});
  }
}
