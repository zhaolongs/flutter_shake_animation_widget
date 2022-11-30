import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

//静态路由配置///代码清单2-27-1 可托动的悬浮按钮
///代码路径 lib/code2/draggable_floating_action_button.dart
class DraggableFloatingActionButton extends StatefulWidget {
  final Widget child;
  final Offset initialOffset;
  final VoidCallback onPressed;
  GlobalKey<State<StatefulWidget>> parentKey;
  DraggableFloatingActionButton({
    required this.child,
    required this.initialOffset,
    required this.onPressed,
    required this.parentKey,
  });

  @override
  State<StatefulWidget> createState() => _DraggableFloatingActionButtonState();
}

class _DraggableFloatingActionButtonState
    extends State<DraggableFloatingActionButton> {
  //托动按钮使用的Key
  final GlobalKey _key = GlobalKey();
  bool _isDragging = false;
  late Offset _offset;
  late Offset _minOffset;
  late Offset _maxOffset;

  @override
  void initState() {
    super.initState();
    //托动按钮的初始位置
    _offset = widget.initialOffset;
    //添加视图监听
    WidgetsBinding.instance?.addPostFrameCallback(_initBoundary);
  }
  //页面第一帧绘制完成后调用
  void _initBoundary(_) {
    //获取获取组件的 RenderBox
    final RenderBox parentRenderBox =
        widget.parentKey.currentContext?.findRenderObject() as RenderBox;
    //获取托动按钮组件的 RenderBox
    final RenderBox renderBox =
        _key.currentContext?.findRenderObject() as RenderBox;

    try {
      //分别获取两者的大小 从而计算边界
      final Size parentSize = parentRenderBox.size;
      final Size size = renderBox.size;
      setState(() {
        _minOffset = const Offset(0, 0);
        _maxOffset = Offset(
            parentSize.width - size.width, parentSize.height - size.height);
      });
    } catch (e) {
      print('catch: $e');
    }
  }
  ///代码清单2-27-3 计算按钮位置
  void _updatePosition(PointerMoveEvent pointerMoveEvent) {
    double newOffsetX = _offset.dx + pointerMoveEvent.delta.dx;
    double newOffsetY = _offset.dy + pointerMoveEvent.delta.dy;

    if (newOffsetX < _minOffset.dx) {
      newOffsetX = _minOffset.dx;
    } else if (newOffsetX > _maxOffset.dx) {
      newOffsetX = _maxOffset.dx;
    }

    if (newOffsetY < _minOffset.dy) {
      newOffsetY = _minOffset.dy;
    } else if (newOffsetY > _maxOffset.dy) {
      newOffsetY = _maxOffset.dy;
    }

    setState(() {
      _offset = Offset(newOffsetX, newOffsetY);
    });
  }
  ///代码清单2-27-2 可托动的悬浮按钮
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _offset.dx,
      top: _offset.dy,
      child: Listener(
        onPointerMove: (PointerMoveEvent pointerMoveEvent) {
          //更新位置
          _updatePosition(pointerMoveEvent);
          setState(() {
            _isDragging = true;
          });
        },
        onPointerUp: (PointerUpEvent pointerUpEvent) {
          print('onPointerUp');
          if (_isDragging) {
            setState(() {
              _isDragging = false;
            });
          } else {
            widget.onPressed();
          }
        },
        child: Container(
          key: _key,
          child: widget.child,
        ),
      ),
    );
  }
}
