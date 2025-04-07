import 'package:fluent_ui/fluent_ui.dart';

class JavaSnippetPage extends StatefulWidget {
  const JavaSnippetPage({super.key});

  @override
  State<JavaSnippetPage> createState() => JavaSnippetPageState();
}

class JavaSnippetPageState extends State<JavaSnippetPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(title: Text('JavaSnippet')),
      children: [Text('JavaSnippet')],
    );
  }
}
