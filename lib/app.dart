import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

class App {
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
    return join(await getDir(), "app", "plugins", "hash", "hash");
  }

  static Future<String> getQrcodeBin() async {
    return join(await getDir(), "app", "plugins", "qrcode", "qrcode");
  }

  static Future<String> getManualRoot() async {
    return join(await getDir(), "app", "snippets", "manual");
  }

  static Future<String> getManualIndex() async {
    return join(await getDir(), "app", "snippets", "manual", "index.json");
  }
}
