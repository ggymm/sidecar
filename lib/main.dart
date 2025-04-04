import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:sidecar/page/mysql.dart';
import 'package:sidecar/page/nginx.dart';
import 'package:sidecar/page/redis.dart';
import 'package:sidecar/page/setting.dart';
import 'package:sidecar/window.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();
  windowManager.waitUntilReadyToShow(
    WindowOptions(
      size: Size(1200, 900),
      center: true,
      minimumSize: Size(800, 600),
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
      theme: FluentThemeData(brightness: Brightness.light),
      darkTheme: FluentThemeData(brightness: Brightness.dark),
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
  int index = 0;
  final searchFocusNode = FocusNode();
  final searchController = TextEditingController();

  late final List<NavigationPaneItem> items =
      [
        PaneItemHeader(header: const Text('Http')),
        PaneItem(
          key: const ValueKey('Nginx'),
          body: const SizedBox.shrink(),
          icon: const Icon(FluentIcons.home),
        ),
        PaneItemHeader(header: const Text('Cache')),
        PaneItem(
          key: const ValueKey('Redis'),
          body: const SizedBox.shrink(),
          icon: const Icon(FluentIcons.home),
        ),
        PaneItem(
          key: const ValueKey('MySQL'),
          body: const SizedBox.shrink(),
          icon: const Icon(FluentIcons.home),
        ),
        PaneItemHeader(header: const Text('Queue')),
      ].asMap().entries.map<NavigationPaneItem>((entry) {
        int key = entry.key;
        if (entry.value is PaneItem) {
          PaneItem item = entry.value as PaneItem;

          // 获取 item key 的值
          String value = (item.key as ValueKey).value;
          return PaneItem(
            key: item.key,
            icon: item.icon,
            body: item.body,
            title: Text(value),
            onTap: () {
              index = key;
              context.go('/$value');
            },
          );
        }
        return entry.value;
      }).toList();
  late final List<NavigationPaneItem> footerItems = [
    PaneItem(
      key: const ValueKey('Setting'),
      icon: const Icon(FluentIcons.settings),
      body: const SizedBox.shrink(),
      title: const Text('Setting'),
      onTap: () {
        index = 3;
        context.go('/Setting');
      },
    ),
  ];

  @override
  void dispose() {
    searchFocusNode.dispose();
    searchController.dispose();
    super.dispose();
  }

  int calcSelected(BuildContext context) {
    var loc = GoRouterState.of(context).uri.toString();
    loc = loc.replaceFirst('/', '');

    int index = items
        .where((item) => item.key != null)
        .toList()
        .indexWhere((item) => item.key == Key(loc));
    if (index > 0) {
      return index;
    }
    int indexFooter = footerItems
        .where((element) => element.key != null)
        .toList()
        .indexWhere((element) => element.key == Key(loc));
    if (indexFooter < 0) {
      return 0;
    }
    return items.where((item) => item.key != null).toList().length +
        indexFooter;
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        title: () {
          return const DragToMoveArea(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text('SidecarApp'),
            ),
          );
        }(),
        actions: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [const WindowButtons()],
        ),
        automaticallyImplyLeading: false,
      ),
      pane: NavigationPane(
        autoSuggestBox: Builder(
          builder: (context) {
            return AutoSuggestBox(
              focusNode: searchFocusNode,
              controller: searchController,
              unfocusedColor: Colors.transparent,
              items:
                  <PaneItem>[
                    ...items.whereType<PaneItemExpander>().expand<PaneItem>((
                      item,
                    ) {
                      return [item, ...item.items.whereType<PaneItem>()];
                    }),
                    ...items
                        .where(
                          (item) =>
                              item is PaneItem && item is! PaneItemExpander,
                        )
                        .cast<PaneItem>(),
                  ].map((item) {
                    final text = (item.title as Text).data!;
                    return AutoSuggestBoxItem(
                      label: text,
                      value: text,
                      onSelected: () {
                        item.onTap?.call();
                        searchFocusNode.unfocus();
                        searchController.clear();
                        final view = NavigationView.of(context);
                        if (view.compactOverlayOpen) {
                          view.compactOverlayOpen = false;
                        } else if (view.minimalPaneOpen) {
                          view.minimalPaneOpen = false;
                        }
                      },
                    );
                  }).toList(),
              placeholder: 'Search',
            );
          },
        ),
        items: items,
        footerItems: footerItems,
        selected: calcSelected(context),
      ),
      paneBodyBuilder: (item, child) {
        return widget.child;
      },
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
        GoRoute(path: '/', redirect: (context, state) => '/Nginx'),
        GoRoute(path: '/Nginx', builder: (context, state) => NginxPage()),
        GoRoute(path: '/Redis', builder: (context, state) => RedisPage()),
        GoRoute(path: '/MySQL', builder: (context, state) => MySQLPage()),
        GoRoute(path: '/Setting', builder: (context, state) => SettingPage()),
      ],
    ),
  ],
);
