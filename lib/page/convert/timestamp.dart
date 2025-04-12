import 'package:fluent_ui/fluent_ui.dart';

class TimestampConvertPage extends StatefulWidget {
  const TimestampConvertPage({super.key});

  @override
  State<TimestampConvertPage> createState() => TimestampConvertPageState();
}

class TimestampConvertPageState extends State<TimestampConvertPage> {
  var unit = 1;
  final units = <ComboBoxItem<int>>[
    ComboBoxItem<int>(child: Text('秒'), value: 1),
    ComboBoxItem<int>(child: Text('毫秒'), value: 1000),
  ];

  var timezone = 8.0;
  final timezones = <ComboBoxItem<double>>[
    ComboBoxItem<double>(child: Text('(UTC-12:00) 国际日期变更线西'), value: -12.0),
    ComboBoxItem<double>(child: Text('(UTC-11:00) 萨摩亚标准时间'), value: -11.0),
    ComboBoxItem<double>(child: Text('(UTC-10:00) 夏威夷-阿留申标准时间'), value: -10.0),
    ComboBoxItem<double>(child: Text('(UTC-09:00) 阿拉斯加标准时间'), value: -9.0),
    ComboBoxItem<double>(child: Text('(UTC-08:00) 北美太平洋标准时间'), value: -8.0),
    ComboBoxItem<double>(child: Text('(UTC-07:00) 北美山地标准时间'), value: -7.0),
    ComboBoxItem<double>(child: Text('(UTC-06:00) 北美中部标准时间'), value: -6.0),
    ComboBoxItem<double>(child: Text('(UTC-05:00) 北美东部标准时间'), value: -5.0),
    ComboBoxItem<double>(child: Text('(UTC-04:00) 大西洋标准时间'), value: -4.0),
    ComboBoxItem<double>(child: Text('(UTC-03:00) 阿根廷标准时间'), value: -3.0),
    ComboBoxItem<double>(child: Text('(UTC-02:00) 中大西洋标准时间'), value: -2.0),
    ComboBoxItem<double>(child: Text('(UTC-01:00) 亚速尔标准时间'), value: -1.0),
    ComboBoxItem<double>(child: Text('(UTC±00:00) 格林尼治标准时间'), value: 0.0),
    ComboBoxItem<double>(child: Text('(UTC+01:00) 中欧标准时间'), value: 1.0),
    ComboBoxItem<double>(child: Text('(UTC+02:00) 东欧标准时间'), value: 2.0),
    ComboBoxItem<double>(child: Text('(UTC+03:00) 莫斯科标准时间'), value: 3.0),
    ComboBoxItem<double>(child: Text('(UTC+04:00) 海湾标准时间'), value: 4.0),
    ComboBoxItem<double>(child: Text('(UTC+05:00) 巴基斯坦标准时间'), value: 5.0),
    ComboBoxItem<double>(child: Text('(UTC+05:30) 印度标准时间'), value: 5.5),
    ComboBoxItem<double>(child: Text('(UTC+05:45) 尼泊尔标准时间'), value: 5.75),
    ComboBoxItem<double>(child: Text('(UTC+06:00) 孟加拉标准时间'), value: 6.0),
    ComboBoxItem<double>(child: Text('(UTC+06:30) 缅甸标准时间'), value: 6.5),
    ComboBoxItem<double>(child: Text('(UTC+07:00) 中南半岛标准时间'), value: 7.0),
    ComboBoxItem<double>(child: Text('(UTC+08:00) 中国标准时间'), value: 8.0),
    ComboBoxItem<double>(child: Text('(UTC+09:00) 日本标准时间'), value: 9.0),
    ComboBoxItem<double>(child: Text('(UTC+09:30) 澳大利亚中部标准时间'), value: 9.5),
    ComboBoxItem<double>(child: Text('(UTC+10:00) 澳大利亚东部标准时间'), value: 10.0),
    ComboBoxItem<double>(child: Text('(UTC+11:00) 所罗门群岛标准时间'), value: 11.0),
    ComboBoxItem<double>(child: Text('(UTC+12:00) 新西兰标准时间'), value: 12.0),
    ComboBoxItem<double>(child: Text('(UTC+13:00) 汤加标准时间'), value: 13.0),
    ComboBoxItem<double>(child: Text('(UTC+14:00) 莱恩群岛标准时间'), value: 14.0),
  ];

