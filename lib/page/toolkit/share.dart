import 'package:fluent_ui/fluent_ui.dart';

class ShareToolkitPage extends StatefulWidget {
  const ShareToolkitPage({super.key});

  @override
  State<ShareToolkitPage> createState() => ShareToolkitPageState();
}

class ShareToolkitPageState extends State<ShareToolkitPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(title: Text('便捷工具')),
      children: [Text('Snippet')],
    );
  }
}
