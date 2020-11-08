import 'package:flutter/material.dart';

///lib/demo/animated_button.dart
///切换样式的按钮
class AnimatedButton extends StatefulWidget {
  ///按钮的宽度与高度
  final double height;
  final double width;
  ///圆角的大小
  final double borderRaidus;

  ///按钮上显示的颜色
  final String buttonText;

  ///按下时的颜色
  final Color borderSelectColor;
  final Color backgroundSelectColor;
  final Color textSelectCcolor;

  ///默认时显示的颜色
  final Color borderNormalColor;
  final Color backgroundNormalColor;
  final Color textNormalCcolor;

  ///按钮点击事件回调
  final Function clickCallback;

  AnimatedButton({
    this.height,
    this.width,
    this.buttonText,
    this.textNormalCcolor = const Color(0xffff62b2),
    this.borderNormalColor = const Color(0xffff62b2),
    this.backgroundNormalColor = Colors.white,
    this.textSelectCcolor = Colors.white,
    this.borderSelectColor = const Color(0xffff62b2),
    this.backgroundSelectColor = const Color(0xffff62b2),
    this.borderRaidus = 5.0,
    this.clickCallback,
  });

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}


///lib/demo/animated_button.dart
class _AnimatedButtonState extends State<AnimatedButton> {
  ///属性配制值转接
  ///按钮上的文本的颜色
  Color textColor;
  ///按钮背景的颜色
  Color containerColor;
  ///按钮背景边框的颜色
  Color borderColor;
  ///按钮的高度
  double containerHeight = 0;
  ///按钮的背景圆角
  double borderRaidus;

  ///配置默认的样式
  @override
  void initState() {
    super.initState();
    controlNormal();
  }

  ///默认未选中的样式
  void controlNormal() {
    textColor = widget.textNormalCcolor;
    containerColor = widget.backgroundNormalColor;
    borderColor = widget.borderNormalColor;
    containerHeight = 0;
    borderRaidus = widget.borderRaidus;
  }
  ///选中的样式
  void controlSelect() {
    textColor = widget.textSelectCcolor;
    containerColor = widget.backgroundSelectColor;
    borderColor = widget.borderSelectColor;
    containerHeight = widget.height;
  }
  ///lib/demo/animated_button.dart
  @override
  Widget build(BuildContext context) {
    return Material(
      ///配置圆角矩形边框
      shape: RoundedRectangleBorder(
        ///圆角配置
        borderRadius: BorderRadius.circular(borderRaidus),
        ///边框配置
        side: BorderSide(width: 3.0, color: borderColor),
      ),
      ///手势事件监听
      child: InkWell(
          ///手指按下的事件
          onTapDown: (TapDownDetails details) {
            setState(() {
              controlSelect();
            });
          },

          ///单击事件
          onTap: () {
            setState(() {
              controlNormal();
            });
          },

          ///双击事件
          onDoubleTap: () {
            setState(() {
              controlNormal();
            });
          },

          ///手指移出事件监听区域
          onTapCancel: () {
            setState(() {
              controlNormal();
            });
          },
          ///监听事件的区域圆角配置
          borderRadius: BorderRadius.circular(borderRaidus),
          ///按钮显示的内容主体
          child: buildContainer()),
    );
  }
  ///lib/demo/animated_button.dart
  ///按钮显示的内容主体
  Container buildContainer() {
    return Container(
      height: widget.height,
      width: widget.width,
      ///通过层叠布局将背景与文本叠在一起
      child: Stack(
        children: <Widget>[
          ///背景容器
          buildBackgroundWidget(),
          ///文本容器
          buildTextWidget()],
      ),
    );
  }
  ///lib/demo/animated_button.dart
  ///文本本容器
  Center buildTextWidget() {
    return Center(
      ///文本动画样式
      child: AnimatedDefaultTextStyle(
        child: Text(widget.buttonText),
        duration: Duration(milliseconds: 200),
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
        curve: Curves.easeIn,
      ),
    );
  }

  ///lib/demo/animated_button.dart
  ///背景容器
  Center buildBackgroundWidget() {
    return Center(
      ///动画容器
      child: AnimatedContainer(
        ///每当高度有变化时 会在 400 毫秒内
        ///逐渐过渡
        height: containerHeight,
        ///背景样式
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRaidus),
          ///每当颜色有变化时 会在 400 毫秒内
          ///逐渐过渡
          color: containerColor,
        ),
        ///过渡的时间配置
        duration: Duration(milliseconds: 400),
        ///动画过渡执行的动画插值器
        curve: Curves.ease,
      ),
    );
  }
}
