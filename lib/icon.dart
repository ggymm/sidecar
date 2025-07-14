import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';

const size = 20.0;

final Widget homeIcon = SvgPicture.asset(
  'asset/icon/home.svg',
  width: 18.0,
  height: 18.0,
  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
  semanticsLabel: 'Home Icon',
);

final Widget appsIcon = SvgPicture.asset(
  'asset/icon/apps.svg',
  width: size,
  height: size,
  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
  semanticsLabel: 'Apps Icon',
);

/// ========== 转换工具 ==========
final Widget base64Icon = SvgPicture.asset(
  'asset/icon/base64.svg',
  width: size,
  height: size,
  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
  semanticsLabel: 'Base64 Icon',
);

final Widget timestampIcon = SvgPicture.asset(
  'asset/icon/timestamp.svg',
  width: size,
  height: size,
  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
  semanticsLabel: 'Timestamp Icon',
);

/// ========== 开发工具 ==========
final Widget certIcon = SvgPicture.asset(
  'asset/icon/cert.svg',
  width: size,
  height: size,
  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
  semanticsLabel: 'Cert Icon',
);

final Widget hashIcon = SvgPicture.asset(
  'asset/icon/hash.svg',
  width: size,
  height: size,
  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
  semanticsLabel: 'Hash Icon',
);

final Widget cryptoIcon = SvgPicture.asset(
  'asset/icon/crypto.svg',
  width: size,
  height: size,
  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
  semanticsLabel: 'Crypto Icon',
);

final Widget qrcodeIcon = SvgPicture.asset(
  'asset/icon/qrcode.svg',
  width: size,
  height: size,
  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
  semanticsLabel: 'Qrcode Icon',
);

final Widget randomIcon = SvgPicture.asset(
  'asset/icon/random.svg',
  width: size,
  height: size,
  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
  semanticsLabel: 'Random Icon',
);

/// ========== 代码片段 ==========
final Widget codeIcon = SvgPicture.asset(
  'asset/icon/code.svg',
  width: size,
  height: size,
  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
  semanticsLabel: 'Code Icon',
);

final Widget manualIcon = SvgPicture.asset(
  'asset/icon/manual.svg',
  width: size,
  height: size,
  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
  semanticsLabel: 'Manual Icon',
);
