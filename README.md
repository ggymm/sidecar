## sidecar

### 环境变量

```bash
# 编辑 ～/.zprofile 文件
export PUB_HOSTED_URL="https://pub.flutter-io.cn"
export FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"
```

### 打包命令

```bash
flutter clean
flutter build macos --release --no-tree-shake-icons
flutter build windows --release
```

### 图标路径

#### linux

linux/assets/icons/com.ggymm.sidecar.png

#### macos

macos/Runner/Assets.xcassets/AppIcon.appiconset/

```bash

brew install librsvg

cd macos/Runner/Assets.xcassets/AppIcon.appiconset/
rsvg-convert -w 16 app_icon.svg > app_icon_16.png
rsvg-convert -w 32 app_icon.svg > app_icon_32.png
rsvg-convert -w 64 app_icon.svg > app_icon_64.png
rsvg-convert -w 128 app_icon.svg > app_icon_128.png
rsvg-convert -w 256 app_icon.svg > app_icon_256.png
rsvg-convert -w 512 app_icon.svg > app_icon_512.png
rsvg-convert -w 1024 app_icon.svg > app_icon_1024.png

```

#### windows

windows/runner/resources/app_icon.ico
