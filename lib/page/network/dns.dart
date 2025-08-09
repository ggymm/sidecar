import 'dart:convert';
import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:sidecar/app.dart';

class DnsNetworkPage extends StatefulWidget {
  const DnsNetworkPage({super.key});

  @override
  State<DnsNetworkPage> createState() => DnsNetworkPageState();
}

class DnsNetworkPageState extends State<DnsNetworkPage> {
  var starting = false;

  final domainCtrl = TextEditingController();
  final outputCtrl = TextEditingController();
  final outputScrollCtrl = ScrollController();

  Future<void> queryDomain() async {
    outputCtrl.text = ''; // 清空输出
    final domain = domainCtrl.text.trim();
    if (domain.isEmpty) {
      return;
    }
    try {
      final uri = Uri.parse("https://$domain");
      if (uri.host.isEmpty ||
          (uri.host != domain && !uri.host.endsWith('.$domain'))) {
        return;
      }
    } catch (e) {
      return;
    }

    final bin = await App.getDnsBin();
    final process = await Process.start(bin, [domain]);
    process.stdout
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .listen((line) {
          setState(() {
            outputCtrl.text += '$line\n';
            WidgetsBinding.instance.addPostFrameCallback((_) {
              outputScrollCtrl.animateTo(
                outputScrollCtrl.position.maxScrollExtent,
                curve: Curves.easeOut,
                duration: Duration(milliseconds: 300),
              );
            });
          });
        });
    process.stderr
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .listen((line) {
          setState(() {
            outputCtrl.text += '$line\n';
          });
        });

    await process.exitCode;
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(title: Text('域名查询')),
      content: Padding(
        padding: EdgeInsetsDirectional.only(
          end: PageHeader.horizontalPadding(context),
          start: PageHeader.horizontalPadding(context),
          bottom: kPageDefaultVerticalPadding,
        ),
        child: Column(
          children: [
            Expanded(
              child: Card(
                padding: EdgeInsets.all(20),
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(child: TextBox(controller: domainCtrl)),
                        SizedBox(width: 20),
                        SizedBox(
                          width: 120,
                          height: 34,
                          child: Button(
                            child:
                                starting
                                    ? const Text('查询中...')
                                    : const Text('查询'),
                            onPressed: () async {
                              if (starting) {
                                return;
                              }
                              starting = true;
                              await queryDomain();
                              starting = false;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: TextBox(
                        maxLines: null,
                        readOnly: true,
                        controller: outputCtrl,
                        scrollController: outputScrollCtrl,
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
