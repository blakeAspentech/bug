import 'dart:isolate';

import 'package:bug/ios_freeze_bloc.dart';
import 'package:bug/ios_freeze_event.dart';
import 'package:bug/ios_freeze_state.dart';
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
        BlocProvider<IOSFreezeBloc>(
          create: (final context) => IOSFreezeBloc(),
        )
      ],
      child: MaterialApp(home: IOSFreeze(key: key)),
    );
  }
}




class IOSFreeze extends StatelessWidget {
  const IOSFreeze({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IOSFreezeBloc, IOSFreezeState>(
        builder: (final context, final state) {
      return Scaffold(
          appBar: AppBar(title: const Text('iOS Freeze 18.3.1')),
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
                  String path = await rootBundle
                      .loadString("assets/bee_movie_script.txt");
                  List<IsolateHandler> newIsolates = [];
                  for (int i in Iterable.generate(8))
                  {
                    NewIsolateInfo info = NewIsolateInfo(
                      "isolate${state.isolateHandlers.length + i}",
                      path,
                      ServicesBinding.rootIsolateToken!);
                       newIsolates.add(IsolateHandler(info));
                  
                  }
                  if (context.mounted) {
                    BlocProvider.of<IOSFreezeBloc>(context)
                        .add(IOSFreezeEvent(isolates: newIsolates));
                  } else {
                    print(
                        "Context not mounted while creating isolates");
                  }
                  
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Isolate'),
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: state.isolateHandlers.length,
                itemBuilder: (BuildContext context, int index) {
                  IsolateHandler handler = state.isolateHandlers[index];
                  print("building list item $index");
                  return ListTile(
                      title: Text(
                          "${handler.name} "));
                },
              )),
            ],
          ));
    });
  }
}
