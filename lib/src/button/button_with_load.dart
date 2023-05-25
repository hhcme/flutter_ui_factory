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
      this.backgroundColor = const Color(0xFFFFC0CB),
      this.overlayColor = const Color(0x25778899),
      this.fontColor = Colors.white,
      this.radius = 30,
      this.fontSize = 60});

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
  final Color fontColor;

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
    return ConstrainedBox(
      constraints: BoxConstraints(
          minWidth: widget.width != null ? screenUtil.adaptive(widget.width!) : double.infinity,
          minHeight: screenUtil.adaptive(widget.height ?? 160)),
      // width: ,
      child: IntrinsicHeight(
        child: TextButton(
            onPressed: () async {
              if (isLoading) {
                return;
              }
              setState(() {
                isLoading = true;
              });
              await widget.func();
              setState(() {
                isLoading = false;
              });
            },
            style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenUtil.adaptive(widget.radius)))),
                backgroundColor: MaterialStateProperty.all(widget.backgroundColor),
                overlayColor: MaterialStateProperty.all(widget.overlayColor),
                iconColor: MaterialStateProperty.all(widget.fontColor)),
            child: Visibility(
                visible: isLoading,
                child: CircularProgressIndicator(color: widget.fontColor),
                replacement: Text(widget.title, style: TextStyle(color: widget.fontColor, fontSize: screenUtil.adaptive(widget.fontSize))))),
      ),
    );
  }
}
