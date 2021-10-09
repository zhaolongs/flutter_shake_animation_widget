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
                    ///通用组件的抖动
                    buildShakeAnimationWidget(),

                    ///文字的抖动
                    buildTextAnimationWidget(),
                  ],
                ),
                //向上弹出的按钮组件
                buildRoteFloatingButton(),
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
      ///子菜单按钮的点击事件回调
      clickCallback: (int index) {
        print("点击了按钮$index");
      },
    );
  }

  buildTextAnimationWidget() {
    return ShakeTextAnimationWidget(
      //需要设置抖动效果的文本
      animationString: "这里是文字的抖动",
      //字符间距
      space: 1.0,
      //行间距
      runSpace: 10,
      //文字的样式
      textStyle: TextStyle(
        ///文字的大小
        fontSize: 25,
      ),
      //抖动次数
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

  Widget buildProgressButton() {
    return //切换样式的动画按钮
      AnimatedButton(
        width: 120.0,
        height: 40,
        buttonText: '动画样式按钮',
        clickCallback: (){
          print("点击事件回调");
        },
      );
  }


  //动画按钮使用到的控制器
  AnimatedStatusController animatedStatusController =
  new AnimatedStatusController();

  //切换样式的动画按钮
  Widget buildAnimatedStatusButton() {
    return AnimatedStatusButton(
      //控制器
      animatedStatusController: animatedStatusController,
      //显示按钮的宽度
      width: 220.0,
      //显示按钮的高度
      height: 40,
      //动画交互时间
      milliseconds: 1000,
      buttonText: '提交',
      //背景颜色
      backgroundNormalColor: Colors.white,
      //边框颜色
      borderNormalColor: Colors.deepOrange,
      //文字颜色
      textNormalCcolor: Colors.deepOrange,
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

class _ExampleState extends State<Example309> {
  ///构建菜单所使用到的图标
  List<Icon> iconList = [
    Icon(
      Icons.android,
      color: Colors.blue,
      size: 18,
    ),
    Icon(
      Icons.image,
      color: Colors.red,
      size: 18,
    ),
    Icon(
      Icons.find_in_page,
      color: Colors.orange,
      size: 18,
    ),
    Icon(Icons.add, color: Colors.lightGreenAccent, size: 28),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("仿开源中国底部弹出菜单"),
      ),
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

///代码清单 3-20 垂直向上弹出的动画菜单
///lib/code/code3/example_310_tag_page.dart
class Example310 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Example310State();
  }
}

class _Example310State extends State<Example310> {
  ///构建菜单所使用到的图标
  List<Icon> iconList = [
    Icon(
      Icons.android,
      color: Colors.blue,
      size: 18,
    ),
    Icon(
      Icons.image,
      color: Colors.red,
      size: 18,
    ),
    Icon(
      Icons.find_in_page,
      color: Colors.orange,
      size: 18,
    ),
    Icon(Icons.add, color: Colors.lightGreenAccent, size: 28),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("垂直向上弹出菜单"),
      ),
      body: Container(
        //文字标签流式布局
        child: RoteFlowButtonMenu(
          //图标使用的背景
          defaultBackgroundColor: Colors.deepOrangeAccent,
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
