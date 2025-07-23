import 'package:fluent_ui/fluent_ui.dart';

class SnippetPage extends StatefulWidget {
  const SnippetPage({super.key});

  @override
  State<SnippetPage> createState() => SnippetPageState();
}

class SnippetPageState extends State<SnippetPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(title: Text('代码片段')),
      children: [Text('Snippet')],
    );
  }
}
