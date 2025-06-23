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
    ComboBoxItem<String>(child: Text('文本类型'), value: 'text'),
    ComboBoxItem<String>(child: Text('文件类型'), value: 'file'),
  ];

  final input = TextEditingController();
  final output = TextEditingController();

  hashFile() async {
    final bin = await App.getHashBin();
    final result = await Process.run(bin, [input.text]);
    setState(() {
      output.text = result.stdout;
    });
  }

  hashText() async {
    final bytes = utf8.encode(input.text);
    final md5Hash = md5.convert(bytes).toString();
    final sha1Hash = sha1.convert(bytes).toString();
    final sha256Hash = sha256.convert(bytes).toString();
    final sha512Hash = sha512.convert(bytes).toString();

    setState(() {
      output.text = 'MD5:     $md5Hash';
      output.text += '\nSHA1:    $sha1Hash';
      output.text += '\nSHA256:  $sha256Hash';
      output.text += '\nSHA512:  $sha512Hash';
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
                    child: Card(
                      child: Row(
                        children: [
                          Text('输入类型'),
                          SizedBox(
                            child: ComboBox<String>(
                              value: type,
                              items: types,
                              onChanged: (value) {
                                setState(() {
                                  type = value!;
                                  input.text = ''; // 清空输入框
                                  output.text = ''; // 清空输出框
                                });
                              },
                              isExpanded: true,
                            ),
                            width: 260,
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                      padding: EdgeInsets.all(20),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 80,
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: Card(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('输入内容'),
                              Row(
                                children: [
                                  SizedBox(
                                    child: Button(
                                      child: const Text('选择文件'),
                                      onPressed:
                                          type != 'file'
                                              ? null
                                              : () async {
                                                final XFile? file =
                                                    await openFile();
                                                if (file != null) {
                                                  setState(() {
                                                    input.text = file.path;
                                                  });
                                                }
                                              },
                                    ),
                                    width: 120,
                                    height: 34,
                                  ),
                                  SizedBox(width: 20),
                                  SizedBox(
                                    child: Button(
                                      child: const Text('计算 Hash'),
                                      onPressed: () async {
                                        if (input.text.isEmpty) {
                                          return;
                                        }
                                        if (type == 'file') {
                                          await hashFile();
                                          return;
                                        }
                                        await hashText();
                                      },
                                    ),
                                    width: 120,
                                    height: 34,
                                  ),
                                ],
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                          SizedBox(height: 16),
                          Expanded(
                            child: TextBox(
                              maxLines: null,
                              readOnly: type == 'file',
                              controller: input,
                            ),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(20),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: Card(
                      child: Column(
                        children: [
                          Row(
                            children: [Text('输出结果')],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                          SizedBox(height: 16),
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
