import 'dart:convert';
import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:sidecar/app.dart';

class ShareToolkitPage extends StatefulWidget {
  const ShareToolkitPage({super.key});

  @override
  State<ShareToolkitPage> createState() => ShareToolkitPageState();
}

class ShareToolkitPageState extends State<ShareToolkitPage> {
  int pid = -1;
  String qrcode = '';
  String download = '';
  String filepath = '';

  Future<void> serverCtrl() async {
    if (pid == -1) {
      // 启动服务
      final bin = await App.getShareBin();
      final process = await Process.start(bin, [filepath]);

      pid = process.pid;

      // 监听标准输出
      process.stdout.transform(utf8.decoder).listen((data) {
        // 解析 JSON 输出
        final json = jsonDecode(data);
        final fileId = json['file_id'];
        final baseUrl = json['base_url'];

        setState(() {
          qrcode = '$baseUrl/qrcode';
          download = '$baseUrl/$fileId';
        });
      });
    } else {
      if (Platform.isMacOS) {
        await Process.run('kill', ['-9', '$pid']);
      } else if (Platform.isWindows) {
        await Process.run('taskkill', ['/PID', '$pid', '/F']);
      }

      // 停止服务, 清空内容
      setState(() {
        pid = -1;
        qrcode = '';
        download = '';
        filepath = '';
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(title: Text('文件分享')),
      content: Padding(
        padding: EdgeInsetsDirectional.only(
          end: PageHeader.horizontalPadding(context),
          start: PageHeader.horizontalPadding(context),
          bottom: kPageDefaultVerticalPadding,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 240,
              child: Card(
                padding: EdgeInsets.all(20),
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('文件选择'),
                        Row(
                          children: [
                            SizedBox(
                              width: 120,
                              height: 34,
                              child: Button(
                                onPressed: () async {
                                  final XFile? file = await openFile();
                                  if (file != null) {
                                    setState(() {
                                      filepath = file.path;
                                    });
                                  }
                                },
                                child: const Text('选择文件'),
                              ),
                            ),
                            SizedBox(width: 20),
                            SizedBox(
                              width: 120,
                              height: 34,
                              child: Button(
                                onPressed: () {
                                  serverCtrl();
                                },
                                child: Text(pid == -1 ? '启动服务' : '停止服务'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: Center(
                        child: SingleChildScrollView(
                          child: Text(
                            filepath,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Card(
                padding: EdgeInsets.all(20),
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('文件下载'),
                    SizedBox(height: 20),
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child:
                                  pid == -1
                                      ? SizedBox.shrink()
                                      : Padding(
                                        padding: EdgeInsets.all(20),
                                        child: Image.network(qrcode),
                                      ),
                            ),
                            SizedBox(height: 20),
                            SelectableText(download),
                          ],
                        ),
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
