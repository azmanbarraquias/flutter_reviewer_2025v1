import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

 const platform = MethodChannel('samples.flutter.dev/battery');

void main() {
  runApp(MyAppMC());
  platform.setMethodCallHandler(_handlerFromNative);
}

Future<dynamic> _handlerFromNative(MethodCall call) async {
  if (call.method == "fromNative") {
    final String value = call.arguments["value"];
    print("Received from native: $value");
    // Do something with value
    return "ACK from Dart";
  }
  return null;
}

class MyAppMC extends StatelessWidget {
  const MyAppMC({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PassingValueMc(),
    );
  }
}

class PassingValueMc extends StatefulWidget {
  const PassingValueMc({super.key});

  @override
  State<PassingValueMc> createState() => _PassingValueMcState();
}

class _PassingValueMcState extends State<PassingValueMc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Passing Value')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // button and text
            OutlinedButton(onPressed: () {
              _callMe();
            }, child: Text('Press Me')),
            SizedBox(height: 10),
            Text('data'),
          ],
        ),
      ),
    );
  }

  Future<void> _callMe() async {
    try {
      // This will trigger the "callMe" handler in Kotlin,
      // which then calls notifyFlutter(), and returns getDeviceName().
      final deviceName = await platform.invokeMethod('callMe');
      print("Device name: $deviceName");
    } on PlatformException catch (e) {
      debugPrint('PlatformException: ${e.message}');
    } catch (error) {
      debugPrint('Error: $error');
    }
  }
}
