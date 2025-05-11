import 'dart:convert';
import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path/path.dart';
import 'package:sidecar/app.dart';

class QrcodeDevelopPage extends StatefulWidget {
  const QrcodeDevelopPage({super.key});

  @override
  State<QrcodeDevelopPage> createState() => QrcodeDevelopPageState();
}

class QrcodeDevelopPageState extends State<QrcodeDevelopPage> {
  var qrcode;
  var output = TextEditingController();

  final Widget imageIcon = SvgPicture.asset(
    'assets/icons/image.svg',
    width: 120,
    height: 120,
    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
    semanticsLabel: 'Java Icon',
  );

  parseQrcode() async {
    final dir = await App.getBinDir();
    final result = await Process.run(join(dir, App.qrcode, App.qrcode), [
      qrcode,
    ], stdoutEncoding: utf8);
    setState(() {
      if (Platform.isWindows) {
        output.text = result.stdout;
      } else {
        output.text = result.stdout;
      }
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
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('图片'),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                          Expanded(
                            child:
                                qrcode == null
                                    ? imageIcon
                                    : Image.file(File(qrcode)),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(20),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 240,
                    child: Card(
                      child: Column(
                        children: [
                          Row(
                            children: [Text('解析结果')],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                          SizedBox(height: 20),
                          Expanded(
                            child: TextBox(
                              maxLines: null,
                              readOnly: true,
                              controller: output,
                              style: TextStyle(fontFamily: 'Cascadia Mono'),
                            ),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(20),
                      borderRadius: BorderRadius.circular(10),
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
