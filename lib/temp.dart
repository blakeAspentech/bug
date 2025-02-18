import "dart:async";
import "dart:io";

import "package:path_provider/path_provider.dart";

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
  String sortedScriptLocation = "${Directory.systemTemp}sorted_bee_movie_script_$name.txt";
  
  //print("[$name] File loaded");

  // loop forever
  while(true) {
    Stopwatch timer = Stopwatch()..start();
    //print("[$name] Reading the script to string");
    //String fullScript = scriptFile.readAsStringSync();
    
    //print("[$name] Cleaning punctuation");
    String cleanedScript = fullScript.replaceAll(RegExp("/[^A-Za-z0-9\\s]/i"), " ").toLowerCase();

    //print("[$name] Spliting the script");
    List<String> splitScript = cleanedScript.split(" ").where((final word) => word.isNotEmpty).toList();

    //print("[$name] Sorting the script");
    splitScript.sort((final a, final b) => a.compareTo(b));

    //print("[$name] Script sorted, writing back to file");
    //File(sortedScriptLocation).writeAsStringSync(splitScript.join(" "), mode: FileMode.write);

    //print("[$name] Counting the words");
    Map<String, int> wordCount = {};
    for (final word in splitScript) {
      int i = wordCount[word] ?? 0;
      wordCount[word] = i + 1;
    }

    //print("[$name] Counted the words. There are ${wordCount["bee"] ?? 0} bees in the bee movie");
    timer.stop();
    //print("[$name] Completed work in ${timer.elapsedMilliseconds / 1000.0} seconds. Restarting the process.");

    //break;
  }
}