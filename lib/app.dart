import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

class App {
  static var ext = '';

  static Future<void> init() async {
    var os = '';
    var arch = '';
    if (Platform.isWindows) {
      os = 'win';
      var output = Platform.environment['PROCESSOR_ARCHITECTURE'];
      if (output != null) {
        arch = output.toLowerCase();
      }
    } else if (Platform.isMacOS) {
      os = 'mac';
      var result = Process.runSync('uname', ['-m']);
      var output = result.stdout.toString().trim();
      if (output == 'x86_64') {
        arch = 'amd64';
      } else if (output == 'arm64') {
        arch = 'arm64';
      }
    }
    ext = '-$os-$arch';
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

  /// 获取插件目录

  // 获取 dns 插件路径
  static Future<String> getDnsBin() async {
    return join(await getDir(), 'app', 'plugin', 'dns', 'dns$ext');
  }

  // 获取 hash 插件路径
  static Future<String> getHashBin() async {
    return join(await getDir(), 'app', 'plugin', 'hash', 'hash$ext');
  }

  // 获取 qrcode 插件路径
  static Future<String> getQrcodeBin() async {
    return join(await getDir(), 'app', 'plugin', 'qrcode', 'qrcode$ext');
  }

  // 获取 share 插件路径
  static Future<String> getShareBin() async {
    return join(await getDir(), 'app', 'plugin', 'share', 'share$ext');
  }

  /// 获取代码片段目录

  // 获取 manual 目录
  static Future<String> getManualRoot() async {
    return join(await getDir(), 'app', 'snippet', 'manual');
  }

  static Future<String> getManualIndex() async {
    return join(await getDir(), 'app', 'snippet', 'manual', 'index.json');
  }
}
