import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MaterialApp(home: HomeScreen()));
}

class ChartData {
  final List<double> points;
  ChartData(this.points);
}

/// Widget that *needs* a ChartData provider
class LineChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Simulate the line_renderer.dart bug by accessing chart data and using ! on null
    final data = Provider.of<ChartData?>(context, listen: false)!; // This will be null!
    // Simulate chart "painting"
    return Container(
      margin: EdgeInsets.all(24),
      padding: EdgeInsets.all(24),
      color: Colors.blue.shade50,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.show_chart, size: 64, color: Colors.blue),
          SizedBox(height: 12),
          Text('Chart Data: ${data.points.toString()}'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Simulate Chart Error")),
      body: Center(
        child: ElevatedButton(
          child: Text("Go to Chart Screen (Crash!)"),
          onPressed: () {
            // Navigate to screen where chart's provider will be missing
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => ChartScreenWithoutProvider(),
            ));
          },
        ),
      ),
    );
  }
}

class ChartScreenWithoutProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Note: No Provider<ChartData> above this!
    return Scaffold(
      appBar: AppBar(title: Text("Chart Screen")),
      body: Center(
        child: LineChartWidget(),
      ),
    );
  }
}
