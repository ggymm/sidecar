import 'dart:math';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';

class RandomDevelopPage extends StatefulWidget {
  const RandomDevelopPage({super.key});

  @override
  State<RandomDevelopPage> createState() => RandomDevelopPageState();
}

class RandomDevelopPageState extends State<RandomDevelopPage> {
  final macController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void showToast() async {
    await displayInfoBar(
      context,
      builder: (context, close) {
        return InfoBar(
          title: const Text('通知：'),
          content: const Text('已复制到剪贴板'),
          action: IconButton(
            icon: const Icon(FluentIcons.clear),
            onPressed: close,
          ),
          severity: InfoBarSeverity.success,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = 80.0;
    return ScaffoldPage.scrollable(
      header: PageHeader(title: Text('模拟数据')),
      children: [
        SizedBox(
          height: height,
          child: Card(
            padding: EdgeInsets.all(20),
            borderRadius: BorderRadius.circular(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('MAC地址'),
                Row(
                  children: [
                    SizedBox(
                      width: 480,
                      child: TextBox(controller: macController),
                    ),
                    SizedBox(width: 20),
                    SizedBox(
                      width: 100,
                      height: 34,
                      child: Button(
                        child: const Text('随机'),
                        onPressed: () {
                          final rd = Random();
                          final bytes = List<int>.generate(
                            6,
                            (_) => rd.nextInt(256),
                          );
                          bytes[0] = (bytes[0] | 0x02) & 0xFE;

                          // dart format off
                          var macAddress = bytes
                              .map((b) => b.toRadixString(16).padLeft(2, '0'))
                              .join(':')
                              .toUpperCase();
                          // dart format on

                          setState(() {
                            macController.text = macAddress;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    SizedBox(
                      width: 100,
                      height: 34,
                      child: Button(
                        child: const Text('复制'),
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(text: macController.text),
                          );
                          showToast();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
