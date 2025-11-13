import 'package:battery_plus/battery_plus.dart';

class BatteryService {
  final Battery _battery = Battery();

  Future<BatteryState> getBatteryState() async {
    try {
      final currentBatteryState = await _battery.batteryState;
      return currentBatteryState;
    } on Exception catch (error) {
      return BatteryState.unknown;
    }
  }

  Future<int> getBatteryLevel() async {
    try {
      final currentBatteryLevel = await _battery.batteryLevel;
      return currentBatteryLevel;
    } on Exception catch (error) {
      return 0;
    }
  }
}
