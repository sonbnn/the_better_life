import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_better_life/features/bmi_caculator/model/history_bmi.dart';
import 'package:the_better_life/features/drink_water/providers/user/user_provider.dart';
import 'package:the_better_life/widgets/common/base_appbar.dart';
import 'package:the_better_life/widgets/container/container_shadow_common.dart';

class BMIHistoryScreen extends StatefulWidget {
  const BMIHistoryScreen({Key? key}) : super(key: key);

  @override
  State<BMIHistoryScreen> createState() => _BMIHistoryScreenState();
}

late ThemeData theme;

class _BMIHistoryScreenState extends State<BMIHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Scaffold(
      appBar: BaseAppBar(
        title: "TXT_BMI_HISTORY".tr(),
      ),
      body: Consumer<UserProvider>(builder: (context, provider, child) {
        return provider.bmiHistory.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: provider.bmiHistory.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return _buildItem(
                    result: provider.bmiHistory[index].result ?? '',
                    time: provider.bmiHistory[index].time ?? '',
                    txtResult: provider.bmiHistory[index].txtResult ?? '',
                    index: index,
                  );
                },
              )
            : SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.sim_card_alert_outlined,
                      color: theme.disabledColor,
                      size: 100,
                    ),
                    Text(
                      'TXT_NULL_DATA_BMI_HISTORY'.tr(),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyText1,
                    ),
                  ],
                ),
              );
      }),
    );
  }

  Widget _buildItem({required String result, required String txtResult, required String time, required int index}) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0,left: 24, right: 24),
          child: ContainerShadowCommon(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(result, style: theme.textTheme.bodyText1),
                Text(txtResult.tr(), style: theme.textTheme.bodyText1),
                Text(time, style: theme.textTheme.bodyText1),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: (){
              Provider.of<UserProvider>(context, listen: false).deleteHistoryBMI(index);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 12),
              child: Icon(Icons.dangerous_rounded, color: theme.errorColor),
            ),
          ),
        ),
      ],
    );
  }
}