  late final months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  late final weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  var value;
  late var normal = '';
  late var iso8601 = '';
  late var rfc7231 = '';

  void formatDatetime(DateTime time) {
    String year, month, day, hour, minute, second, weekday;

    // 格式化时间
    year = time.year.toString();
    day = time.day.toString().padLeft(2, '0');
    hour = time.hour.toString().padLeft(2, '0');
    minute = time.minute.toString().padLeft(2, '0');
    second = time.second.toString().padLeft(2, '0');

    // Wed, 02 Jan 2000 04:05:06 GMT
    month = months[time.month - 1];
    weekday = weekdays[time.weekday];
    rfc7231 =
        "${weekday}, ${day} ${month} ${year} ${hour}:${minute}:${second} GMT";

    // 时区转换
    time = time.add(Duration(minutes: (timezone * 60).round()));

    // 格式化时间
    year = time.year.toString();
    month = time.month.toString().padLeft(2, '0');
    day = time.day.toString().padLeft(2, '0');
    hour = time.hour.toString().padLeft(2, '0');
    minute = time.minute.toString().padLeft(2, '0');
    second = time.second.toString().padLeft(2, '0');

    var zone = formatTimezone(timezone);
    switch (unit) {
      case 1:
        normal = "${year}-${month}-${day} ${hour}:${minute}:${second}";
        iso8601 = "${year}-${month}-${day}T${hour}:${minute}:${second}${zone}";
        break;
      case 1000:
        String millisecond = time.millisecond.toString().padLeft(3, '0');
        normal =
            "${year}-${month}-${day} ${hour}:${minute}:${second}.${millisecond}";
        iso8601 =
            "${year}-${month}-${day}T${hour}:${minute}:${second}.${millisecond}${zone}";
        break;
    }
  }

  static String formatTimezone(double timezone) {
    final sign = timezone >= 0 ? '+' : '-';
    final hours = timezone.abs();
    final offsetHour = hours.floor().toString().padLeft(2, '0');
    final offsetMinute = ((hours % 1) * 60).round().toString().padLeft(2, '0');
    return sign + offsetHour + ':' + offsetMinute;
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(title: Text('时间戳转换工具')),
      children: [
        Card(
          child: Row(
            children: [
              Text('时间戳'),
              Row(
                children: [
                  SizedBox(
                    width: 240,
                    child: NumberBox(
                      mode: SpinButtonPlacementMode.inline,
                      value: value,
                      onChanged: (int? value) {
                        setState(() {
                          // 格式化时间
                          int millisecond = value ?? 0;
                          if (unit == 1) {
                            millisecond = millisecond * 1000;
                          }
                          DateTime time = DateTime.fromMillisecondsSinceEpoch(
                            millisecond,
                            isUtc: true,
                          );

                          formatDatetime(time);
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  SizedBox(
                    width: 100,
                    child: ComboBox<int>(
                      value: unit,
                      items: units,
                      onChanged: (value) {
                        setState(() {
                          unit = value!;
                        });
                      },
                      isExpanded: true,
                    ),
                  ),
                  SizedBox(width: 20),
                  SizedBox(
                    width: 100,
                    height: 36,
                    child: Button(
                      child: const Text('当前时间'),
                      onPressed: () {
                        setState(() {
                          // 格式化时间
                          DateTime time = DateTime.now();
                          unit = 1000;
                          value = time.millisecondsSinceEpoch;
                          formatDatetime(time);
                        });
                      },
                    ),
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
          child: Row(
            children: [
              Text('时区选择'),
              SizedBox(
                width: 480,
                child: ComboBox<double>(
                  value: timezone,
                  items: timezones,
                  onChanged: (value) {
                    setState(() {
                      timezone = value!;
                    });
                  },
                  isExpanded: true,
                ),
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
            children: [Text('Normal'), Text(normal)],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          padding: EdgeInsets.all(20),
          borderRadius: BorderRadius.circular(10),
        ),
        SizedBox(height: 20),
        Card(
          child: Row(
            children: [Text('ISO 8601'), Text(iso8601)],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          padding: EdgeInsets.all(20),
          borderRadius: BorderRadius.circular(10),
        ),
        SizedBox(height: 20),
        Card(
          child: Row(
            children: [Text('RFC 7231'), Text(rfc7231)],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          padding: EdgeInsets.all(20),
          borderRadius: BorderRadius.circular(10),
        ),
      ],
    );
  }
}
