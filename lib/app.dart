import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

class App {
  static var ext = "";

  static Future<void> init() async {
    var os = "";
    var arch = "";
    if (Platform.isWindows) {
      os = "win";
      var archEnv = Platform.environment['PROCESSOR_ARCHITECTURE'];
      if (archEnv != null) {
        arch = archEnv.toLowerCase();
      }
    } else if (Platform.isMacOS) {
      os = "mac";
      var archEnv = Platform.environment["HOSTTYPE"];
      if (archEnv != null) {
        if (archEnv == "x86_64") {
          arch = "amd64";
        } else if (archEnv == "arm64") {
          arch = "arm64";
        }
      }
    }
    ext = "-$os-$arch";
  }

  static Future<String> getDir() async {
    if (kDebugMode) {
      return Directory.current.path;
    } else {
      final String executablePath = Platform.resolvedExecutable;
      final File executableFile = File(executablePath);
      return executableFile.parent.path;
    }
  }

  static Future<String> getHashBin() async {
    return join(await getDir(), "app", "plugin", "hash", "hash$ext");
  }

  static Future<String> getQrcodeBin() async {
    return join(await getDir(), "app", "plugin", "qrcode", "qrcode$ext");
  }

  static Future<String> getManualRoot() async {
    return join(await getDir(), "app", "snippet", "manual");
  }

  static Future<String> getManualIndex() async {
    return join(await getDir(), "app", "snippet", "manual", "index.json");
  }
}
