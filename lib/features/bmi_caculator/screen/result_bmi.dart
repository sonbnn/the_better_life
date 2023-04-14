import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_better_life/configs/constants/constant_bmi.dart';
import 'package:the_better_life/configs/constants/constant_size.dart';
import 'package:the_better_life/configs/constants/constants.dart';
import 'package:the_better_life/features/bmi_caculator/model/history_bmi.dart';
import 'package:the_better_life/features/drink_water/providers/user/user_provider.dart';
import 'package:the_better_life/utils/loading_process_builder.dart';
import 'package:the_better_life/utils/snackbar_builder.dart';
import 'package:the_better_life/widgets/buttons/button_shadow_out.dart';
import 'package:the_better_life/widgets/common/base_appbar.dart';
import 'package:the_better_life/widgets/container/container_shadow_common.dart';

class BMIResultScreen extends StatefulWidget {
  const BMIResultScreen({Key? key}) : super(key: key);

  @override
  State<BMIResultScreen> createState() => _BMIResultScreenState();
}

class _BMIResultScreenState extends State<BMIResultScreen> {
  late TextTheme textTheme;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: BaseAppBar(title: 'TXT_RESULT_BMI'.tr()),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: ConstantSize.spaceMargin),
        child: Consumer<UserProvider>(
          builder: (context, provider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ConstantSize.isSmallScreen
                    ? const SizedBox()
                    : const Expanded(child: CommonImage(url: "assets/images/img_bmi.png")),
                Text(
                  '${'TXT_YOUR_BMI_IS'.tr()} ${'${provider.bmiResult[ConstantBMI.getIndex(provider.bmi)]['title']}'.tr().toLowerCase()}',
                  style: textTheme.headline6,
                ),
                TweenAnimationBuilder(
                    duration: const Duration(seconds: 1),
                    tween: Tween<double>(begin: 0.0, end: provider.bmi),
                    builder: (context, double bmiTXT, child) {
                      return Text(
                        bmiTXT.toStringAsFixed(2),
                        style: textTheme.headline3?.copyWith(fontSize: 60, fontWeight: FontWeight.w900),
                      );
                    }),
                Text(
                  ConstantBMI.getInterpretation(provider.bmi),
                  style: textTheme.bodyText1,
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
                    itemCount: provider.bmiResult.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return _itemBMI(
                        colorIc: Color(int.parse(provider.bmiResult[index]['color'])),
                        title: provider.bmiResult[index]['title'],
                        numeral: provider.bmiResult[index]['numeral'],
                        index: index,
                        bmi: provider.bmi,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                SafeArea(
                  child: ButtonShadowOuter(
                    action: () {
                      LoadingProcessBuilder.showProgressDialog();
                      provider.saveBMI(
                        BMIHistory(
                          result: provider.bmi.toStringAsFixed(2),
                          txtResult: '${provider.bmiResult[ConstantBMI.getIndex(provider.bmi)]['title']}',
                          time: DateFormat(Constants.formatDate).format(DateTime.now()),
                        ),
                      );
                      Future.delayed(const Duration(milliseconds: 500), () {
                        LoadingProcessBuilder.closeProgressDialog();
                        SnackBarBuilder.showSnackBar(content: "TXT_SAVE_SUCCESS".tr(), status: true);
                      });
                    },
                    child: Text('TXT_SAVE'.tr(), style: textTheme.button),
                  ),
                ),
              ],
            );
          },
        ),
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
        color: ConstantBMI.getIndex(bmi) == index ? colorIc.withOpacity(0.2) : null,
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
}
