library weight_slider;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_better_life/widgets/container/container_shadow_common.dart';
import 'package:the_better_life/widgets/input/weight/weight_slider_internal.dart';

class WeightSlider extends StatelessWidget {
  final int weight;
  final int minWeight;
  final int maxWeight;
  final String unit;
  final double height;
  final ValueChanged<int> onChange;
  final String title;

  const WeightSlider({
    Key? key,
    this.weight = 80,
    this.minWeight = 30,
    this.maxWeight = 130,
    this.unit = 'kg',
    this.height = 110,
    required this.onChange,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ContainerShadowCommon(
          size: Size(double.infinity, height),
          radius: 24,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 4),
              Text(
                title,
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                width: double.infinity,
                height: height - 32,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return WeightSliderInternal(
                      minValue: minWeight,
                      maxValue: maxWeight,
                      value: weight,
                      unit: unit,
                      onChange: onChange,
                      width: constraints.maxWidth,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        SvgPicture.asset('assets/icons/ic_arrow_weight.svg', color: Theme.of(context).primaryColor),
      ],
    );
  }
}
