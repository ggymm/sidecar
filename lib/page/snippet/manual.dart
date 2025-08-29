import 'dart:convert';
import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:path/path.dart';
import 'package:sidecar/app.dart';

class Manual {
  final String name;
  final String path;
  final List<dynamic> keywords;

  Manual({required this.name, required this.path, this.keywords = const []});

  factory Manual.fromJson(Map<String, dynamic> json) {
    return Manual(
      name: json['name'],
      path: json['path'],
      keywords: json['keywords'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'path': path,
    'keywords': keywords,
  };
}

class ManualSnippetPage extends StatefulWidget {
  const ManualSnippetPage({super.key});

  @override
  State<ManualSnippetPage> createState() => ManualSnippetPageState();
}

class ManualSnippetPageState extends State<ManualSnippetPage> {
  static double size = 48.0;

  List<Manual> items = [];
  String selected = '';

  Future<void> showContent(BuildContext context, int index) async {
    final item = items[index];
    final file = File(join(await App.getManualRoot(), item.path));
    if (!await file.exists()) {
      return;
    }

    // 使用 notepad 打开文件
    if (Platform.isMacOS) {
      await Process.run('open', ["-a", "textedit", file.path]);
    } else if (Platform.isWindows) {
      await Process.run('notepad', [file.path]);
    }
  }

  @override
  void initState() {
    super.initState();

    // 读取数据
    App.getManualIndex().then((s) async {
      final file = File(s);
      if (!await file.exists()) {
        return;
      }

      final content = await file.readAsString();
      final List<dynamic> contentJson = json.decode(content);

      setState(() {
        items = contentJson.map((json) => Manual.fromJson(json)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(title: Text('命令手册')),
      content: Padding(
        padding: EdgeInsetsDirectional.only(
          end: PageHeader.horizontalPadding(context),
          start: PageHeader.horizontalPadding(context),
          bottom: kPageDefaultVerticalPadding,
        ),
        child: Column(
          children: [
            Expanded(
              child: Card(
                padding: EdgeInsets.all(20),
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(child: TextBox()),
                        SizedBox(width: 20),
                        SizedBox(
                          width: 120,
                          height: 34,
                          child: Button(
                            child: const Text('搜索'),
                            onPressed: () async {},
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index].name;
                          return ListTile.selectable(
                            title: Text(item, style: TextStyle(fontSize: 14)),
                            selected: selected == item,
                            onSelectionChange: (v) {
                              showContent(context, index);
                            },
                          );
                        },
                        separatorBuilder:
                            (BuildContext context, int index) =>
                                const SizedBox(height: 8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
