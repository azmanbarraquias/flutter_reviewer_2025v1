import 'dart:io';
import 'dart:convert';

class SimpleLogger {
  static const String fileName = "azumalog.txt";
  static const String logFolderPath = "/storage/emulated/0/azuma_app/";

  static Future<void> writeLog(String message) async {
    final dateNow = DateTime.now();
    final formatedDateNow = "${dateNow.year}-${dateNow.month}-${dateNow.day} ${dateNow.hour}:${dateNow.minute}:${dateNow.second}";
    final formatted = "$formatedDateNow : $message\n";
    final contentBytes = utf8.encode(formatted);

    final folder = Directory(logFolderPath);
    if (!await folder.exists()) {
      await folder.create(recursive: true);
    }

    final file = File("${folder.path}$fileName");
    await file.writeAsBytes(contentBytes, mode: FileMode.append);
  }

  static Future<List<String>> getAllLogs() async {
    final file = File("$logFolderPath$fileName");
    if (await file.exists()) {
      final contents = await file.readAsLines(encoding: utf8);
      return contents;
    } else {
      return ["No logs found."];
    }
  }

  static Future<void> clearLogs() async {
    final file = File("$logFolderPath$fileName");
    if (await file.exists()) {
      await file.writeAsString('', flush: true);
    }
  }

}