import 'package:fluent_ui/fluent_ui.dart';

class NginxPage extends StatefulWidget {
  const NginxPage({super.key});

  @override
  State<NginxPage> createState() => NginxPageState();
}

class NginxPageState extends State<NginxPage> {
  @override
  Widget build(BuildContext context) {
    return const ScaffoldPage(
      header: PageHeader(title: Text('Nginx')),
      content: Text('Nginx'),
    );
  }
}