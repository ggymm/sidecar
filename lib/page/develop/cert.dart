import 'package:fluent_ui/fluent_ui.dart';
import 'package:x509/x509.dart';

class CertDevelopPage extends StatefulWidget {
  const CertDevelopPage({super.key});

  @override
  State<CertDevelopPage> createState() => CertDevelopPageState();
}

class CertDevelopPageState extends State<CertDevelopPage> {
  final certCtrl = TextEditingController();
  final parsedCtrl = TextEditingController();

  Future<void> parseCert() async {
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
                    height: 240,
                    child: Card(
                      padding: EdgeInsets.all(20),
                      borderRadius: BorderRadius.circular(10),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('证书'),
                          ),
                          SizedBox(height: 20),
                          Expanded(
                            child: TextBox(
                              minLines: 1,
                              maxLines: null,
                              controller: certCtrl,
                              onChanged: (value) {
                                parseCert();
                              }
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
                            child: Text('解析结果'),
                          ),
                          SizedBox(height: 20),
                          Expanded(
                            child: TextBox(
                              minLines: 1,
                              maxLines: null,
                              readOnly: true,
                              controller: parsedCtrl,
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
