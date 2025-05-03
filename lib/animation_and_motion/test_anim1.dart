import 'package:flutter/material.dart';
import 'package:flutter_reviewer_2025v1/utils/xprint.dart';

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

  final title = 'MyPage';

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with SingleTickerProviderStateMixin {
  bool isClick = false;
  late AnimationController _controller;
  late Animation<Size> _heightAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _heightAnimation = Tween<Size>(
      begin: Size(200, 200),
      end: Size(400, 400),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _heightAnimation.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add, color: Colors.white),
          ),
        ],
        title: Text(widget.title),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            xPrint('Hello');
            test();
            isClick ? _controller.reverse() : _controller.forward();
            isClick = !isClick;
          },
          child: Container(
            height: _heightAnimation.value.height,
            width: _heightAnimation.value.width,
            alignment: Alignment.center,
            color: Colors.black38,
            child: Text('Click', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }

  Future<void> test() async {
    var num = await Future.delayed(Duration(seconds: 3), () {
      return 1;
    });
    xPrint('Line is waitiang');
    xPrint(num);
  }
}
