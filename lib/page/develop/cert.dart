import 'package:fluent_ui/fluent_ui.dart';

class CertDevelopPage extends StatefulWidget {
  const CertDevelopPage({super.key});

  @override
  State<CertDevelopPage> createState() => CertDevelopPageState();
}

class CertDevelopPageState extends State<CertDevelopPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(title: Text('CertDevelop')),
      children: [Text('CertDevelop')],
    );
  }
}
