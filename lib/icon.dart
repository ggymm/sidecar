import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';

const size = 20.0;

final Widget homeIcon = SvgPicture.asset(
  'asset/icons/home.svg',
  width: 18.0,
  height: 18.0,
  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
  semanticsLabel: 'Home Icon',
);

final Widget appsIcon = SvgPicture.asset(
  'asset/icons/apps.svg',
  width: size,
  height: size,
  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
  semanticsLabel: 'Apps Icon',
);

/// ========== 转换工具 ==========
final Widget base64Icon = SvgPicture.asset(
  'asset/icons/base64.svg',
  width: size,
  height: size,
  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
  semanticsLabel: 'Base64 Icon',
);

final Widget timestampIcon = SvgPicture.asset(
  'asset/icons/timestamp.svg',
  width: size,
  height: size,
  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
  semanticsLabel: 'Timestamp Icon',
);

/// ========== 开发工具 ==========
final Widget certIcon = SvgPicture.asset(
  'asset/icons/cert.svg',
  width: size,
  height: size,
  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
  semanticsLabel: 'Cert Icon',
);

final Widget hashIcon = SvgPicture.asset(
  'asset/icons/hash.svg',
  width: size,
  height: size,
  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
  semanticsLabel: 'Hash Icon',
);

final Widget cryptoIcon = SvgPicture.asset(
  'asset/icons/crypto.svg',
  width: size,
  height: size,
  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
  semanticsLabel: 'Crypto Icon',
);

final Widget qrcodeIcon = SvgPicture.asset(
  'asset/icons/qrcode.svg',
  width: size,
  height: size,
  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
  semanticsLabel: 'Qrcode Icon',
);

/// ========== 代码片段 ==========
final Widget javaIcon = SvgPicture.asset(
  'asset/icons/java.svg',
  width: size,
  height: size,
  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
  semanticsLabel: 'Java Icon',
);
