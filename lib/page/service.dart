import 'package:fluent_ui/fluent_ui.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => ServicePageState();
}

class ServicePageState extends State<ServicePage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(title: Text('Service')),
      children: [Text('Service')],
    );
  }
}
