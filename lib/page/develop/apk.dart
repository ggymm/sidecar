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
                    height: 80,
                    child: Card(
                      padding: EdgeInsets.all(20),
                      borderRadius: BorderRadius.circular(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('文件路径'),
                          Row(
                            children: [
                              SizedBox(
                                width: 260,
                                child: TextBox(maxLines: null),
                              ),
                              SizedBox(width: 20),
                              SizedBox(
                                width: 120,
                                height: 34,
                                child: Button(
                                  child: const Text('计算 Hash'),
                                  onPressed: () async {},
                                ),
                              ),
                            ],
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
                            child: Text('解析结果'),
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
