import 'package:flutter/material.dart';
import 'package:flutter_frame_hyc/flutter_frame_hyc.dart';
import 'package:flutter_ui_hyc/flutter_ui_hyc.dart';

import 'logic.dart';

class AppHomeView extends HycFrameView<AppHomeLogic> {
  AppHomeView({required BuildContext context, Key? key}) : super(key: key, context: context, dependency: () => AppHomeLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: screenUtil.adaptive(200),
            ),
            ButtonWithLoad(
              title: '登录',
              func: () async {
                await Future.delayed(const Duration(seconds: 2));
              },
            )
          ],
        ),
      ),
    );
  }
}
