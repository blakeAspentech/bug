// ignore_for_file: unused_local_variable, unused_field

import "dart:async";
import "dart:isolate";

import "package:flutter/services.dart";

class NewIsolateInfo {
  String name;
  String path;
  RootIsolateToken token;
  NewIsolateInfo(this.name, this.path, this.token);
}

Duration syncInterval = Duration(seconds: 7);

class IsolateHandler {

  late Isolate isolate;
  late Timer? _timer;
  String name = "";

  IsolateHandler(NewIsolateInfo info)
  {
    name = info.name;
     createIsolate(info);
     

  }

  void initIsolate(final NewIsolateInfo info)
  {
    BackgroundIsolateBinaryMessenger.ensureInitialized(info.token);
    _timer = makePeriodicTimer(syncInterval, busyBee, fireNow: true);
  }

  void createIsolate(NewIsolateInfo info) async {
    isolate = await Isolate.spawn(initIsolate, info,
                      debugName: "isolate${info.name}");
    
  }

  Timer? makePeriodicTimer(final Duration duration, final Function(Timer) callBack, {final bool fireNow = false}){
    return runZonedGuarded(() {
      Timer timer = Timer.periodic(syncInterval, callBack);
      if(fireNow){
        callBack(timer);
      }
      return timer;
    }, (final e, final st) => print("Uncaught error in ${isolate.debugName} isolate, $e : $st"));
  }

  void busyBee(final Timer timer) async {

    Stopwatch timer = Stopwatch()..start();
    // loop for a bit
    while(timer.elapsed < Duration(seconds: 5)) {
      var math = 8^7;
      }
    timer.stop();
  }
}