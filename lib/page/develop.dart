import 'package:fluent_ui/fluent_ui.dart';

class DevelopPage extends StatefulWidget {
  const DevelopPage({super.key});

  @override
  State<DevelopPage> createState() => DevelopPageState();
}

class DevelopPageState extends State<DevelopPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(title: Text('Develop')),
      children: [Text('Develop')],
    );
  }
}
