import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/11/10.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///代码清单

///   流式布局 Flow 圆形菜单
class RoteFlowButtonMenu extends StatefulWidget {
  ///菜单图标
  final List<Icon> iconList;

  ///菜单图标背景
  final List<Color>? iconBackgroundColorList;

  ///所有菜单项默认使用的底色
  final Color defaultBackgroundColor;

  ///点击事件回调
  final Function(int index)? clickCallBack;

  ///是否输出Log
  final bool isLog;

  RoteFlowButtonMenu(
      {required this.iconList,
      this.clickCallBack,
      this.isLog = false,
      this.defaultBackgroundColor = Colors.deepOrange,
      this.iconBackgroundColorList});

  @override
  _MenuState createState() => _MenuState();
}

//lib/code10/main_data1019.dart
///   流式布局 Flow 圆形菜单 类似开源中国底部圆形菜单效果
class _MenuState extends State<RoteFlowButtonMenu>
    with SingleTickerProviderStateMixin {
  ///变化比率
  double _rad = 0.0;

  ///是否执行完动画，或者说是动画停止
  bool _closed = true;

  ///动画控制器
  late AnimationController _controller;

  ///用于控制变化速率
  late Animation<double> animation;

  ///用于保存显示出来的菜单效果Widget
  List<Widget> menuItemList = [];

  @override
  void initState() {
    super.initState();

    ///创建动画控制器
    ///执行时间为200毫秒
    _controller =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this)

          ///设置监听，每当动画执行时就会实时回调此方法
          ..addListener(() {
            setState(() {
              ///从0到1
              _rad = animation.value;
              print("$_rad ");
            });
          })

          ///设置状态监听
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              print("正向执行完毕 ");
              _closed = !_closed;
            } else if (status == AnimationStatus.dismissed) {
              print("反向执行完毕 ");
              _closed = !_closed;
            }
          });

    ///变化值从 0.0-1.0
    ///Curves.easeInOutExpo 中间快两头慢
    animation = Tween(begin: 0.0, end: 1.0).animate(

        ///先快后慢
        CurveTween(curve: Curves.easeOutQuint).animate(_controller));

    ///构建菜单具体显示的Widget
    menuItemList = buildMenuData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildBody2();
  }

  //lib/code10/main_data1019.dart
  /// 流式布局 Flow 圆形菜单
  ///构建菜单所使用到的图标
  List<Icon> iconList = [
    Icon(
      Icons.android,
      color: Colors.white,
      size: 18,
    ),
    Icon(
      Icons.image,
      color: Colors.white,
      size: 18,
    ),
    Icon(
      Icons.find_in_page,
      color: Colors.white,
      size: 18,
    ),
    Icon(Icons.add, color: Colors.white, size: 28),
  ];

  //lib/code10/main_data1019.dart
  /// Flow 流式布局 构建菜单数据Widget
  List<Widget> buildMenuData() {
    List<Widget> childWidthList = [];

    ///为每个Icon添加一个点击事件与圆形背景
    for (int i = 0; i < iconList.length; i++) {
      Color itemColor = widget.defaultBackgroundColor;
      if (widget.iconBackgroundColorList != null &&
          widget.iconBackgroundColorList!.length > i) {
        itemColor = widget.iconBackgroundColorList![i];
      }

      ///每个菜单添加InkWell点击事件
      Widget itemContainer = InkWell(
        onTap: () {
          if (widget.clickCallBack != null) {
            widget.clickCallBack!(i);
          }

          ///打开或者关闭菜单
          colseOrOpen();

          ///点击菜单其他的操作
        },
        child: new Container(
          ///圆形背景
          decoration: BoxDecoration(
              color: itemColor,
              borderRadius: BorderRadius.all(Radius.circular(23))),
          alignment: Alignment.center,
          height: 44,
          width: 44,
          child: iconList[i],
        ),
      );
      childWidthList.add(
        itemContainer,
      );
    }
    return childWidthList;
  }

  //lib/code10/main_data1019.dart
  ///页面的主体
  buildBody2() {
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          top: 0,
          child: Container(
            color: Color.fromARGB((_rad * 150).toInt(), 0, 0, 0),
          ),
        ),
        Flow(
          ///代理
          delegate: RoteFlowButtonMenuDelegate(radiusRate: _rad),

          ///使用到的子Widget
          children: menuItemList,
        )
      ],
    );
  }

  ///控制菜单的打开或者关闭
  void colseOrOpen() {
    if (_closed) {
      _controller.reset();
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }
}

//lib/code10/main_data1019.dart
///  流式布局 Flow 计算
class RoteFlowButtonMenuDelegate extends FlowDelegate {
  ///半径变化的比率
  ///一般从0到1 菜单展开
  ///从1-0菜单关闭
  double radiusRate;

  RoteFlowButtonMenuDelegate({this.radiusRate = 0});

  @override
  void paintChildren(FlowPaintingContext context) {
    calculWrapSpacingChild2(context);
  }

  //lib/code10/main_data1019.dart
  ///  流式布局 Flow 计算 菜单向上弹出
  void calculWrapSpacingChild2(FlowPaintingContext context) {
    ///初始绘制位置为Flow布局的左上角
    double x = 0.0;
    double y = 0.0;

    //获取当前画布的最小边长，width与height谁小取谁
    double radius = context.size.shortestSide / 3 * 2;

    ///获取当前Flow的大小
    double flowWidth = context.size.width;
    double flowHeight = context.size.height;

    ///左右两个菜单的偏移量
    double dxflag = radius / 3 * radiusRate;

    ///默认将所有的子Widget绘制到左下角
    x = radius;
    y = radius;

    //计算每一个子widget的位置
    for (var i = 0; i < context.childCount - 1; i++) {
      ///获取第i个子Widget的大小
      Size itemChildSize = context.getChildSize(i)!;

      ///子child开始绘制的y中心点
      double normalHeight = flowHeight - itemChildSize.height * 2;

      ///计算每个子Widget 的坐标
      x = flowWidth - itemChildSize.height * 1.5;
      y = normalHeight - dxflag * (i + 1) * 0.9;

      ///在Flow中进行绘制
      context.paintChild(i,
          transform: new Matrix4.translationValues(x, y, 0.0));
    }

    ///最后一个做为菜单选项
    int lastIndex = context.childCount - 1;
    Size lastChildSize = context.getChildSize(lastIndex)!;
    double lastx = (flowWidth - lastChildSize.height * 1.5);
    double lasty = flowHeight - lastChildSize.height * 2;

    ///绘制这个菜单在右下角并旋转
    context.paintChild(lastIndex,

        ///先平移到底部
        transform: Matrix4.translationValues(lastx, lasty, 0.0)

          ///然后将旋转中心平移到子Widget的中心
          ..translate(lastChildSize.width / 2, lastChildSize.height / 2)

          ///合并旋转操作
          ..multiply(Matrix4.rotationZ(radiusRate * 0.8)

            ///再将旋转中心平移回去
            ..translate(-lastChildSize.width / 2, -lastChildSize.height / 2)));
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }

  //  是否需要重新布局。
  @override
  bool shouldRelayout(FlowDelegate oldDelegate) {
    return true;
  }

  //设置Flow的尺寸
  @override
  Size getSize(BoxConstraints constraints) {
    //指定Flow的大小
    return super.getSize(constraints);
  }

  //  设置每个child的布局约束条件
  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return super.getConstraintsForChild(i, constraints);
  }
}
