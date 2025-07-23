import 'package:fluent_ui/fluent_ui.dart';

class NetworkPage extends StatefulWidget {
  const NetworkPage({super.key});

  @override
  State<NetworkPage> createState() => NetworkPageState();
}

class NetworkPageState extends State<NetworkPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(title: Text('网络工具')),
      children: [Text('Network')],
    );
  }
}
