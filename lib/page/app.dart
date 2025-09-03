import 'package:fluent_ui/fluent_ui.dart';

class OsInfo {
  final String name;
  final String version;
  final String serialNumber;
  final String kernelVersion;

  OsInfo({
    required this.name,
    required this.version,
    required this.serialNumber,
    required this.kernelVersion,
  });
}

class EnvInfo {
  final String shell;
  final String currentUser;

  EnvInfo({required this.shell, required this.currentUser});
}

class CpuInfo {
  final String arch;
  final String brand;
  final int physicalCores;

  CpuInfo({
    required this.arch,
    required this.brand,
    required this.physicalCores,
  });
}

class MemoryInfo {
  final int used;
  final int total;
  final int totalSwap;

  MemoryInfo({
    required this.used,
    required this.total,
    required this.totalSwap,
  });
}

class NetworkInfo {
  final String name;
  final String ipAddress;
  final String macAddress;

  NetworkInfo({
    required this.name,
    required this.ipAddress,
    required this.macAddress,
  });
}

class StaticInfo {
  final OsInfo os;
  final EnvInfo env;
  final CpuInfo cpu;
  final MemoryInfo memory;
  final NetworkInfo network;

  StaticInfo({
    required this.os,
    required this.env,
    required this.cpu,
    required this.memory,
    required this.network,
  });
}

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => AppPageState();
}

class AppPageState extends State<AppPage> {
  final StaticInfo staticInfo = StaticInfo(
    cpu: CpuInfo(arch: "aarch64", brand: "Apple M4 Pro", physicalCores: 12),
    memory: MemoryInfo(used: 29801742336, total: 51539607552, totalSwap: 0),
    network: NetworkInfo(
      name: "en1",
      ipAddress: "192.168.1.56",
      macAddress: "d0:11:e5:21:69:12",
    ),
    os: OsInfo(
      name: "Darwin",
      version: "15.6.1",
      serialNumber: "XFPWXLV4CQ",
      kernelVersion: "24.6.0",
    ),
    env: EnvInfo(shell: "/bin/zsh", currentUser: "ggymm"),
  );

  Widget buildOsCard() {
    return buildInfoCard('系统信息', [
      buildInfoRow('当前用户', staticInfo.env.currentUser),
      buildInfoRow('内核版本', staticInfo.os.kernelVersion),
      buildInfoRow('操作系统', '${staticInfo.os.name} ${staticInfo.os.version}'),
    ]);
  }

  Widget buildCpuCard() {
    return buildInfoCard('CPU 信息', [
      buildInfoRow('架构', staticInfo.cpu.arch),
      buildInfoRow('处理器', staticInfo.cpu.brand),
      buildInfoRow('物理核心', '${staticInfo.cpu.physicalCores} 个'),
    ]);
  }

  Widget buildMemoryCard() {
    String formatBytes(int bytes) {
      const units = ['B', 'KB', 'MB', 'GB', 'TB'];
      int unitIndex = 0;
      double size = bytes.toDouble();

      while (size >= 1024 && unitIndex < units.length - 1) {
        size /= 1024;
        unitIndex++;
      }

      return '${size.toStringAsFixed(2)} ${units[unitIndex]}';
    }

    return buildInfoCard('内存信息', [
      buildInfoRow('已使用', formatBytes(staticInfo.memory.used)),
      buildInfoRow('总内存', formatBytes(staticInfo.memory.total)),
      buildInfoRow('交换分区', formatBytes(staticInfo.memory.totalSwap)),
    ]);
  }

  Widget buildNetworkCard() {
    return buildInfoCard('网络信息', [
      buildInfoRow('网卡名称', staticInfo.network.name),
      buildInfoRow('IP 地址', staticInfo.network.ipAddress),
      buildInfoRow('MAC 地址', staticInfo.network.macAddress),
    ]);
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 160, child: Text(label)),
          const SizedBox(width: 20),
          Expanded(child: SelectableText(value)),
        ],
      ),
    );
  }

  Widget buildInfoCard(String title, List<Widget> children) {
    return Card(
      padding: const EdgeInsets.all(20),
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ...children,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(title: Text('首页')),
      content: Padding(
        padding: EdgeInsetsDirectional.only(
          start: PageHeader.horizontalPadding(context),
          end: PageHeader.horizontalPadding(context),
          bottom: kPageDefaultVerticalPadding,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: buildCpuCard()),
                  const SizedBox(width: 20),
                  Expanded(child: buildMemoryCard()),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: buildOsCard()),
                  const SizedBox(width: 20),
                  Expanded(child: buildNetworkCard()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
