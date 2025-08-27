import 'package:file_selector/file_selector.dart';
import 'package:fluent_ui/fluent_ui.dart';

class ShareToolkitPage extends StatefulWidget {
  const ShareToolkitPage({super.key});

  @override
  State<ShareToolkitPage> createState() => ShareToolkitPageState();
}

class ShareToolkitPageState extends State<ShareToolkitPage> {
  String? selectedFilePath;
  bool isServerRunning = false;
  String serverUrl = '';
  int port = 8080;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(title: Text('文件分享')),
      content: Padding(
        padding: EdgeInsetsDirectional.only(
          end: PageHeader.horizontalPadding(context),
          start: PageHeader.horizontalPadding(context),
          bottom: kPageDefaultVerticalPadding,
        ),
        child: Column(
          children: [
            // 顶部文件选择和服务控制区域
            Container(
              height: 200,
              child: Card(
                padding: EdgeInsets.all(20),
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 文件选择区域
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('文件选择'),
                              SizedBox(height: 8),
                              Container(
                                height: 40,
                                child: selectedFilePath == null
                                    ? Text('请选择要分享的文件')
                                    : Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('${selectedFilePath!.split('/').last}', 
                                               style: TextStyle(fontWeight: FontWeight.w500)),
                                          SizedBox(height: 2),
                                          Text('$selectedFilePath', 
                                               style: TextStyle(fontSize: 11),
                                               overflow: TextOverflow.ellipsis),
                                        ],
                                      ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        SizedBox(
                          width: 120,
                          height: 34,
                          child: Button(
                            onPressed: () async {
                              final XFile? file = await openFile();
                              if (file != null) {
                                setState(() {
                                  selectedFilePath = file.path;
                                });
                              }
                            },
                            child: const Text('选择文件'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Divider(),
                    SizedBox(height: 12),
                    // 服务控制和状态区域
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('状态: '),
                                  Text('${isServerRunning ? '运行中' : '未启动'}',
                                       style: TextStyle(fontWeight: FontWeight.w500)),
                                  SizedBox(width: 20),
                                  Text('端口: '),
                                  Text('${isServerRunning ? port.toString() : '-'}'),
                                ],
                              ),
                              SizedBox(height: 6),
                              Text('访问地址: ${serverUrl.isEmpty ? '-' : serverUrl}',
                                   style: TextStyle(fontFamily: 'Cascadia Mono', fontSize: 12)),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        SizedBox(
                          width: 100,
                          height: 34,
                          child: Button(
                            onPressed: selectedFilePath == null ? null : () {
                              setState(() {
                                isServerRunning = !isServerRunning;
                                if (isServerRunning) {
                                  serverUrl = 'http://192.168.1.100:$port';
                                } else {
                                  serverUrl = '';
                                }
                              });
                            },
                            child: Text(isServerRunning ? '停止' : '启动'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // 底部二维码区域
            Expanded(
              child: Card(
                padding: EdgeInsets.all(20),
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('下载二维码'),
                    SizedBox(height: 16),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        child: Center(
                          child: isServerRunning
                              ? Container(
                                  width: 300,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[50],
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.grey[200]),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('二维码显示区域'),
                                        SizedBox(height: 8),
                                        Text(serverUrl, 
                                             style: TextStyle(fontSize: 12, fontFamily: 'Cascadia Mono')),
                                      ],
                                    ),
                                  ),
                                )
                              : Text('启动服务后显示二维码'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
