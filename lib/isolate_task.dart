import "dart:async";

import "package:flutter/services.dart";

void initIsolate(NewIsolateInfo info) {
  unawaited(busyBee(info));
}

class NewIsolateInfo {
  String name;
  String path;
  RootIsolateToken token;
  NewIsolateInfo(this.name, this.path, this.token);
}


Future<void> busyBee(final NewIsolateInfo info) async {
  BackgroundIsolateBinaryMessenger.ensureInitialized(info.token);
 
  String name = info.name;
  print("[$name] Spawned $name isolate");
  

  String fullScript = info.path;
  print("[$name] File loaded");

  while (true)
  {
    Stopwatch timer = Stopwatch()..start();
  // loop forever ish
  while(timer.elapsed < Duration(seconds: 10)) {
    var math = 8^7;
    }
  print("ding ding ding $name");

  timer.stop();
  var _ = await Future.delayed(Duration(seconds: 1));
  }
}