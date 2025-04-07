import 'package:fluent_ui/fluent_ui.dart';

class ConvertPage extends StatefulWidget {
  const ConvertPage({super.key});

  @override
  State<ConvertPage> createState() => ConvertPageState();
}

class ConvertPageState extends State<ConvertPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(title: Text('Convert')),
      children: [Text('Convert')],
    );
  }
}
