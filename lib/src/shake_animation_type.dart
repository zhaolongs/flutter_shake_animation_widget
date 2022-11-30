import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * 创建人： Created by zhaolong
 * 创建时间：Created by  on 2020/7/17.
 *
 * 可关注公众号：我的大前端生涯   获取最新技术分享
 * 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
 * 可关注博客：https://blog.csdn.net/zl18603543572
 */

///lib/demo/shake/shake_animation_type.dart
///抖动类型
///[ShakeAnimationType.LeftRightShake]左右抖动
///[ShakeAnimationType.TopBottomShake]上下抖动
///[ShakeAnimationType.SkewShake]斜角抖动
///[ShakeAnimationType.RoateShake]旋转抖动
///[ShakeAnimationType.RandomShake]随机抖动
enum ShakeAnimationType {
  LeftRightShake,
  TopBottomShake,
  SkewShake,
  RoateShake,
  RandomShake,
}
