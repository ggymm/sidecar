# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Sidecar is a Flutter desktop application providing various utility tools. It's a cross-platform desktop app with support for Windows, macOS, and Linux.

## Development Environment Setup

### Flutter Environment (Chinese Mirror)
```bash
# Add to ~/.zprofile
export PUB_HOSTED_URL="https://pub.flutter-io.cn"
export FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"
```

## Common Commands

### Development
```bash
flutter run                    # Run in development mode
flutter pub get                # Install dependencies
flutter analyze                # Run static analysis
flutter test                   # Run tests
```

### Building
```bash
flutter build windows --release    # Build Windows release
flutter build macos --release      # Build macOS release
flutter build linux --release      # Build Linux release
```

### Icon Generation (macOS)
```bash
# Install librsvg first
brew install librsvg

# Generate icons from SVG
cd macos/Runner/Assets.xcassets/AppIcon.appiconset/
rsvg-convert -w 16 app_icon.svg > app_icon_16.png
rsvg-convert -w 32 app_icon.svg > app_icon_32.png
rsvg-convert -w 64 app_icon.svg > app_icon_64.png
rsvg-convert -w 128 app_icon.svg > app_icon_128.png
rsvg-convert -w 256 app_icon.svg > app_icon_256.png
rsvg-convert -w 512 app_icon.svg > app_icon_512.png
rsvg-convert -w 1024 app_icon.svg > app_icon_1024.png
```

## Project Architecture

### Main Structure
- **lib/main.dart**: Application entry point with window configuration and routing setup
- **lib/app.dart**: Core app utilities including platform detection and binary path management
- **lib/page/**: UI pages organized by feature categories
- **lib/route/**: Route definitions for different tool categories
- **app/plugin/**: Native executables for DNS, hash, and QR code operations
- **app/snippet/**: Code snippets and command manuals

### Navigation Structure
The app uses a NavigationPane with the following categories:
- **便捷工具 (Utilities)**: File sharing tools
- **转换工具 (Convert)**: Base64 encoding, timestamp conversion
- **开发工具 (Develop)**: Certificate parsing, hashing, crypto, random data, QR codes
- **网络工具 (Network)**: DNS lookup, port checking
- **代码片段 (Snippets)**: Code library and command manuals

### Key Dependencies
- `fluent_ui`: Microsoft Fluent UI components
- `go_router`: Navigation and routing
- `window_manager`: Desktop window management
- Native binaries for specialized operations (DNS, hashing, QR codes)

### Binary Management
The `App` class handles platform-specific binary discovery:
- Detects OS and architecture at runtime
- Constructs paths to native executables in `app/plugin/`
- Supports development and production environments

### Routing Pattern
Uses GoRouter with a shell route structure:
- Main shell provides navigation sidebar
- Individual routes for each tool page
- Automatic redirect from root to `/app`