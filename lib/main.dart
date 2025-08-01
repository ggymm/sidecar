import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:sidecar/app.dart';
import 'package:sidecar/icon.dart';
import 'package:sidecar/page/app.dart';
import 'package:sidecar/page/setting.dart';
import 'package:sidecar/route/convert.dart';
import 'package:sidecar/route/develop.dart';
import 'package:sidecar/route/network.dart';
import 'package:sidecar/route/snippet.dart';
import 'package:window_manager/window_manager.dart';

const double appBarHeight = 48.0;

void main() async {
  App.init();
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();
  windowManager.waitUntilReadyToShow(
    WindowOptions(
      size: Size(1280, 800),
      minimumSize: Size(1280, 800),
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
      backgroundColor: Colors.transparent,
      windowButtonVisibility: false,
    ),
    () async {
      await windowManager.show();
      await windowManager.focus();
    },
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp.router(
      theme: FluentThemeData(
        brightness: Brightness.light,
        fontFamily: '更纱黑体 SC',
      ),
      darkTheme: FluentThemeData(
        brightness: Brightness.dark,
        fontFamily: '更纱黑体 SC',
      ),
      themeMode: ThemeMode.dark,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.child, required this.shellContext});

  final Widget child;
  final BuildContext? shellContext;

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  final searchFocusNode = FocusNode();
  final searchController = TextEditingController();

  late final List<PaneItem> items = [
    ...buildFlattened(menuItems),
    ...buildFlattened(footerItems),
  ];
  late final List<NavigationPaneItem> menuItems =
      [
        PaneItemSeparator(),
        PaneItem(
          key: const ValueKey('/app'),
          icon: homeIcon,
          body: const SizedBox.shrink(),
          title: const Text('首页'),
        ),
        PaneItemHeader(header: SizedBox(height: 28, child: const Text('转换工具'))),
        PaneItem(
          key: const ValueKey('/convert/base64'),
          icon: base64Icon,
          body: const SizedBox.shrink(),
          title: const Text('Base64'),
        ),
        PaneItem(
          key: const ValueKey('/convert/timestamp'),
          icon: timestampIcon,
          body: const SizedBox.shrink(),
          title: const Text('时间戳转换'),
        ),
        PaneItemHeader(header: SizedBox(height: 28, child: const Text('开发工具'))),
        PaneItem(
          key: const ValueKey('/develop/cert'),
          icon: certIcon,
          body: const SizedBox.shrink(),
          title: const Text('证书解析'),
        ),
        PaneItem(
          key: const ValueKey('/develop/hash'),
          icon: hashIcon,
          body: const SizedBox.shrink(),
          title: const Text('哈希散列'),
        ),
        PaneItem(
          key: const ValueKey('/develop/crypto'),
          icon: cryptoIcon,
          body: const SizedBox.shrink(),
          title: const Text('加解密工具'),
        ),
        PaneItem(
          key: const ValueKey('/develop/random'),
          icon: randomIcon,
          body: const SizedBox.shrink(),
          title: const Text('随机数据'),
        ),
        PaneItem(
          key: const ValueKey('/develop/qrcode'),
          icon: qrcodeIcon,
          body: const SizedBox.shrink(),
          title: const Text('二维码'),
        ),
        PaneItemHeader(header: SizedBox(height: 28, child: const Text('网络工具'))),
        PaneItem(
          key: const ValueKey('/network/dns'),
          icon: domainIcon,
          body: const SizedBox.shrink(),
          title: const Text('域名查询'),
        ),
        PaneItem(
          key: const ValueKey('/snippet/manual'),
          icon: manualIcon,
          body: const SizedBox.shrink(),
          title: const Text('端口占用查询'),
        ),
        PaneItemHeader(header: SizedBox(height: 28, child: const Text('代码片段'))),
        PaneItem(
          key: const ValueKey('/snippet/code'),
          icon: codeIcon,
          body: const SizedBox.shrink(),
          title: const Text('代码库'),
        ),
        PaneItem(
          key: const ValueKey('/snippet/manual'),
          icon: manualIcon,
          body: const SizedBox.shrink(),
          title: const Text('命令手册'),
        ),
      ].map<NavigationPaneItem>((e) {
        PaneItem buildItem(PaneItem item) {
          return PaneItem(
            key: item.key,
            icon: item.icon,
            body: item.body,
            title: item.title,
            onTap: () {
              final path = (item.key as ValueKey).value;
              if (GoRouterState.of(context).uri.toString() != path) {
                context.go(path);
              }
              // item.onTap?.call();
            },
          );
        }

        if (e is PaneItemExpander) {
          final List<NavigationPaneItem> items = [];
          for (var item in e.items) {
            if (item is PaneItem) {
              items.add(buildItem(item));
            } else {
              items.add(item);
            }
          }
          return PaneItemExpander(
            key: e.key,
            icon: e.icon,
            body: e.body,
            title: e.title,
            items: items,
            onTap: () {
              final path = (e.key as ValueKey).value;
              if (GoRouterState.of(context).uri.toString() != path) {
                context.go(path);
              }
              // e.onTap?.call();
            },
            // initiallyExpanded: true,
          );
        }
        if (e is PaneItem) {
          return buildItem(e);
        }
        return e;
      }).toList();
  late final List<NavigationPaneItem> footerItems = [
    PaneItem(
      key: const ValueKey('/setting'),
      icon: const Icon(FluentIcons.settings),
      body: const SizedBox.shrink(),
      title: const Text('设置'),
      onTap: () {
        context.go('/setting');
      },
    ),
  ];

  late final List<AutoSuggestBoxItem> searchItems =
      items.map((item) {
        final text = (item.title as Text).data!;
        return AutoSuggestBoxItem(
          label: text,
          value: text,
          onSelected: () {
            item.onTap?.call();
            searchController.clear();
            searchFocusNode.unfocus();
            final view = NavigationView.of(context);
            if (view.compactOverlayOpen) {
              view.compactOverlayOpen = false;
            } else if (view.minimalPaneOpen) {
              view.minimalPaneOpen = false;
            }
          },
        );
      }).toList();

  @override
  void dispose() {
    searchFocusNode.dispose();
    searchController.dispose();
    super.dispose();
  }

  int calcSelected(BuildContext context) {
    for (var i = 0; i < items.length; i++) {
      final item = items[i];
      if (item.key == null) {
        continue;
      }
      if (item.key == Key(GoRouterState.of(context).uri.toString())) {
        return i;
      }
    }
    return 0;
  }

  List<PaneItem> buildFlattened(List<NavigationPaneItem> items) {
    var itemList = <PaneItem>[];
    for (var item in items) {
      if (item.key == null) {
        continue;
      }
      if (item is! PaneItem) {
        continue;
      }

      // 添加到列表中
      itemList.add(item);
      if (item is PaneItemExpander) {
        itemList.addAll(
          item.items.where((sub) => sub.key != null).whereType<PaneItem>(),
        );
      }
    }
    return itemList;
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        height: appBarHeight,
        title: const DragToMoveArea(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text('Sidecar App'),
          ),
        ),
        actions: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [const MainWindowCaption()],
        ),
        automaticallyImplyLeading: false,
      ),
      pane: NavigationPane(
        size: const NavigationPaneSize(
          topHeight: 40,
          headerHeight: 40,
          openWidth: 220,
          openMinWidth: 220,
          openMaxWidth: 220,
        ),
        displayMode: PaneDisplayMode.open,
        autoSuggestBox: Builder(
          builder: (context) {
            return AutoSuggestBox(
              items: searchItems,
              focusNode: searchFocusNode,
              controller: searchController,
              unfocusedColor: Colors.transparent,
              placeholder: 'Search',
            );
          },
        ),
        autoSuggestBoxReplacement: const Icon(FluentIcons.search),
        items: menuItems,
        footerItems: footerItems,
        selected: calcSelected(context),
      ),
      paneBodyBuilder: (item, child) {
        return widget.child;
      },
    );
  }
}

