import 'package:fluent_ui/fluent_ui.dart';

class DnsNetworkPage extends StatefulWidget {
  const DnsNetworkPage({super.key});

  @override
  State<DnsNetworkPage> createState() => DnsNetworkPageState();
}

class DnsNetworkPageState extends State<DnsNetworkPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(title: Text('域名查询')),
      children: [Text('DnsNetwork')],
    );
  }
}
