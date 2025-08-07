import 'dart:convert';
import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:sidecar/app.dart';

class QrcodeDevelopPage extends StatefulWidget {
  const QrcodeDevelopPage({super.key});

  @override
  State<QrcodeDevelopPage> createState() => QrcodeDevelopPageState();
}

class QrcodeDevelopPageState extends State<QrcodeDevelopPage> {
  String? qrcode;
  var outputCtrl = TextEditingController();

  Future<void> parseQrcode() async {
    if (qrcode == null) {
      return;
    }
    final bin = await App.getQrcodeBin();
    final output = await Process.run(bin, [qrcode!], stdoutEncoding: utf8);
    setState(() {
      outputCtrl.text = output.stdout;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(title: Text('二维码')),
      content: Padding(
        padding: EdgeInsetsDirectional.only(
          end: PageHeader.horizontalPadding(context),
          start: PageHeader.horizontalPadding(context),
          bottom: kPageDefaultVerticalPadding,
        ),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Card(
                      padding: EdgeInsets.all(20),
                      borderRadius: BorderRadius.circular(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('文件'),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 120,
                                    height: 34,
                                    child: Button(
                                      child: const Text('选择文件'),
                                      onPressed: () async {
                                        final XFile? file = await openFile();
                                        if (file != null) {
                                          setState(() {
                                            qrcode = file.path;
                                          });
                                          parseQrcode();
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Expanded(
                            child:
                                qrcode == null
                                    ? SizedBox()
                                    : Image.file(File(qrcode!)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 240,
                    child: Card(
                      padding: EdgeInsets.all(20),
                      borderRadius: BorderRadius.circular(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text('解析结果')],
                          ),
                          SizedBox(height: 16),
                          Expanded(
                            child: TextBox(
                              maxLines: null,
                              readOnly: true,
                              controller: outputCtrl,
                              style: TextStyle(fontFamily: 'Cascadia Mono'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
