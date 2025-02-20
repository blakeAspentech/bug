// ignore_for_file: unused_local_variable, unused_field

import "dart:async";
import "dart:isolate";

import "package:flutter/services.dart";

class NewIsolateInfo {
  String name;
  RootIsolateToken token;
  NewIsolateInfo(this.name, this.token);
}

Duration syncInterval = Duration(seconds: 5);
Duration busyInterval = Duration(milliseconds: 4950);

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
        print("$name firing");
        callBack(timer);
      }
      return timer;
    }, (final e, final st) => print("Uncaught error in ${isolate.debugName}, $e : $st"));
  }

  void busyBee(final Timer timer) async {

    Stopwatch timer = Stopwatch()..start();
    // loop for a bit
    while(timer.elapsed < busyInterval) {
      var math = 8^7; // makes your device a heater
      }
    timer.stop();
  }
}