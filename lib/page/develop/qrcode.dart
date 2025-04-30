import 'package:fluent_ui/fluent_ui.dart';

class QrcodeDevelopPage extends StatefulWidget {
  const QrcodeDevelopPage({super.key});

  @override
  State<QrcodeDevelopPage> createState() => QrcodeDevelopPageState();
}

class QrcodeDevelopPageState extends State<QrcodeDevelopPage> {
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
                                    height: 36,
                                    child: Button(
                                      child: const Text('选择文件'),
                                      onPressed: () async {},
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                          SizedBox(height: 20),
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
