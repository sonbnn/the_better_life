import 'dart:convert';

import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:the_better_life/features/drink_water/providers/user/user_provider.dart';
import 'package:the_better_life/widgets/buttons/button_shadow_out.dart';
import 'package:the_better_life/widgets/container/container_shadow_common.dart';

class BMIResultScreen extends StatefulWidget {
  const BMIResultScreen({Key? key}) : super(key: key);

  @override
  State<BMIResultScreen> createState() => _BMIResultScreenState();
}

class _BMIResultScreenState extends State<BMIResultScreen> {
  List bmiResult = [];
  late TextTheme textTheme;

  @override
  void initState() {
    super.initState();
    initResult();
  }

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TXT_RESULT_BMI'.tr(),
          style: textTheme.headline3,
        ),
      ),
      body: Consumer<UserProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Expanded(child: CommonImage(url: "assets/images/img_bmi.png")),
                Text(
                  '${'TXT_YOUR_BMI_IS'.tr()} ${'${bmiResult[getIndex(provider.bmi)]['title']}'.tr().toLowerCase()}',
                  style: textTheme.headline5,
                ),
                Text(
                  provider.bmi.toStringAsFixed(2),
                  style: textTheme.headline1?.copyWith(fontSize: 60, fontWeight: FontWeight.w900),
                ),
                Text(
                  getInterpretation(provider.bmi),
                  style: textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: provider.user.gender, style: textTheme.bodyText1),
                        TextSpan(text: " | ", style: textTheme.bodyText1),
                        TextSpan(text: '${provider.user.age}', style: textTheme.bodyText1),
                        TextSpan(text: " | ", style: textTheme.bodyText1),
                        TextSpan(text: '${provider.user.weight?.toStringAsFixed(0)}kg', style: textTheme.bodyText1),
                        TextSpan(text: " | ", style: textTheme.bodyText1),
                        TextSpan(text: '${provider.user.height?.toStringAsFixed(0)}kg', style: textTheme.bodyText1),
                      ],
                    ),
                  ),
                ),
                ContainerShadowCommon(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: bmiResult.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      print(index);
                      return _itemBMI(
                          colorIc: Color(int.parse(bmiResult[index]['color'])),
                          title: bmiResult[index]['title'],
                          numeral: bmiResult[index]['numeral'],
                          index: index,
                          bmi: provider.bmi);
                    },
                  ),
                ),
                const SizedBox(height: 12),
                SafeArea(
                  child: ButtonShadowOuter(
                    action: () {
                      Navigator.pop(context);
                    },
                    child: Text('TXT_CONFIRM'.tr(), style: textTheme.button),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _itemBMI({
    required Color colorIc,
    required String title,
    required String numeral,
    required int index,
    required double bmi,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: getIndex(bmi) == index ? colorIc.withOpacity(0.2) : null,
      ),
      child: Row(
        children: [
          Icon(Icons.fiber_manual_record, color: colorIc),
          Expanded(child: Text(title.tr(), style: textTheme.bodyText1)),
          Text(numeral.tr(), style: textTheme.bodyText1),
        ],
      ),
    );
  }

  String getInterpretation(double bmi) {
    if (bmi >= 40) {
      return 'TXT_BMI_GRADE3'.tr();
    } else if (bmi >= 35.0 && bmi <= 39.9) {
      return 'TXT_BMI_GRADE2'.tr();
    } else if (bmi >= 30.0 && bmi <= 34.9) {
      return 'TXT_BMI_GRADE1'.tr();
    } else if (bmi >= 25.0 && bmi <= 29.9) {
      return 'TXT_BMI_OVERWEIGHT'.tr();
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      return 'TXT_BMI_NORMAL'.tr();
    } else if (bmi >= 17.0 && bmi <= 18.4) {
      return 'TXT_BMI_MILDLY_UNDERWEIGHT'.tr();
    } else if (bmi >= 16.0 && bmi <= 16.9) {
      return 'TXT_BMI_UNDERWEIGHT'.tr();
    } else {
      return "TXT_BMI_SEVERELY_UNDERWEIGHT".tr();
    }
  }

  int getIndex(double bmi) {
    if (bmi >= 40) {
      return 7;
    } else if (bmi >= 35.0 && bmi <= 39.9) {
      return 6;
    } else if (bmi >= 30.0 && bmi <= 34.9) {
      return 5;
    } else if (bmi >= 25.0 && bmi <= 29.9) {
      return 4;
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      return 3;
    } else if (bmi >= 17.0 && bmi <= 18.4) {
      return 2;
    } else if (bmi >= 16.0 && bmi <= 16.9) {
      return 1;
    } else {
      return 0;
    }
  }

  Future<void> initResult() async {
    final String response = await rootBundle.loadString('assets/jsons/bmi_result.json');
    final data = await json.decode(response);
    setState(() {
      bmiResult = data['bmi_result'];
    });
  }
}
