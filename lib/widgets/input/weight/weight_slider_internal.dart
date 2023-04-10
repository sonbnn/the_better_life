import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WeightSliderInternal extends StatefulWidget {
  final int minValue;
  final int maxValue;
  final int value;
  final String unit;
  final ValueChanged<int> onChange;
  final double width;

  const WeightSliderInternal({
    Key? key,
    required this.minValue,
    required this.maxValue,
    required this.value,
    required this.unit,
    required this.onChange,
    required this.width,
  }) : super(key: key);

  @override
  State<WeightSliderInternal> createState() => _WeightSliderInternalState();
}

class _WeightSliderInternalState extends State<WeightSliderInternal> {
  double get itemExtent => widget.width / 3;
  late ThemeData theme;

  int _indexToValue(int index) => widget.minValue + (index - 1);
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(
      initialScrollOffset: (widget.value - widget.minValue) * widget.width / 3,
    );
  }
  @override
  build(BuildContext context) {
    int itemCount = (widget.maxValue - widget.minValue) + 3;
    theme = Theme.of(context);
    return NotificationListener(
      onNotification: _onNotification,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemExtent: itemExtent,
        itemCount: itemCount,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          int itemValue = _indexToValue(index);
          bool isExtra = index == 0 || index == itemCount - 1;
          return isExtra
              ? Container()
              : GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => _animateTo(itemValue, durationMillis: 50),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      itemValue != widget.value ? itemValue.toString() : itemValue.toString() + widget.unit,
                      style: _getTextStyle(context, itemValue),
                    ),
                  ),
                );
        },
      ),
    );
  }

  TextStyle? _getDefaultTextStyle() {
    return theme.textTheme.bodyText2?.copyWith(color: theme.disabledColor);
  }

  TextStyle? _getHighlightTextStyle(BuildContext context) {
    return theme.textTheme.headline3?.copyWith(color: theme.primaryColor);
  }

  TextStyle? _getTextStyle(BuildContext context, int itemValue) {
    return itemValue == widget.value ? _getHighlightTextStyle(context) : _getDefaultTextStyle();
  }

  bool _userStoppedScrolling(Notification notification) {
    return notification is UserScrollNotification &&
        notification.direction == ScrollDirection.idle &&
        scrollController.position.activity is! HoldScrollActivity;
  }

  _animateTo(int valueToSelect, {int durationMillis = 200}) {
    double targetExtent = (valueToSelect - widget.minValue) * itemExtent;
    scrollController.animateTo(
      targetExtent,
      duration: Duration(milliseconds: durationMillis),
      curve: Curves.decelerate,
    );
  }

  int _offsetToMiddleIndex(double offset) => (offset + widget.width / 2) ~/ itemExtent;

  int _offsetToMiddleValue(double offset) {
    int indexOfMiddleElement = _offsetToMiddleIndex(offset);
    int middleValue = _indexToValue(indexOfMiddleElement);
    middleValue = math.max(widget.minValue, math.min(widget.maxValue, middleValue));

    return middleValue;
  }

  bool _onNotification(Notification notification) {
    if (notification is ScrollNotification) {
      int middleValue = _offsetToMiddleValue(notification.metrics.pixels);
      if (_userStoppedScrolling(notification)) {
        _animateTo(middleValue);
      }

      if (middleValue != widget.value) {
        widget.onChange(middleValue);
      }
    }

    return true;
  }
}
