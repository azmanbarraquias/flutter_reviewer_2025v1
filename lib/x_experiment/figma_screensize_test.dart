import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1280, 800), // your Figma size!
      child: MaterialApp(
        title: 'Flutter Figma',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MyPage(),
      ),
    );
  }
}

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 140.w,
              child: Container(
                color: Color.fromARGB(1, 230, 230, 230),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: size.width,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Text("Size: ${constraints.maxWidth} x ${constraints.maxHeight}");
                          },
                        ),
                      ),
                    ),
                    Expanded(child: Container(color: Colors.blue)),
                    Expanded(child: Container(color: Colors.yellow)),
                    Expanded(child: Container(color: Colors.green)),
                    Expanded(child: Container(color: Colors.deepPurple)),
                  ],
                ),
              ),
            ),
            Expanded(child: Container(color: Colors.orange,
            child: LayoutBuilder(builder: (context, constraints) {
              return Text("Size: ${constraints.maxWidth} x ${constraints.maxHeight}");
            }),))
          ],
        ),
      ),
    );
  }
}
