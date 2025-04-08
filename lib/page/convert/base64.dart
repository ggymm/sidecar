import 'dart:convert';

import 'package:fluent_ui/fluent_ui.dart';

class Base64ConvertPage extends StatefulWidget {
  @override
  State<Base64ConvertPage> createState() => Base64ConvertPageState();
}

class Base64ConvertPageState extends State<Base64ConvertPage> {
  final origin = new TextEditingController();
  final encode = new TextEditingController();

  @override
  void initState() {
    super.initState();

    origin.addListener(() {
      setState(() {
        encode.text = '';
        if (origin.text.isNotEmpty) {
          encode.text = base64Encode(utf8.encode(origin.text));
        }
      });
    });

    encode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    origin.dispose();
    encode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(title: Text('Base64 转换器')),
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
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Align(
                            child: Padding(
                              child: Text('原始内容'),
                              padding: EdgeInsets.only(left: 8, bottom: 12),
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                          Expanded(
                            child: TextBox(
                              minLines: 1,
                              maxLines: null,
                              controller: origin,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        children: [
                          Align(
                            child: Padding(
                              child: Text('编码内容'),
                              padding: EdgeInsets.only(left: 8, bottom: 12),
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                          Expanded(
                            child: TextBox(
                              minLines: 1,
                              maxLines: null,
                              controller: encode,
                            ),
                          ),
                        ],
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
    );
  }
}
