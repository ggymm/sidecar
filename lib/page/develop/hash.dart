import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:file_selector/file_selector.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:sidecar/app.dart';

class HashDevelopPage extends StatefulWidget {
  const HashDevelopPage({super.key});

  @override
  State<HashDevelopPage> createState() => HashDevelopPageState();
}

class HashDevelopPageState extends State<HashDevelopPage> {
  var type = 'text';
  final types = <ComboBoxItem<String>>[
    ComboBoxItem<String>(value: 'text', child: Text('文本类型')),
    ComboBoxItem<String>(value: 'file', child: Text('文件类型')),
  ];

  final inputCtrl = TextEditingController();
  final outputCtrl = TextEditingController();

  Future<void> hashFile() async {
    final bin = await App.getHashBin();
    final output = await Process.run(bin, [inputCtrl.text]);
    setState(() {
      outputCtrl.text = output.stdout;
    });
  }

  Future<void> hashText() async {
    final bytes = utf8.encode(inputCtrl.text);
    final md5Hash = md5.convert(bytes).toString();
    final sha1Hash = sha1.convert(bytes).toString();
    final sha256Hash = sha256.convert(bytes).toString();
    final sha512Hash = sha512.convert(bytes).toString();

    setState(() {
      outputCtrl.text = 'MD5:     $md5Hash';
      outputCtrl.text += '\nSHA1:    $sha1Hash';
      outputCtrl.text += '\nSHA256:  $sha256Hash';
      outputCtrl.text += '\nSHA512:  $sha512Hash';
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(title: Text('哈希散列')),
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
                  SizedBox(
                    height: 80,
                    child: Card(
                      padding: EdgeInsets.all(20),
                      borderRadius: BorderRadius.circular(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('输入类型'),
                          SizedBox(
                            width: 260,
                            child: ComboBox<String>(
                              value: type,
                              items: types,
                              onChanged: (value) {
                                setState(() {
                                  type = value!;
                                  inputCtrl.text = ''; // 清空输入框
                                  outputCtrl.text = ''; // 清空输出框
                                });
                              },
                              isExpanded: true,
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
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('输入内容'),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 120,
                                    height: 34,
                                    child: Button(
                                      onPressed:
                                          type != 'file'
                                              ? null
                                              : () async {
                                                final XFile? file =
                                                    await openFile();
                                                if (file != null) {
                                                  setState(() {
                                                    inputCtrl.text = file.path;
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
                                      child: const Text('计算 Hash'),
                                      onPressed: () async {
                                        if (inputCtrl.text.isEmpty) {
                                          return;
                                        }
                                        if (type == 'file') {
                                          hashFile();
                                          return;
                                        }
                                        hashText();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Expanded(
                            child: TextBox(
                              maxLines: null,
                              readOnly: type == 'file',
                              controller: inputCtrl,
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
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text('输出结果')],
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
