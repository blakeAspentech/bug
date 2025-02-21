
import 'package:bug/lag_bloc.dart';
import 'package:bug/lag_event.dart';
import 'package:bug/lag_state.dart';
import 'package:bug/isolate_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(final BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LagBloc>(
          create: (final context) => LagBloc(),
        )
      ],
      child: MaterialApp(home: Lag(key: key)),
    );
  }
}




class Lag extends StatelessWidget {

  final int isolatesPerClick = 1;
  const Lag({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LagBloc, LagState>(
        builder: (final context, final state) {
      return Scaffold(
          appBar: AppBar(title: const Text('Flutter Freeze')),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 1,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("UI freeze indicator"),
                    Padding(padding: EdgeInsets.all(5),
                      child:CircularProgressIndicator(
                      backgroundColor: Colors.blue,
                      color: Colors.white,
                    ))
                  ]),
              FloatingActionButton.extended(
                onPressed: () async {
                  WidgetsFlutterBinding.ensureInitialized();
                  List<IsolateHandler> newIsolates = [];
                  for (int i in Iterable.generate(isolatesPerClick))
                  {
                    NewIsolateInfo info = NewIsolateInfo(
                      "isolate${state.isolateHandlers.length + i}",
                      ServicesBinding.rootIsolateToken!);
                      //await Future.delayed(Duration(milliseconds: 10)); // offset the isolates
                      print("Isolate dispatch $i");
                       newIsolates.add(IsolateHandler(info));
                  
                  }
                  if (context.mounted) {
                    BlocProvider.of<LagBloc>(context)
                        .add(LagEvent(isolates: newIsolates));
                  } else {
                    print(
                        "Context not mounted while creating isolates");
                  }
                  
                },
                icon: const Icon(Icons.add),
                label: const Text('Lag Button'),
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: state.isolateHandlers.length,
                itemBuilder: (BuildContext context, int index) {
                  IsolateHandler handler = state.isolateHandlers[index];
                  print("building list item $index");
                  return ListTile(
                      title: Text(
                          handler.name));
                },
              )),
            ],
          ));
    });
  }
}
