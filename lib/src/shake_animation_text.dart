import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shake_animation_widget/src/shake_animation_type.dart';
import 'package:shake_animation_widget/src/shake_animation_widget.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/7/17.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
///
/// 抖动文本组件
class ShakeTextAnimationWidget extends StatefulWidget {
  ///需要添加动画的文本
  final String animationString;

  ///文本样式
  final TextStyle? textStyle;

  ///文字之间的间距
  final double space;

  ///文字的行间距
  final double runSpace;

  ///抖动次数
  final shakeCount;
  ShakeTextAnimationWidget(
      {required this.animationString,
      this.textStyle,
      this.space = 1,
      this.runSpace = 6,
      this.shakeCount = 0});

  @override
  _TextAnimationState createState() => _TextAnimationState();
}

/// lib/demo/shake/shake_animation_text.dart
class _TextAnimationState extends State<ShakeTextAnimationWidget> {
  ///用来保存形成抖动动画的每个文字
  List<Widget> textWidgetList = [];
  @override
  void initState() {
    super.initState();

    ///遍历String中的字符
    for (var i = 0; i < widget.animationString.length; i++) {
      ///拆分文字
      String itemStr = widget.animationString.substring(i, i + 1);

      ///创建抖动类型
      ShakeAnimationType shakeAnimationType = ShakeAnimationType.LeftRightShake;
      if (i % 3 == 0) {
        ///左右
        shakeAnimationType = ShakeAnimationType.LeftRightShake;
      } else if (i % 3 == 1) {
        ///上下
        shakeAnimationType = ShakeAnimationType.TopBottomShake;
      } else {
        ///微旋转
        shakeAnimationType = ShakeAnimationType.RoateShake;
      }
      if (itemStr.trim().length == 0) {
        ///如果当前截取的是空格 就不添加动画效果
        textWidgetList.add(
          Text(
            itemStr,
            style: widget.textStyle,
          ),
        );
      } else {
        ///构建动画
        ShakeAnimationWidget animationWidget = ShakeAnimationWidget(
          ///执行动画的子Widget
          ///这里只是一个字
          child: Text(
            itemStr,
            style: widget.textStyle,
          ),

          ///抖动次数限制
          shakeCount: widget.shakeCount,

          ///抖动动画的类型
          shakeAnimationType: shakeAnimationType,
        );
        textWidgetList.add(animationWidget);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ///使用流布局将所有的字组合到一起
    ///形成段落
    return Wrap(
      ///两个字之间的距离
      spacing: widget.space,

      ///每行之间的距离
      runSpacing: widget.runSpace,

      ///所有的字
      children: textWidgetList,
    );
  }
}
