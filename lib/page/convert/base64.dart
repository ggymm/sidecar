import 'dart:convert';

import 'package:fluent_ui/fluent_ui.dart';

class Base64ConvertPage extends StatefulWidget {
  const Base64ConvertPage({super.key});

  @override
  State<Base64ConvertPage> createState() => Base64ConvertPageState();
}

class Base64ConvertPageState extends State<Base64ConvertPage> {
  final originCtrl = TextEditingController();
  final resultCtrl = TextEditingController();

  void encode() {
    resultCtrl.text = '';
    final text = originCtrl.text;
    if (text.isNotEmpty) {
      try {
        final encode = base64Encode(utf8.encode(text));
        if (encode.isNotEmpty) {
          resultCtrl.text = encode;
        }
      } catch (e) {
        resultCtrl.text = '编码失败: $e';
      }
    }
  }

  void decode() {
    originCtrl.text = '';
    final text = resultCtrl.text;
    if (text.isNotEmpty) {
      try {
        final decode = base64Decode(text);
        if (decode.isNotEmpty) {
          originCtrl.text = utf8.decode(decode);
        }
      } catch (e) {
        originCtrl.text = '解码失败: $e';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(title: Text('Base64编解码')),
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
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('原始内容'),
                          ),
                          SizedBox(height: 20),
                          Expanded(
                            child: TextBox(
                              minLines: 1,
                              maxLines: null,
                              controller: originCtrl,
                              onChanged: (v) {
                                encode();
                              },
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
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('编码内容'),
                          ),
                          SizedBox(height: 20),
                          Expanded(
                            child: TextBox(
                              minLines: 1,
                              maxLines: null,
                              controller: resultCtrl,
                              onChanged: (v) {
                                decode();
                              },
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
