import 'package:flutter/material.dart';
import 'package:flutter_frame_hyc/flutter_frame_hyc.dart';

/// 异步方法
typedef FutureFunc = Future<void> Function();

/// 带有加载功能的按钮
/// 适用于点击后存在异步方法的位置
class ButtonWithLoad extends StatefulWidget {
  const ButtonWithLoad(
      {super.key,
      required this.func,
      this.title = '按钮',
      this.width,
      this.height,
      this.backgroundColor = Colors.blue,
      this.overlayColor = Colors.lightBlueAccent,
      this.titleColor = Colors.white,
      this.radius = 20,
      this.fontSize = 40});

  /// 固有标题
  final String title;

  /// 异步方法
  final FutureFunc func;

  /// 宽
  final double? width;

  /// 高
  final double? height;

  /// 背景颜色
  final Color backgroundColor;

  /// 点击颜色
  final Color overlayColor;

  /// 标题颜色
  final Color titleColor;

  /// 按钮圆角
  final double radius;

  /// 按钮文字大小
  final double fontSize;

  @override
  State<ButtonWithLoad> createState() => _ButtonWithLoadState();
}

class _ButtonWithLoadState extends State<ButtonWithLoad> {
  /// 转圈状态
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextButton(
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          await widget.func();
          setState(() {
            isLoading = false;
          });
        },
        style: ButtonStyle(
          maximumSize: MaterialStateProperty.all(Size(widget.width??screenUtil.adaptive(100),widget.height??screenUtil.adaptive(100))),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    screenUtil.adaptive(widget.radius)))),
            overlayColor: MaterialStateProperty.all(widget.overlayColor),
            backgroundColor:
                MaterialStateProperty.all(widget.backgroundColor),
            iconColor: MaterialStateProperty.all(widget.titleColor)),
        child: isLoading
            ? Icon(Icons.refresh, size: screenUtil.adaptive(widget.fontSize*1.3))
            : Text(widget.title,
                style: TextStyle(
                    color: widget.titleColor,
                    fontSize: screenUtil.adaptive(widget.fontSize))),
      ),
    );
  }
}
