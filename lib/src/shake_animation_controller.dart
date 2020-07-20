import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/7/17.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572

///lib/demo/shake/shake_animation_controller.dart
///抖动监听
typedef ShakeAnimationListener = void Function(bool isOpen, int shakeCount);

///抖动动画控制器
class ShakeAnimationController {
  ///当前抖动动画的状态
  bool animationRunging = false;

  ///监听
  ShakeAnimationListener _shakeAnimationListener;

  ///控制器中添加监听
  setShakeListener(ShakeAnimationListener listener) {
    _shakeAnimationListener = listener;
  }

  ///打开
  void start({int shakeCount = 1}) {
    if (_shakeAnimationListener != null) {
      animationRunging = true;
      _shakeAnimationListener(true, shakeCount);
    }
  }

  ///关闭
  void stop() {
    if (_shakeAnimationListener != null) {
      animationRunging = false;
      _shakeAnimationListener(false, 0);
    }
  }

  ///移除监听
  void removeListener() {
    _shakeAnimationListener = null;
  }
}
