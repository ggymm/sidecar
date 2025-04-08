import 'package:fluent_ui/fluent_ui.dart';

class TimestampConvertPage extends StatefulWidget {
  const TimestampConvertPage({super.key});

  @override
  State<TimestampConvertPage> createState() => TimestampConvertPageState();
}

class TimestampConvertPageState extends State<TimestampConvertPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(title: Text('TimestampConvert')),
      children: [Text('TimestampConvert')],
    );
  }
}
