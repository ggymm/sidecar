import 'package:fluent_ui/fluent_ui.dart';

class NginxPage extends StatefulWidget {
  const NginxPage({super.key});

  @override
  State<NginxPage> createState() => NginxPageState();
}

class NginxPageState extends State<NginxPage> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(title: Text('Nginx')),
      children: [
        Row(
          children: [
            Text('服务状态:'),
            SizedBox(width: 20),
            ToggleSwitch(
              checked: checked,
              onChanged: (bool value) {
                setState(() {
                  checked = value;
                });
              },
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Text('服务目录'),
            SizedBox(width: 20),
            Expanded(child: TextBox(readOnly: true)),
            SizedBox(width: 20),
            Button(onPressed: () {}, child: const Text('修改目录')),
          ],
        ),
        SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('服务配置'),
            SizedBox(width: 20),
            Expanded(
              child: SizedBox(height: 200.0, child: TextBox(maxLines: null)),
            ),
          ],
        ),
      ],
    );
  }
}
