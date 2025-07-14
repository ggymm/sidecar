import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ConvertPage extends StatefulWidget {
  const ConvertPage({super.key});

  @override
  State<ConvertPage> createState() => ConvertPageState();
}

class ConvertPageState extends State<ConvertPage> {
  static double size = 48.0;
  final List<Map<String, dynamic>> items = [
    {
      'icon': SvgPicture.asset(
        'asset/icon/base64.svg',
        width: size,
        height: size,
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        semanticsLabel: 'Base64 Icon',
      ),
      'text': 'Base64',
      'path': '/convert/base64',
    },
    {
      'icon': SvgPicture.asset(
        'asset/icon/timestamp.svg',
        width: size,
        height: size,
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        semanticsLabel: 'Timestamp Icon',
      ),
      'text': '时间戳转换',
      'path': '/convert/timestamp',
    },
  ];
  final ValueNotifier<int?> hovered = ValueNotifier<int?>(null);

  void handleItemTap(int index) {
    final path = items[index]['path'];
    if (GoRouterState.of(context).uri.toString() != path) {
      context.go(path);
    }
  }

  @override
  void dispose() {
    hovered.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(title: Text('转换工具')),
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 180,
            childAspectRatio: 1.0,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ValueListenableBuilder<int?>(
              valueListenable: hovered,
              builder: (context, hoveredIndex, _) {
                final isHovered = hoveredIndex == index;
                return MouseRegion(
                  onEnter: (_) => hovered.value = index,
                  onExit: (_) => hovered.value = null,
                  child: GestureDetector(
                    onTap: () {
                      handleItemTap(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF2D2D2D),
                        border:
                            isHovered
                                ? Border.all(
                                  color: const Color(0xFF3C3C3C),
                                  width: 1.0,
                                )
                                : null,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          items[index]['icon'],
                          SizedBox(height: 20),
                          Text(items[index]['text']),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
