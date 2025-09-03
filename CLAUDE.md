# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目概述

Sidecar 是一个 Flutter 桌面应用，为开发者提供各类实用工具。支持 Windows、macOS 和 Linux 三大平台。

## 常用命令

### 开发调试
```bash
flutter run                    # 运行开发模式
flutter pub get                # 安装依赖
flutter analyze                # 静态代码分析
flutter test                   # 运行测试（当前无测试文件）
```

### 构建发布
```bash
flutter clean                                              # 清理构建产物
flutter build macos --release --no-tree-shake-icons       # 构建 macOS 版本
flutter build windows --release                           # 构建 Windows 版本
flutter build linux --release                             # 构建 Linux 版本
```

## 核心架构

### 主要组件
- **lib/main.dart**: 应用入口，窗口配置和路由设置
- **lib/app.dart**: 平台检测和原生二进制文件路径管理
- **lib/page/**: 各功能页面，按类别组织
- **lib/route/**: 路由定义文件，按功能分类
- **app/plugin/**: 原生可执行文件（DNS、哈希、二维码、文件分享）

### 原生插件系统
应用通过 `App` 类管理平台特定的原生二进制文件：
- 运行时检测操作系统和架构
- 动态构建 `app/plugin/` 下可执行文件路径
- 支持开发和生产环境的路径解析

### UI 框架
- 使用 Microsoft Fluent UI 组件库
- 默认暗色主题
- 自定义字体：更纱黑体 SC
- 使用 GoRouter 进行导航管理，Shell 路由结构提供侧边栏