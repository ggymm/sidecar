import 'dart:convert';

import 'package:fluent_ui/fluent_ui.dart';

class Base64ConvertPage extends StatefulWidget {
  const Base64ConvertPage({super.key});

  @override
  State<Base64ConvertPage> createState() => Base64ConvertPageState();
}

class Base64ConvertPageState extends State<Base64ConvertPage> {
  final originNode = FocusNode();
  final originCtrl = TextEditingController();

  final encodeNode = FocusNode();
  final encodeCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    originNode.addListener(() {
      setState(() {
        encodeCtrl.text = '';
        final text = originCtrl.text;
        if (text.isNotEmpty) {
          try {
            final encode = base64Encode(utf8.encode(text));
            if (encode.isNotEmpty) {
              encodeCtrl.text = encode;
            }
          } catch (e) {
            encodeCtrl.text = '编码失败: $e';
          }
        }
      });
    });

    encodeNode.addListener(() {
      setState(() {
        originCtrl.text = '';
        final text = encodeCtrl.text;
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
      });
    });
  }

  @override
  void dispose() {
    originNode.dispose();
    encodeNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(title: Text('Base64')),
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
                          SizedBox(height: 16),
                          Expanded(
                            child: TextBox(
                              minLines: 1,
                              maxLines: null,
                              focusNode: originNode,
                              controller: originCtrl,
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
                          SizedBox(height: 16),
                          Expanded(
                            child: TextBox(
                              minLines: 1,
                              maxLines: null,
                              focusNode: encodeNode,
                              controller: encodeCtrl,
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