class MainWindowCaption extends StatelessWidget {
  const MainWindowCaption({super.key});

  @override
  Widget build(BuildContext context) {
    final FluentThemeData theme = FluentTheme.of(context);

    return SizedBox(
      width: 138,
      height: appBarHeight,
      child: WindowCaption(
        brightness: theme.brightness,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

final router = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainPage(
          shellContext: shellNavigatorKey.currentContext,
          child: child,
        );
      },
      routes: <GoRoute>[
        GoRoute(path: '/', redirect: (context, state) => '/app'),
        GoRoute(path: '/app', builder: (context, state) => AppPage()),
        GoRoute(path: '/setting', builder: (context, state) => SettingPage()),

        // 转换工具
        GoRoute(
          path: '/convert/main',
          builder: (context, state) => ConvertPage(),
        ),
        GoRoute(
          path: '/convert/base64',
          builder: (context, state) => Base64ConvertPage(),
        ),
        GoRoute(
          path: '/convert/timestamp',
          builder: (context, state) => TimestampConvertPage(),
        ),

        // 开发工具
        GoRoute(
          path: '/develop/main',
          builder: (context, state) => DevelopPage(),
        ),
        GoRoute(
          path: '/develop/cert',
          builder: (context, state) => CertDevelopPage(),
        ),
        GoRoute(
          path: '/develop/crypto',
          builder: (context, state) => CryptoDevelopPage(),
        ),
        GoRoute(
          path: '/develop/hash',
          builder: (context, state) => HashDevelopPage(),
        ),
        GoRoute(
          path: '/develop/qrcode',
          builder: (context, state) => QrcodeDevelopPage(),
        ),
        GoRoute(
          path: '/develop/random',
          builder: (context, state) => RandomDevelopPage(),
        ),

        // 网络工具
        GoRoute(
          path: '/network/main',
          builder: (context, state) => NetworkPage(),
        ),
        GoRoute(
          path: '/network/dns',
          builder: (context, state) => DnsNetworkPage(),
        ),
        GoRoute(
          path: '/network/manual',
          builder: (context, state) => ManualSnippetPage(),
        ),

        // 代码片段
        GoRoute(
          path: '/snippet/main',
          builder: (context, state) => SnippetPage(),
        ),
        GoRoute(
          path: '/snippet/code',
          builder: (context, state) => CodeSnippetPage(),
        ),
        GoRoute(
          path: '/snippet/manual',
          builder: (context, state) => ManualSnippetPage(),
        ),
      ],
    ),
  ],
);
final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();
