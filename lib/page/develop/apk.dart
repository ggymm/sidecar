import 'package:fluent_ui/fluent_ui.dart';

class ApkDevelopPage extends StatefulWidget {
  const ApkDevelopPage({super.key});

  @override
  State<ApkDevelopPage> createState() => ApkDevelopPageState();
}

class ApkDevelopPageState extends State<ApkDevelopPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(title: Text('APK')),
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
                          Text('文件路径'),
                          Row(
                            children: [
                              SizedBox(
                                child: TextBox(maxLines: null),
                                width: 260,
                              ),
                              SizedBox(width: 20),
                              SizedBox(
                                child: Button(
                                  child: const Text('计算 Hash'),
                                  onPressed: () async {},
                                ),
                                width: 120,
                                height: 34,
                              ),
                            ],
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
                          Align(
                            child: Text('解析结果'),
                            alignment: Alignment.centerLeft,
                          ),
                          SizedBox(height: 16),
                          Expanded(
                            child: TextBox(
                              minLines: 1,
                              maxLines: null,
                              readOnly: true,
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
