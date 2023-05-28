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
      this.width = 200,
      this.height = 100,
      this.backgroundColor = const Color(0xFFFFC0CB),
      this.overlayColor = const Color(0xAAFFC0CB),
      this.fontColor = Colors.white,
      this.radius = 20,
      this.fontSize = 50});

  /// 固有标题
  final String title;

  /// 异步方法
  final FutureFunc func;

  /// 宽
  final double width;

  /// 高
  final double height;

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
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (_isLoading) {
          return;
        }
        setState(() {
          _isLoading = true;
        });
        await widget.func();
        setState(() {
          _isLoading = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: screenUtil.adaptive(widget.width),
        height: screenUtil.adaptive(widget.height),
        padding: EdgeInsets.only(left: screenUtil.adaptive(15), right: screenUtil.adaptive(15)),
        decoration: BoxDecoration(
          color: _isLoading ? widget.overlayColor : widget.backgroundColor,
          borderRadius: BorderRadius.circular(screenUtil.adaptive(widget.radius)),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _isLoading ? 1 : 0,
                child: SizedBox(
                  width: screenUtil.adaptive((widget.height) * 0.6),
                  height: screenUtil.adaptive((widget.height) * 0.6),
                  child: CircularProgressIndicator(color: widget.fontColor, strokeWidth: screenUtil.adaptive(10)),
                )),
            Center(
              child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: _isLoading ? 0 : 1,
                  child: Text(widget.title, style: TextStyle(color: widget.fontColor, fontSize: screenUtil.adaptive(widget.fontSize)))),
            ),
          ],
        ),
      ),
    );
  }
}
