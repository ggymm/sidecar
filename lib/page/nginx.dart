import 'package:fluent_ui/fluent_ui.dart';

class NginxPage extends StatefulWidget {
  const NginxPage({super.key});

  @override
  State<NginxPage> createState() => NginxPageState();
}

class NginxPageState extends State<NginxPage> {
  bool isStart = false;
  bool showConfig = false;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(title: Text('Nginx')),
      children: [
        Card(
          child: Row(
            children: [
              Text('服务状态'),
              ToggleSwitch(
                checked: isStart,
                onChanged: (bool value) {
                  setState(() {
                    isStart = value;
                  });
                },
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          padding: EdgeInsets.all(20),
          borderRadius: BorderRadius.circular(10),
        ),
        SizedBox(height: 20),
        Card(
          child: Row(
            children: [
              Text('服务目录'),
              Row(
                children: [
                  SizedBox(width: 240, child: TextBox(readOnly: true)),
                  SizedBox(width: 20),
                  IconButton(
                    icon: const Icon(FluentIcons.settings, size: 20),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          padding: EdgeInsets.all(20),
          borderRadius: BorderRadius.circular(10),
        ),
        SizedBox(height: 20),
        Card(
          child: Column(
            children: [
              Row(
                children: [
                  Text('服务配置'),
                  IconButton(
                    icon: Icon(
                      showConfig
                          ? FluentIcons.chevron_up
                          : FluentIcons.chevron_down,
                      size: 12,
                    ),
                    onPressed: () {
                      setState(() {
                        showConfig = !showConfig;
                      });
                    },
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              Visibility(visible: showConfig, child: SizedBox(height: 20)),
              Visibility(
                visible: showConfig,
                child: SizedBox(height: 320, child: TextBox(maxLines: null)),
              ),
            ],
          ),
          padding: EdgeInsets.all(20),
          borderRadius: BorderRadius.circular(10),
        ),
      ],
    );
  }
}
