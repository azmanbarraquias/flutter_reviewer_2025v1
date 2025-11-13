import 'package:flutter/services.dart';
import 'simple_logger_helper.dart'; // Adjust the import if needed

class DozeModeListener {
  static const _eventChannel = EventChannel('com.aws.arkray');

  // Only one stream, reused everywhere
  static final Stream<bool> dozeModeStream = _eventChannel
      .receiveBroadcastStream()
      .distinct() // Only emit if changed
      .map((event) {
    SimpleLogger.writeLog("Device Doze mode changed: $event");
    return event == true;
  });
}

