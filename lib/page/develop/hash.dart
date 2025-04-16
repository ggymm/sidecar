import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:file_selector/file_selector.dart';
import 'package:fluent_ui/fluent_ui.dart';

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

  final inputController = TextEditingController();
  final outputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(title: Text('哈希散列')),
      children: [
        Card(
          child: Row(
            children: [
              Text('输入类型'),
              SizedBox(
                width: 120,
                child: ComboBox<String>(
                  value: type,
                  items: types,
                  onChanged: (value) {
                    setState(() {
                      type = value!;
                      inputController.text = ''; // 清空输入框
                      outputController.text = ''; // 清空输出框
                    });
                  },
                  isExpanded: true,
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          padding: EdgeInsets.all(20),
          borderRadius: BorderRadius.circular(10),
        ),
        SizedBox(height: 20),
        Card(
          child: Column(
            children: [
              Row(
                children: [
                  Text('输入内容'),
                  Row(
                    children: [
                      Visibility(
                        child: SizedBox(
                          width: 120,
                          height: 36,
                          child: Button(
                            child: const Text('选择文件'),
                            onPressed: () async {
                              final XFile? file = await openFile();
                              if (file != null) {
                                setState(() {
                                  inputController.text = file.path;
                                });
                              }
                            },
                          ),
                        ),
                        visible: type == 'file',
                      ),
                      Visibility(
                        child: SizedBox(width: 20),
                        visible: type == 'file',
                      ),
                      SizedBox(
                        width: 120,
                        height: 36,
                        child: Button(
                          child: const Text('计算 Hash'),
                          onPressed: () {
                            if (type == 'file') {
                              return;
                            }

                            final bytes = utf8.encode(inputController.text);
                            final md5Hash = md5.convert(bytes).toString();
                            final sha1Hash = sha1.convert(bytes).toString();
                            final sha256Hash = sha256.convert(bytes).toString();
                            final sha512Hash = sha512.convert(bytes).toString();

                            setState(() {
                              outputController.text = 'MD5:     $md5Hash';
                              outputController.text += '\nSHA1:    $sha1Hash';
                              outputController.text += '\nSHA256:  $sha256Hash';
                              outputController.text += '\nSHA512:  $sha512Hash';
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 80,
                child: TextBox(
                  maxLines: null,
                  readOnly: type == 'file',
                  controller: inputController,
                ),
              ),
            ],
          ),
          padding: EdgeInsets.all(20),
          borderRadius: BorderRadius.circular(10),
        ),
        SizedBox(height: 20),
        Card(
          child: Column(
            children: [
              Row(
                children: [Text('输出结果')],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 120,
                child: TextBox(
                  maxLines: null,
                  readOnly: true,
                  controller: outputController,
                ),
              ),
            ],
          ),
          padding: EdgeInsets.all(20),
          borderRadius: BorderRadius.circular(10),
        ),
      ],
    );
  }
}
