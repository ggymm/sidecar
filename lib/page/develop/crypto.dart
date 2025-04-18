import 'package:fluent_ui/fluent_ui.dart';

class CryptoDevelopPage extends StatefulWidget {
  const CryptoDevelopPage({super.key});

  @override
  State<CryptoDevelopPage> createState() => CryptoDevelopPageState();
}

class CryptoDevelopPageState extends State<CryptoDevelopPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(title: Text('加解密工具')),
      children: [Text('CryptoDevelop')],
    );
  }
}
