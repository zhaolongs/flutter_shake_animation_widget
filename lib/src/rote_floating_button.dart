import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/11/7.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
/// https://www.toutiao.com/c/user/token/MS4wLjABAAAAYMrKikomuQJ4d-cPaeBqtAK2cQY697Pv9xIyyDhtwIM/
////旋转变换按钮 向上弹出的效果
class RoteFloatingButton extends StatefulWidget {
  //菜单按钮选项
  final List<Icon> iconList;

  //按钮的点击事件
  final Function(int index) clickCallback;

  RoteFloatingButton({this.iconList, this.clickCallback});

  @override
  _RoteButtonPageState createState() => _RoteButtonPageState();
}

////旋转变换按钮 向上弹出的效果 State实现
class _RoteButtonPageState extends State<RoteFloatingButton> with SingleTickerProviderStateMixin {
  //记录是否打开
  bool isOpened = false;

  //动画控制器
  AnimationController _animationController;

  //颜色变化取值
  Animation<Color> _animateColor;

  //图标变化取值
  Animation<double> _animateIcon;

  //按钮的位置动画
  Animation<double> _translateButton;

  //动画执行速率
  Curve _curve = Curves.easeOut;

  double _fabHeight = 56.0;

  @override
  initState() {
    super.initState();
    //初始化动画控制器
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    //添加动画监听
    _animationController.addListener(() {
      setState(() {});
    });
    //Tween结合_animationController，使300毫秒内执行一个从0.0到0.1的变换过程
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    //结合_animationController 实现一个从Colors.blue到Colors.deepPurple的动画过渡
    _animateColor = ColorTween(
      begin: Colors.blue,
      end: Colors.deepPurple,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: _curve,
      ),
    ));

    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    //构建子菜单
    List<Widget> itemList = [];
    for (int i = 0; i < widget.iconList.length; i++) {
      //通过Transform来促成FloatingActionButton的平移
      itemList.add(
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * (widget.iconList.length - i),
            0.0,
          ),
          child: FloatingActionButton(
            heroTag: "$i",
            onPressed: () {
              //点击菜单子选项要求菜单弹缩回去
              floatClick();
              if (widget.clickCallback != null) {
                widget.clickCallback(i);
              }
            },
            child: widget.iconList[i],
          ),
        ),
      );
    }
    //添加菜单按钮
    itemList.add(floatButton());

    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: itemList);
  }

  //构建固定旋转菜单按钮
  Widget floatButton() {
    return new Container(
      child: FloatingActionButton(
        //通过_animateColor实现背景颜色的过渡
        backgroundColor: _animateColor.value,
        onPressed: floatClick,
        //通过AnimatedIcon实现标签的过渡
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ),
      ),
    );
  }

  //FloatingActionButton的点击事件，用来控制按钮的动画变换
  floatClick() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  //页面销毁时，销毁动画控制器
  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }
}