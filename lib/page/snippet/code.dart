import 'package:fluent_ui/fluent_ui.dart';

class CodeSnippetPage extends StatefulWidget {
  const CodeSnippetPage({super.key});

  @override
  State<CodeSnippetPage> createState() => CodeSnippetPageState();
}

class CodeSnippetPageState extends State<CodeSnippetPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(title: Text('Code')),
      children: [Text('Code')],
    );
  }
}
