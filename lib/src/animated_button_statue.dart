
import 'package:flutter/material.dart';

///5.8 lib/demo/animated_button_statue.dart
///切换样式的按钮
class AnimatedStatusButton extends StatefulWidget {
  ///按钮的宽度与高度
  final double height;
  final double width;

  ///按钮控制器
  final AnimatedStatusController animatedStatusController;
  ///按钮上的文字
  final String buttonText;
  ///按下时的背景颜色
  final Color backgroundSelectColor;

  ///默认时显示的颜色
  final Color borderNormalColor;
  final Color backgroundNormalColor;
  ///按下的背景高亮颜色
  final Color backgroundHightColor;
  ///按下的文字的高亮颜色
  final Color textHightCcolor;
  ///默认普通状态下的文字颜色
  final Color textNormalCcolor;
  ///选中状态下的边框颜色
  final Color borderSelectColor;
  ///按钮点击事件回调
  final Function clickCallback;
  ///动画交互时间
  final int milliseconds;
  ///圆角大小
  final double borderRaidus;
  ///为true时 触发点击事件后 会更新状态为
  ///选择状态
  final bool isUseSelect ;

  AnimatedStatusButton({
    Key key,
    this.height = 44.0,
    this.width = 200.0,
    this.borderRaidus = 22.0,
    this.buttonText,
    this.textNormalCcolor = Colors.white,
    this.borderNormalColor = Colors.deepOrange,
    this.backgroundNormalColor = Colors.deepOrange,
    this.backgroundSelectColor = const Color(0xffff62b2),
    this.borderSelectColor = const Color(0xffff62b2),
    this.backgroundHightColor = Colors.grey,
    this.textHightCcolor = Colors.white,
    this.milliseconds = 1000,
    this.isUseSelect = true,
    this.animatedStatusController,
    this.clickCallback,
  }):super(key:key);

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

///5.8lib/demo/animated_button_statue.dart
class _AnimatedButtonState extends State<AnimatedStatusButton>
    with TickerProviderStateMixin {
  ///属性配制值转接
  ///按钮上的文本的颜色
  Color textColor;

  ///按钮背景的颜色
  Color containerColor;

  ///按钮背景边框的颜色
  Color borderColor;

  ///按钮的高度
  double containerHeight = 0;
  double containerWidth = 0;

  ///按钮的背景圆角
  double borderRaidus;

  ///用来设置小圆圈的大小
  ///所以这里设置的与 [containerHeight]相同
  double minWidth = 0.0;

  bool isSelect = false;
  ///动画过渡时间
  int milliseconds;
  ///小圆圈使用到的透明度过渡
  double opacity;

  ///配置默认的样式
  @override
  void initState() {
    super.initState();

    ///初始化样式选择
    controlNormal();

    ///添加按钮控制器
    if (widget.animatedStatusController != null) {
      widget.animatedStatusController.setStatusListener((isClose) {
        if (isClose) {
          ///恢复正常
          isSelect = false;
          controlNormal();
        } else {
          ///恢复选择状态
          isSelect = true;
          controlSelect();
        }
        setState(() {

        });
      });
    }
  }
  ///5.8lib/demo/animated_button_statue.dart
  ///按下的高亮
  void controlHight() {
    ///动画过渡时间
    milliseconds = widget.milliseconds~/6;
    ///背景
    containerColor = widget.backgroundHightColor;
    ///文字
    textColor =widget.textHightCcolor;
    ///边框
    borderColor = containerColor;
  }

  ///默认未选中的样式
  void controlNormal() {
    ///动画过渡时间
    milliseconds = widget.milliseconds;
    ///小圆圈的透明度
    opacity = 0.0;
    ///文字的默认颜色
    textColor = widget.textNormalCcolor;
    ///背景的默认颜色
    containerColor = widget.backgroundNormalColor;
    ///边框的默认颜色
    borderColor = widget.borderNormalColor;
    ///高度没变化 默认的高度
    containerHeight = widget.height;
    ///小圆角显示为正圆 所以宽与高一至
    minWidth = widget.height;
    ///显示圆角边框时圆角大小
    borderRaidus = widget.borderRaidus;
    ///按钮默认的宽度
    containerWidth = widget.width;
  }

  ///选中的样式
  void controlSelect() {
    ///延时修改小圆圈的透明度
    ///以达到延时显示小圆圈的效果
    Future.delayed(Duration(milliseconds: (milliseconds * 0.6).toInt()), () {
      setState(() {
        opacity = 1.0;
      });
    });
    ///选中的边框颜色
    borderColor = widget.borderSelectColor;
    ///选中状态下文字为透明
    textColor = Colors.transparent;
    ///选中的背景颜色
    containerColor = widget.backgroundSelectColor;
    ///高度没变化
    containerHeight = widget.height;
    ///边框的大小与小圆圈的大小一至
    containerWidth = minWidth;
    ///显示小圆圈时圆角半径为圆圈的半径
    borderRaidus = minWidth / 2;
  }

  ///5.8lib/demo/animated_button_statue.dart
  @override
  Widget build(BuildContext context) {
    return Material(
      ///手势事件监听
      child: InkWell(
          ///手指抬起时的回调
          onTap: onClickTap,
          ///手指按下时的回调
          onTapDown: onClickDown,
          ///监听事件的区域圆角配置
          borderRadius: BorderRadius.circular(borderRaidus),
          ///按钮显示的内容主体
          child: buildContainer()),
    );
  }
  ///5.8lib/demo/animated_button_statue.dart
  ///按下的回调
  void onClickDown(TapDownDetails details) {
    ///按下时 显示高度样式
    ///只有非选中状态下才使用高亮样式
    ///如果是选中状态下 显示的是小圆圈不需要高亮
    if(!isSelect){
      setState(() {
        ///切换高亮显示
        controlHight();
      });
    }
  }
  ///5.8lib/demo/animated_button_statue.dart
  ///点击事件处理
  ///只有[isSelect]为false非选中状态才会触发
  ///[widget.isUseSelect]
  ///     默认为true 更新状态也触发回调
  ///     为false时 只触发回调不更新状态
  void onClickTap() async {
    if (!isSelect) {
      if (widget.isUseSelect) {
        ///更新状态
        isSelect = !isSelect;
        controlSelect();
        ///同时触发回调
        if (widget.clickCallback != null) {
          bool isClose = await widget.clickCallback();
          if (isClose) {
            isSelect = !isSelect;
            controlNormal();
          }
        }
        setState(() {});
      } else {
        ///只触发回调
        if (widget.clickCallback != null) {
          widget.clickCallback();
        }
        setState(() {
          controlNormal();
        });
      }
    }
  }

  ///5.8lib/demo/animated_button_statue.dart
  ///按钮显示的内容主体
  Widget buildContainer() {
    ///动画容器
    return AnimatedContainer(
      height: containerHeight,
      width: containerWidth,
      ///过渡时间
      duration: Duration(milliseconds: milliseconds),
      ///背景样式
      decoration: BoxDecoration(
        ///圆角
        borderRadius: BorderRadius.circular(borderRaidus),
        ///边框
        border: Border.all(color: borderColor, width: 2.0),
        ///背景颜色
        color: containerColor,
      ),

      child: Container(
        ///层叠布局
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ///文本容器
            buildTextWidget(),
            ///进度小圆圈
            buildProgressWidget(),
          ],
        ),
      ),
    );
  }

  ///5.8lib/demo/animated_button_statue.dart
  ///文本本容器
  Widget buildTextWidget() {
    ///文本动画样式
    return AnimatedDefaultTextStyle(
      child: Text(widget.buttonText),
      duration: Duration(milliseconds: milliseconds ~/ 3),
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
      ),
      curve: Curves.linear,
    );
  }
  ///5.8lib/demo/animated_button_statue.dart
  ///构建进度小圆圈
  buildProgressWidget() {
    return Center(
      ///透明度动画过渡
      child: AnimatedOpacity(
        ///透明度
        opacity: opacity,
        ///时间
        duration:
            Duration(milliseconds: (milliseconds *0.2).toInt()),
        child: Padding(
            padding: EdgeInsets.all(minWidth / 8),
            ///小圆圈
            child: CircularProgressIndicator(
              ///小圆圈的背景颜色
              backgroundColor: Colors.white,
              ///小圆圈的前景颜色
              valueColor: AlwaysStoppedAnimation(Colors.blue),
            )),
      ),
    );
  }
}

///5.8lib/demo/animated_button_statue.dart
///按钮状态监听
typedef AnimatedStatusButtonListener = void Function(bool isClose);

///控制器
class AnimatedStatusController {
  AnimatedStatusButtonListener _animatedStatusButtonListener;

  ///控制器中添加监听
  setStatusListener(AnimatedStatusButtonListener listener) {
    _animatedStatusButtonListener = listener;
  }

  ///选择
  void select() {
    if (_animatedStatusButtonListener != null) {
      _animatedStatusButtonListener(false);
    }
  }

  ///关闭
  void close() {
    if (_animatedStatusButtonListener != null) {
      _animatedStatusButtonListener(true);
    }
  }
}
