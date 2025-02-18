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

  // loop forever
  while(true) {
    Stopwatch timer = Stopwatch()..start();
    var charRegex = RegExp(r"[^\w\s]");
    var newlineRegex = RegExp(r"(\r\n|\r|\n)");
    String cleanedScript = fullScript.replaceAll(newlineRegex, " ").replaceAll(charRegex, "");

    List<String> splitScript = cleanedScript.toLowerCase().split(" ").where((final word) => word.isNotEmpty).toList();

    splitScript.sort((final a, final b) => a.compareTo(b));

    //File(sortedScriptLocation).writeAsStringSync(splitScript.join(" "), mode: FileMode.write);

    Map<String, int> wordCount = {};
    for (final word in splitScript) {
      int i = wordCount[word] ?? 0;
      wordCount[word] = i + 1;
    }

    timer.stop();
  }
}