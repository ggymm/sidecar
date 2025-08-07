import 'package:fluent_ui/fluent_ui.dart';

class ToolkitPage extends StatefulWidget {
  const ToolkitPage({super.key});

  @override
  State<ToolkitPage> createState() => ToolkitPageState();
}

class ToolkitPageState extends State<ToolkitPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(title: Text('便捷工具')),
      children: [Text('Snippet')],
    );
  }
}
