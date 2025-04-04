import 'package:fluent_ui/fluent_ui.dart';

class MySQLPage extends StatefulWidget {
  const MySQLPage({super.key});

  @override
  State<MySQLPage> createState() => MySQLPageState();
}

class MySQLPageState extends State<MySQLPage> {
  @override
  Widget build(BuildContext context) {
    return const ScaffoldPage(
      header: PageHeader(title: Text('MySQL')),
      content: Text('MySQL'),
    );
  }
}