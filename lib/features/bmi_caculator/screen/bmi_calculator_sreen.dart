import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_better_life/configs/constants/constant_size.dart';
import 'package:the_better_life/configs/router/routing_name.dart';
import 'package:the_better_life/features/drink_water/providers/user/user_provider.dart';
import 'package:the_better_life/utils/loading_process_builder.dart';
import 'package:the_better_life/widgets/buttons/button_shadow_out.dart';
import 'package:the_better_life/widgets/common/base_appbar.dart';
import 'package:the_better_life/widgets/input/box_plus_minus.dart';
import 'package:the_better_life/widgets/input/weight/weight_slider.dart';

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({Key? key}) : super(key: key);

  @override
  State<BMICalculatorScreen> createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  late ThemeData theme;
  late Size size;
  late double sizeBox;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false).getHistoryBMI();
    });
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    size = MediaQuery.of(context).size;
    sizeBox = (size.width / 2) - ConstantSize.spaceMargin - 6;
    return Scaffold(
      appBar: BaseAppBar(
        title: 'TXT_BMI_CALCULATOR'.tr(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RoutingNameConstants.BMIHistoryScreen);
            },
            icon: Icon(Icons.history, color: theme.primaryColor),
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 12),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: ConstantSize.spaceMargin),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildItemGender(
                          gender: 'TXT_MALE'.tr(),
                          urlIcon: 'assets/icons/ic_boy.svg',
                          provider: userProvider,
                        ),
                        _buildItemGender(
                          gender: 'TXT_FEMALE'.tr(),
                          urlIcon: 'assets/icons/ic_girl.svg',
                          provider: userProvider,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: ConstantSize.spaceMargin),
                    child: WeightSlider(
                      weight: (userProvider.user.weight != null ? userProvider.user.weight ?? 0 : 50).toInt(),
                      minWeight: 20,
                      maxWeight: 200,
                      onChange: (val) => userProvider.setWeight(val.toDouble()),
                      unit: 'kg',
                      title: 'TXT_YOUR_WEIGHT'.tr(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: ConstantSize.spaceMargin),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BoxPlusMinus(
                          actionPlus: () => userProvider.plusAge(1),
                          actionMinus: () => userProvider.plusAge(-1),
                          title: 'TXT_YOUR_AGE'.tr(),
                          value: '${userProvider.user.age?.toStringAsFixed(0)}',
                        ),
                        BoxPlusMinus(
                          actionPlus: () => userProvider.plusHeight(1),
                          actionMinus: () => userProvider.plusHeight(-1),
                          title: 'TXT_YOUR_HEIGHT'.tr(),
                          value: '${userProvider.user.height?.toStringAsFixed(0)}',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ButtonShadowOuter(
                    size: const Size(double.infinity, 56),
                    margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom + 80,
                      right: ConstantSize.spaceMargin,
                      left: ConstantSize.spaceMargin,
                    ),
                    action: () {
                      LoadingProcessBuilder.showProgressDialog();
                      userProvider.getBMI();
                      Future.delayed(const Duration(milliseconds: 500), () {
                        LoadingProcessBuilder.closeProgressDialog();
                        Navigator.pushNamed(context, RoutingNameConstants.BMIResultScreen);
                      });
                    },
                    child: Text(
                      'TXT_CALCULATE_BMI'.tr(),
                      style: theme.textTheme.button,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildItemGender({required String gender, required String urlIcon, required UserProvider provider}) {
    return ButtonShadowOuter(
      size: Size(sizeBox, sizeBox),
      padding: const EdgeInsets.all(12),
      color: gender == provider.user.gender ? theme.primaryColor : theme.backgroundColor,
      action: () => provider.setGender(gender),
      radius: 12,
      child: Column(
        children: [
          Expanded(child: CommonImage(url: urlIcon)),
          const SizedBox(height: 8),
          Text(
            gender,
            style: theme.textTheme.headline5?.copyWith(
              color: gender == provider.user.gender ? Colors.white : theme.disabledColor,
            ),
          ),
        ],
      ),
    );
  }
}
