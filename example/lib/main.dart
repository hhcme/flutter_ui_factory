import 'package:example/src/routes/routes_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frame_hyc/flutter_frame_hyc.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // todo 这里可能还是有问题, 因为是需要context的, 但是加载可能会有大量异步
    FrameOfHYC.init(context);
    return Builder(builder: (BuildContext context) {
      return MaterialApp(
        title: 'frame ui 测试',
        // todo 这里的主题色还没有定好怎么做
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: TestRouterConfig.routes,
        initialRoute: '/',
        navigatorObservers: [HycNavigatorObserver()],
        // 增加路由监听
        builder: (BuildContext context, Widget? child) {
          return ScreenWidget(
            child: child,
          );
        },
      );
    });
  }
}
