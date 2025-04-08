import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:sidecar/page/app.dart';
import 'package:sidecar/page/setting.dart';
import 'package:sidecar/route/convert.dart';
import 'package:sidecar/route/develop.dart';
import 'package:sidecar/route/snippet.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();
  windowManager.waitUntilReadyToShow(
    WindowOptions(
      size: Size(1280, 800),
      // center: true,
      minimumSize: Size(960, 600),
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
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
          icon: const Icon(FluentIcons.home),
          body: const SizedBox.shrink(),
          title: const Text('全部工具', overflow: TextOverflow.ellipsis),
        ),
        PaneItemExpander(
          key: const ValueKey('/convert/main'),
          icon: const Icon(FluentIcons.home),
          body: const SizedBox.shrink(),
          title: const Text('转换工具', overflow: TextOverflow.ellipsis),
          items: [
            PaneItem(
              key: const ValueKey('/convert/base64'),
              icon: const Icon(FluentIcons.home),
              body: const SizedBox.shrink(),
              title: const Text('Base64', overflow: TextOverflow.ellipsis),
            ),
            PaneItem(
              key: const ValueKey('/convert/timestamp'),
              icon: const Icon(FluentIcons.home),
              body: const SizedBox.shrink(),
              title: const Text('时间日期', overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        PaneItemExpander(
          key: const ValueKey('/develop/main'),
          icon: const Icon(FluentIcons.home),
          body: const SizedBox.shrink(),
          title: const Text('开发工具', overflow: TextOverflow.ellipsis),
          items: [
            PaneItem(
              key: const ValueKey('/develop/cert'),
              icon: const Icon(FluentIcons.home),
              body: const SizedBox.shrink(),
              title: const Text('证书', overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        PaneItemExpander(
          key: const ValueKey('/snippet/main'),
          icon: const Icon(FluentIcons.home),
          body: const SizedBox.shrink(),
          title: const Text('代码片段', overflow: TextOverflow.ellipsis),
          items: [
            PaneItem(
              key: const ValueKey('/snippet/java'),
              icon: const Icon(FluentIcons.home),
              body: const SizedBox.shrink(),
              title: const Text('Java', overflow: TextOverflow.ellipsis),
            ),
          ],
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
              item.onTap?.call();
            },
          );
        }

        if (e is PaneItemExpander) {
          return PaneItemExpander(
            key: e.key,
            icon: e.icon,
            body: e.body,
            title: e.title,
            items:
                e.items.map((item) {
                  if (item is PaneItem) {
                    return buildItem(item);
                  }
                  return item;
                }).toList(),
            onTap: () {
              final path = (e.key as ValueKey).value;
              if (GoRouterState.of(context).uri.toString() != path) {
                context.go(path);
              }
              e.onTap?.call();
            },
          );
        }
        if (e is PaneItem) {
          return buildItem(e);
        }
        return e;
      }).toList();
  late final List<NavigationPaneItem> footerItems = [
    PaneItem(
      key: const ValueKey('setting'),
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
    return items.indexWhere(
      (item) => item.key == Key(GoRouterState.of(context).uri.toString()),
    );
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
        title: const DragToMoveArea(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text('Sidecar app'),
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
          openWidth: 280,
          openMinWidth: 280,
          openMaxWidth: 280,
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
      height: 50,
      child: WindowCaption(
        brightness: theme.brightness,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();
final router = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainPage(
          child: child,
          shellContext: shellNavigatorKey.currentContext,
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

        // 代码片段
        GoRoute(
          path: '/snippet/main',
          builder: (context, state) => SnippetPage(),
        ),
        GoRoute(
          path: '/snippet/java',
          builder: (context, state) => JavaSnippetPage(),
        ),
      ],
    ),
  ],
);
