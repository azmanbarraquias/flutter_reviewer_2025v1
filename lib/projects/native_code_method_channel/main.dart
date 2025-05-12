import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/xprint.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: MyPage());
  }
}

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  static const platform = MethodChannel('samples.flutter.dev/battery');

  final title = 'Native Code';

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  int? _batteryLevel;
  num _randomNumber = 0;
  String? _deviceName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> _getBatteryLevel() async {
    // get function/method name
    try {
      final batteryLevel = await MyPage.platform.invokeMethod(
        'getBatteryLevel',
      );
      setState(() {
        _batteryLevel = batteryLevel;
      });
    } on PlatformException catch (e) {
      xPrint(e);
      setState(() {
        _batteryLevel = null;
      });
    } catch (error) {
      xPrint(error);
      setState(() {
        _batteryLevel = null;
      });
    }
  }

  Future<void> _getDeviceName() async {
    try {
      final deviceName = await MyPage.platform.invokeMethod('getDeviceName');
      setState(() {
        _deviceName = deviceName;
      });
    } on PlatformException catch (e) {
      xPrint(e);
      setState(() {
        _deviceName = null;
      });
    } catch (error) {
      xPrint(error);
    }
  }

  Future<void> _getRandomNumber() async {
    try {
      final randomNum = await MyPage.platform.invokeMethod('getRandomNumber');
      setState(() {
        _randomNumber = randomNum;
      });
    } on PlatformException catch (e) {
      xPrint(e);
      setState(() {
        _randomNumber = 0;
      });
    } catch (error) {
      xPrint(error);
      setState(() {
        _randomNumber = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {
              _getBatteryLevel();
            },
            icon: const Icon(
              Icons.battery_unknown_rounded,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              _getRandomNumber();
            },
            icon: const Icon(Icons.numbers, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              _getDeviceName();
            },
            icon: const Icon(Icons.device_unknown, color: Colors.white),
          ),
        ],
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Container(
          // Start Here
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Battery Level: $_batteryLevel'),
              Text('Random number: $_randomNumber'),
              Text('Device Name: $_deviceName'),
            ],
          ),
        ),
      ),
    );
  }
}
