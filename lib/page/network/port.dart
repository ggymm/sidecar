import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';

class PortNetworkPage extends StatefulWidget {
  const PortNetworkPage({super.key});

  @override
  State<PortNetworkPage> createState() => PortNetworkPageState();
}

class PortNetworkPageState extends State<PortNetworkPage> {
  var starting = false;

  final portCtrl = TextEditingController();
  final outputCtrl = TextEditingController();
  final outputScrollCtrl = ScrollController();

  Future<void> queryPort() async {
    outputCtrl.text = ''; // 清空输出
    final port = portCtrl.text.trim();
    if (Platform.isMacOS) {
      if (port.isEmpty) {
        return;
      }
      final ports = port.split(',');
      for (var i = 0; i < ports.length; i++) {
        final args = ':${ports[i]}';
        final output = await Process.run('lsof', ['-i', args]);
        setState(() {
          outputCtrl.text += output.stderr + '\n';
          outputCtrl.text += output.stdout + '\n';
        });
      }
      return;
    } else if (Platform.isWindows) {
      final ports = port.split(',');
      for (var i = 0; i < ports.length; i++) {
        final args = ':${ports[i]}';
        final output = await Process.run('netstat', ['-ano', args]);
        setState(() {
          outputCtrl.text += output.stderr + '\n';
          outputCtrl.text += output.stdout + '\n';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(title: Text('端口占用查询')),
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
                        Expanded(child: TextBox(controller: portCtrl)),
                        SizedBox(width: 20),
                        SizedBox(
                          width: 120,
                          height: 34,
                          child: Button(
                            child:
                                starting
                                    ? const Text('查询中...')
                                    : const Text('查询'),
                            onPressed: () async {
                              if (starting) {
                                return;
                              }
                              starting = true;
                              await queryPort();
                              starting = false;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: TextBox(
                        maxLines: null,
                        controller: outputCtrl,
                        scrollController: outputScrollCtrl,
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
