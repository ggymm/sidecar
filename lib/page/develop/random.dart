import 'dart:math';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class RandomDevelopPage extends StatefulWidget {
  const RandomDevelopPage({super.key});

  @override
  State<RandomDevelopPage> createState() => RandomDevelopPageState();
}

class RandomDevelopPageState extends State<RandomDevelopPage> {
  final macCtrl = TextEditingController();
  final uuidCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();

  void showTip() async {
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
          severity: InfoBarSeverity.info,
        );
      },
    );
  }

  void randomMac() {
    final rd = Random();
    final bytes = List<int>.generate(6, (_) => rd.nextInt(256));
    bytes[0] = (bytes[0] | 0x02) & 0xFE;

    // dart format off
    var macAddress = bytes
        .map((b) => b.toRadixString(16).padLeft(2, '0'))
        .join(':')
        .toUpperCase();
    // dart format on

    setState(() {
      macCtrl.text = macAddress;
    });
  }

  void randomUUID() {
    final uuid = Uuid().v4();
    setState(() {
      uuidCtrl.text = uuid;
    });
  }

  void randomPhone() {
    final rd = Random();
    final nums = List<int>.generate(11, (_) => rd.nextInt(10));
    nums[0] = 1;
    setState(() {
      phoneCtrl.text = nums.join();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = 80.0;
    return ScaffoldPage.scrollable(
      header: PageHeader(title: Text('随机数据')),
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
                    SizedBox(width: 480, child: TextBox(controller: macCtrl)),
                    SizedBox(width: 20),
                    SizedBox(
                      width: 100,
                      height: 34,
                      child: Button(
                        child: const Text('生成'),
                        onPressed: () {
                          randomMac();
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
                          Clipboard.setData(ClipboardData(text: macCtrl.text));
                          showTip();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        SizedBox(
          height: height,
          child: Card(
            padding: EdgeInsets.all(20),
            borderRadius: BorderRadius.circular(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('UUID.v4'),
                Row(
                  children: [
                    SizedBox(width: 480, child: TextBox(controller: uuidCtrl)),
                    SizedBox(width: 20),
                    SizedBox(
                      width: 100,
                      height: 34,
                      child: Button(
                        child: const Text('生成'),
                        onPressed: () {
                          randomUUID();
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
                          Clipboard.setData(ClipboardData(text: uuidCtrl.text));
                          showTip();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        SizedBox(
          height: height,
          child: Card(
            padding: EdgeInsets.all(20),
            borderRadius: BorderRadius.circular(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('手机号码'),
                Row(
                  children: [
                    SizedBox(width: 480, child: TextBox(controller: phoneCtrl)),
                    SizedBox(width: 20),
                    SizedBox(
                      width: 100,
                      height: 34,
                      child: Button(
                        child: const Text('生成'),
                        onPressed: () {
                          randomPhone();
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
                            ClipboardData(text: phoneCtrl.text),
                          );
                          showTip();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
