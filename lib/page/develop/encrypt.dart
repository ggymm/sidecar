import 'package:fluent_ui/fluent_ui.dart';

class EncryptDevelopPage extends StatefulWidget {
  const EncryptDevelopPage({super.key});

  @override
  State<EncryptDevelopPage> createState() => EncryptDevelopPageState();
}

class EncryptDevelopPageState extends State<EncryptDevelopPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(title: Text('加解密工具')),
      children: [Text('EncryptDevelop')],
    );
  }
}
