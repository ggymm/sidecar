import 'dart:io';

class Utils {
  static Future<String> getLocalIp() async {
    var ipv4 = '';
    var wlan = '';
    for (var interface in await NetworkInterface.list()) {
      for (var addr in interface.addresses) {
        if (addr.type == InternetAddressType.IPv4 && !addr.isLoopback) {
          ipv4 = addr.address;

          if (interface.name.toLowerCase().contains('en0') ||
              interface.name.toLowerCase().contains('wifi') ||
              interface.name.toLowerCase().contains('wlan')) {
            wlan = addr.address;
          }
        }
      }
      if (wlan.isNotEmpty) {
        return wlan;
      }
      if (ipv4.isNotEmpty) {
        return ipv4;
      }
    }
    return '127.0.0.1';
  }
}
