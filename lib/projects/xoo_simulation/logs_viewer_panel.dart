
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_reviewer_2025v1/projects/xoo_simulation/simple_logger_helper.dart';

class LogsViewerPanel extends StatefulWidget {
  const LogsViewerPanel({super.key});
  @override
  State<LogsViewerPanel> createState() => _LogsViewerPanelState();
}

class _LogsViewerPanelState extends State<LogsViewerPanel> {
  List<String> logs = [];
  Timer? _timer;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadLogs();
    _timer =
        Timer.periodic(const Duration(seconds: 1), (_) => _loadLogs());
  }

  Future<void> _loadLogs() async {
    final loaded = await SimpleLogger.getAllLogs();
    if (mounted) {
      setState(() => logs = loaded);
      // Auto-scroll to bottom
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text("Logs",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          TextButton.icon(
            onPressed: () async {
              await SimpleLogger.clearLogs();
              _loadLogs();
            },
            icon: const Icon(Icons.delete, color: Colors.red),
            label:
            const Text("Clear", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
      const Divider(height: 2),
      Expanded(
        child: logs.isEmpty
            ? const Center(child: Text("No logs found."))
            : ListView.builder(
          controller: _scrollController,
          itemCount: logs.length,
          itemBuilder: (context, idx) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              logs[idx],
              style: const TextStyle(
                  fontFamily: 'monospace', fontSize: 12),
            ),
          ),
        ),
      ),
    ],
  );
}