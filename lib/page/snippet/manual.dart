import 'package:fluent_ui/fluent_ui.dart';

class ManualSnippetPage extends StatefulWidget {
  const ManualSnippetPage({super.key});

  @override
  State<ManualSnippetPage> createState() => ManualSnippetPageState();
}

class ManualSnippetPageState extends State<ManualSnippetPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(title: Text('命令手册')),
      children: [Text('ManualSnippet')],
    );
  }
}
