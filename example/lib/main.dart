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
  runApp(MaterialApp(
    home: Exam222HomePage(),
  ));
}

///代码路径 lib/code2/code219_Button.dart
class Exam222HomePage extends StatefulWidget {
  const Exam222HomePage({Key? key}) : super(key: key);

  @override
  State<Exam222HomePage> createState() => _Exam220HomePageState();
}

//lib/code/main_data.dart
class _Exam220HomePageState extends State<Exam222HomePage> {
  //定义菜单按钮选项
  List<Icon> iconList = [
    Icon(Icons.add),
    Icon(Icons.save),
    Icon(Icons.share),
  ];

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
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: 40),

                    ///通用组件的抖动
                    buildShakeAnimationWidget(),
                    SizedBox(height: 100),

                    ///文字的抖动
                    buildTextAnimationWidget(),
                    SizedBox(height: 140),
                    buildAnimatedStatusButton(),
                    SizedBox(height: 140),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) {
                            return Example309();
                          }));
                        },
                        child: Text("开源中图底部菜单")),

          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) {
                      return Exam223HomePage();
                    }));
              },
              child: Text("可托动的悬浮按钮")),


                  ],
                ),
                //向上弹出的按钮组件
                Positioned(
                  child: buildRoteFloatingButton(),
                  right: 10,
                  bottom: 20,
                ),
              ],
            )),
      ),
    );
  }

  ///向上弹出的按钮组件
  RoteFloatingButton buildRoteFloatingButton() {
    return RoteFloatingButton(
      //子菜单按钮选项
      iconList: iconList,
      iconSize: 56,

      ///子菜单按钮的点击事件回调
      clickCallback: (int index) {
        print("点击了按钮$index");
      },
    );
  }

  ///代码清单2-25-2 抖动的文本
  buildTextAnimationWidget() {
    return ShakeTextAnimationWidget(
      //需要设置抖动效果的文本
      animationString: "这里是文字的抖动",
      space: 1.0,
      //字符间距
      runSpace: 10,
      //行间距
      //文字的样式
      textStyle: const TextStyle(
        ///文字的大小
        fontSize: 25,
      ),
      //抖动次数
      shakeCount: 0,
    );
  }

  ///代码清单2-25-1 抖动组件
  ///抖动动画控制器
  final ShakeAnimationController _shakeAnimationController =
      ShakeAnimationController();

  ///构建抖动效果
  ShakeAnimationWidget buildShakeAnimationWidget() {
    return ShakeAnimationWidget(
      //抖动控制器
      shakeAnimationController: _shakeAnimationController,
      //微旋转的抖动
      shakeAnimationType: ShakeAnimationType.SkewShake,
      //设置不开启抖动
      isForward: false,
      //默认为 0 无限执行
      shakeCount: 0,
      //抖动的幅度 取值范围为[0,1]
      shakeRange: 0.2,
      //执行抖动动画的子Widget
      child: OutlinedButton(
        child: const Text(
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

  Widget buildProgressButton() {
    return //切换样式的动画按钮
        AnimatedButton(
      width: 120.0,
      height: 40,
      buttonText: '动画样式按钮',
      clickCallback: () {
        print("点击事件回调");
      },
    );
  }

  ///代码清单2-25-3 抖动的文本
  //动画按钮使用到的控制器
  AnimatedStatusController animatedStatusController =
      AnimatedStatusController();

  //切换样式的动画按钮
  Widget buildAnimatedStatusButton() {
    return AnimatedStatusButton(
      animatedStatusController: animatedStatusController,
      //控制器
      width: 220.0,
      //显示按钮的宽度
      height: 40,
      //显示按钮的高度
      milliseconds: 1000,
      //动画交互时间
      buttonText: '提交',
      backgroundNormalColor: Colors.white,
      //背景颜色
      borderNormalColor: Colors.deepOrange,
      //边框颜色
      textNormalCcolor: Colors.deepOrange,
      //文字颜色
      //点击回调
      clickCallback: () async {
        print("点击事件回调");
        //模拟耗时操作
        await Future.delayed(Duration(milliseconds: 4000));
        //返回false 会一直在转圈圈
        //返回true 会回到默认显示样式
        return Future.value(false);
      },
    );
  }
}

//防开源中国自定义底部菜单
class Example309 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExampleState();
  }
}

///代码清单2-25-4 底部弹出的圆形导航栏菜单
class _ExampleState extends State<Example309> {
  ///构建菜单所使用到的图标
  List<Icon> iconList = [
    Icon(Icons.android, color: Colors.blue, size: 18),
    Icon(Icons.image, color: Colors.red, size: 18),
    Icon(Icons.find_in_page, color: Colors.orange, size: 18),
    Icon(Icons.add, color: Colors.lightGreenAccent, size: 28),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
        //文字标签流式布局
        child: BottomRoundFlowMenu(
          //图标使用的背景
          defaultBackgroundColor: Colors.white,
          //菜单所有的图标
          iconList: iconList,
          //对应菜单项点击事件回调
          clickCallBack: (int index) {
            print("点击了 $index");
          },
        ),
      ),
    );
  }
}





class Exam223HomePage extends StatefulWidget {
  const Exam223HomePage({Key? key}) : super(key: key);

  @override
  State<Exam223HomePage> createState() => _Exam223HomePageState();
}

///代码清单2-27 可托动的悬浮按钮

class _Exam223HomePageState extends State<Exam223HomePage> {
  //Stack使用的Key
  final GlobalKey _parentKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          key: _parentKey,
          children: [
            Container(color: Colors.blueGrey),

            DraggableFloatingActionButton(
              child: Container(
                width: 60,
                height: 60,
                decoration: const ShapeDecoration(
                  shape: CircleBorder(),
                  color: Colors.white,
                ),
                child: const Icon(Icons.add),
              ),
              initialOffset: const Offset(120, 70),
              parentKey: _parentKey,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}