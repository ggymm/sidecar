import 'package:fluent_ui/fluent_ui.dart';
import 'package:x509/x509.dart';

class CertDevelopPage extends StatefulWidget {
  const CertDevelopPage({super.key});

  @override
  State<CertDevelopPage> createState() => CertDevelopPageState();
}

class CertDevelopPageState extends State<CertDevelopPage> {
  final certNode = FocusNode();
  final certCtrl = TextEditingController();

  final parsedNode = FocusNode();
  final parsedCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    certNode.addListener(() {
      // 解析 x509 证书
      var text = certCtrl.text;
      if (!text.isNotEmpty) {
        return;
      }

      // 如果输入文本包含 字符串的 \n 替换为实际换行符
      text = text.replaceAll(r'\n', '\n');
      setState(() {
        certCtrl.text = text;
      });

      try {
        final cert = parsePem(text).first as X509Certificate;
        setState(() {
          parsedCtrl.text = cert.toString();
        });
      } catch (e) {
        setState(() {
          parsedCtrl.text = '解析失败: $e';
        });
      }
    });
  }

  @override
  void dispose() {
    certNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(title: Text('证书解析')),
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
                      child: Column(
                        children: [
                          Align(
                            child: Text('证书'),
                            alignment: Alignment.centerLeft,
                          ),
                          SizedBox(height: 16),
                          Expanded(
                            child: TextBox(
                              minLines: 1,
                              maxLines: null,
                              focusNode: certNode,
                              controller: certCtrl,
                            ),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(20),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 200,
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
                              focusNode: parsedNode,
                              controller: parsedCtrl,
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
