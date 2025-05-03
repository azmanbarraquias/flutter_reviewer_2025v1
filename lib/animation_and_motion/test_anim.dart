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
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
    );

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            xPrint('Hello');
            test();
            setState(() {
              isClick = !isClick;
            });
            isClick ? _controller.forward() : _controller.reverse();
          },
          child: AnimatedContainer(
            height: isClick ? 400 : 200,
            width: isClick ? 400 : 200,
            color: Colors.black38,
            alignment: Alignment.center,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeIn,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(

                  child: Center(child: Text('Click', style: TextStyle(color: Colors.white))),
                ),
                if (isClick)
                  Expanded(
                    child: FadeTransition(
                      opacity: _opacityAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: FittedBox(child: FlutterLogo()),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> test() async {
    var num = await Future.delayed(Duration(seconds: 3), () {
      return 1;
    });
    xPrint('Line is waiting');
    xPrint(num);
  }
}
