import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';

const size = 20.0;

final Widget homeIcon = SvgPicture.asset(
  'assets/icons/home.svg',
  width: size,
  height: size,
  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
  semanticsLabel: 'Home Icon',
);

final Widget appsIcon = SvgPicture.asset(
  'assets/icons/apps.svg',
  width: size,
  height: size,
  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
  semanticsLabel: 'Apps Icon',
);

/// ========== 转换工具 ==========
final Widget base64Icon = SvgPicture.asset(
  'assets/icons/base64.svg',
  width: size,
  height: size,
  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
  semanticsLabel: 'Base64 Icon',
);

final Widget timestampIcon = SvgPicture.asset(
  'assets/icons/timestamp.svg',
  width: size,
  height: size,
  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
  semanticsLabel: 'Timestamp Icon',
);

/// ========== 开发工具 ==========
final Widget certIcon = SvgPicture.asset(
  'assets/icons/cert.svg',
  width: size,
  height: size,
  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
  semanticsLabel: 'Cert Icon',
);

final Widget hashIcon = SvgPicture.asset(
  'assets/icons/hash.svg',
  width: size,
  height: size,
  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
  semanticsLabel: 'Hash Icon',
);

final Widget encryptIcon = SvgPicture.asset(
  'assets/icons/encrypt.svg',
  width: size,
  height: size,
  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
  semanticsLabel: 'Encrypt Icon',
);

/// ========== 代码片段 ==========
final Widget javaIcon = SvgPicture.asset(
  'assets/icons/java.svg',
  width: size,
  height: size,
  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
  semanticsLabel: 'Java Icon',
);
