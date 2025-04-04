import 'package:fluent_ui/fluent_ui.dart';

class RedisPage extends StatefulWidget {
  const RedisPage({super.key});

  @override
  State<RedisPage> createState() => RedisPageState();
}

class RedisPageState extends State<RedisPage> {
  @override
  Widget build(BuildContext context) {
    return const ScaffoldPage(
      header: PageHeader(title: Text('Redis')),
      content: Text('Redis'),
    );
  }
}