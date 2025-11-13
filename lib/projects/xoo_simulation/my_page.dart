import 'dart:async';
import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reviewer_2025v1/projects/xoo_simulation/simple_logger_helper.dart';
import 'battery_service.dart';
import 'doze_mode_helper.dart';
import 'logs_viewer_panel.dart';
import 'main.dart';
import 'dart:io';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  bool? lastDozeState;
  Timer? periodicLogTimer;
  StreamSubscription<bool>? dozeStreamSub;
  final MyAppLifecycleLogger _lifecycleLogger = MyAppLifecycleLogger();
  final BatteryService _batteryService = BatteryService();

  @override
  void initState() {
    super.initState();

    // --- App Lifecycle Logging ---
    _lifecycleLogger.start();

    // Always keep latest doze state in a variable for the periodic logger
    dozeStreamSub = DozeModeListener.dozeModeStream.listen((value) {
      lastDozeState = value;
    });

    // Start periodic logger: logs every 1 minute
    periodicLogTimer = Timer.periodic(const Duration(minutes: 1), (Timer t) {
      SimpleLogger.writeLog(
        "Periodic log at ${DateTime.now()} | doze status: $lastDozeState",
      );
    });
  }

  @override
  void dispose() {
    _lifecycleLogger.stop();
    periodicLogTimer?.cancel();
    dozeStreamSub?.cancel();
    super.dispose();
  }

  void _showSnackBar(BuildContext context, bool inDoze) {
    final snackBar = SnackBar(
      content: Text(inDoze ? 'ENTERED Doze mode' : 'EXITED Doze mode'),
      backgroundColor: inDoze ? Colors.red : Colors.green,
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('XOO Simulation')),
      body: Row(
        children: [
          // Left = Doze status & log test button
          // check if android
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (Platform.isAndroid)
                  StreamBuilder<bool>(
                    stream: DozeModeListener.dozeModeStream,
                    builder: (context, snapshot) {
                      final dozeValue = snapshot.data;
                      // Show snackbar only if changed
                      if (dozeValue != null &&
                          lastDozeState != null &&
                          lastDozeState != dozeValue) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _showSnackBar(context, dozeValue);
                        });
                      }
                      lastDozeState = dozeValue;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            dozeValue == true ? Icons.bedtime : Icons.bolt,
                            size: 80,
                            color:
                                dozeValue == true ? Colors.red : Colors.green,
                          ),
                          Text(
                            dozeValue == true
                                ? "In Doze Mode"
                                : (dozeValue == false
                                    ? "Not in Doze Mode"
                                    : "Waiting for Doze state..."),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  dozeValue == true
                                      ? Colors.red
                                      : (dozeValue == false
                                          ? Colors.green
                                          : Colors.black),
                              fontSize: 24,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                const Divider(height: 2),
                Wrap(
                  spacing: 10,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        SimpleLogger.writeLog(
                          "Log Test Time: ${DateTime.now()}",
                        );
                        setState(() {});
                      },
                      child: const Text('Log Test'),
                    ),
                    ElevatedButton(
                      onPressed: ()   async {
                        final batStat = await  _batteryService.getBatteryState();
                        final batLevel = await _batteryService.getBatteryLevel();
                        SimpleLogger.writeLog(
                          "Battery State: $batStat | Battery Level: $batLevel",
                        );
                      },
                      child: const Text('Log Battery Stat'),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Right = Log Viewer
          const VerticalDivider(width: 2),
          const Expanded(flex: 2, child: LogsViewerPanel()),
        ],
      ),
    );
  }
}
