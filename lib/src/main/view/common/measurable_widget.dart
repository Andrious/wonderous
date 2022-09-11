import 'dart:async';

import 'package:flutter/rendering.dart';
// import 'package:wonders/common_libs.dart';
import 'package:wonders/src/view.dart';

class MeasurableWidget extends SingleChildRenderObjectWidget {
  const MeasurableWidget(
      {Key? key, required this.onChange, required Widget child})
      : super(key: key, child: child);
  final void Function(Size size) onChange;
  @override
  RenderObject createRenderObject(BuildContext context) =>
      MeasureSizeRenderObject(onChange);
}

class MeasureSizeRenderObject extends RenderProxyBox {
  MeasureSizeRenderObject(this.onChange);
  void Function(Size size) onChange;

  Size _prevSize = Size.zero;
  @override
  void performLayout() {
    super.performLayout();
    final Size newSize = child?.size ?? Size.zero;
    if (_prevSize == newSize) {
      return;
    }
    _prevSize = newSize;
    scheduleMicrotask(() => onChange(newSize));
  }
}
