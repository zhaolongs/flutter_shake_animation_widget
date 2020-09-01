import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/7/21.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
///
main() {
  runApp(TestPage());
}

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

//lib/code/main_data.dart
class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("抖动动画"),
        ),
        backgroundColor: Colors.white,

        ///填充布局
        body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                ///通用组件的抖动
                buildShakeAnimationWidget(),

                ///文字的抖动
                buildTextAnimationWidget(),
              ],
            )),
      ),
    );
  }

  buildTextAnimationWidget() {
    return ShakeTextAnimationWidget(
      ///需要设置抖动效果的文本
      animationString: "这里是文字的抖动",

      ///字符间距
      space: 1.0,

      ///行间距
      runSpace: 10,

      ///文字的样式
      textStyle: TextStyle(
        ///文字的大小
        fontSize: 25,
      ),

      ///抖动次数
      shakeCount: 0,
    );
  }

  ///lib/code23/20main_data2332.dart
  ///抖动动画控制器
  ShakeAnimationController _shakeAnimationController =
      new ShakeAnimationController();

  ///构建抖动效果
  ShakeAnimationWidget buildShakeAnimationWidget() {
    return ShakeAnimationWidget(
      ///抖动控制器
      shakeAnimationController: _shakeAnimationController,

      ///微旋转的抖动
      shakeAnimationType: ShakeAnimationType.SkewShake,

      ///设置不开启抖动
      isForward: false,

      ///默认为 0 无限执行
      shakeCount: 0,

      ///抖动的幅度 取值范围为[0,1]
      shakeRange: 0.2,

      ///执行抖动动画的子Widget
      child: RaisedButton(
        child: Text(
          '测试',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          ///判断抖动动画是否正在执行
          if (_shakeAnimationController.animationRunging) {
            ///停止抖动动画
            _shakeAnimationController.stop();
          } else {
            ///开启抖动动画
            ///参数shakeCount 用来配置抖动次数
            ///通过 controller start 方法默认为 1
            _shakeAnimationController.start(shakeCount: 1);
          }
        },
      ),
    );
  }
}
