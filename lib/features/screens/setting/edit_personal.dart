import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_better_life/configs/constants/constant_size.dart';
import 'package:the_better_life/features/drink_water/providers/user/user_provider.dart';
import 'package:the_better_life/utils/loading_process_builder.dart';
import 'package:the_better_life/utils/snackbar_builder.dart';
import 'package:the_better_life/widgets/buttons/button_shadow_out.dart';
import 'package:the_better_life/widgets/input/box_plus_minus.dart';
import 'package:the_better_life/widgets/input/weight/weight_slider.dart';

class EditPersonalScreen extends StatefulWidget {
  const EditPersonalScreen({Key? key}) : super(key: key);

  @override
  State<EditPersonalScreen> createState() => _EditPersonalScreenState();
}

class _EditPersonalScreenState extends State<EditPersonalScreen> {
  late ThemeData theme;
  late Size size;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    size = MediaQuery.of(context).size;
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(title: Text('TXT_EDIT_PERSONAL'.tr(), style: theme.textTheme.headline3)),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: ConstantSize.spaceMargin),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildItemGender(
                          gender: 'TXT_MALE'.tr(),
                          urlIcon: 'assets/icons/ic_boy.svg',
                          provider: provider,
                        ),
                        _buildItemGender(
                          gender: 'TXT_FEMALE'.tr(),
                          urlIcon: 'assets/icons/ic_girl.svg',
                          provider: provider,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    WeightSlider(
                      weight: (provider.user.weight != null ? provider.user.weight ?? 0 : 50).toInt(),
                      minWeight: 20,
                      maxWeight: 200,
                      onChange: (val) => provider.setWeight(val.toDouble()),
                      unit: 'kg',
                      title: 'TXT_YOUR_WEIGHT'.tr(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BoxPlusMinus(
                          actionPlus: () => provider.plusAge(1),
                          actionMinus: () => provider.plusAge(-1),
                          title: 'Your age',
                          value: '${provider.user.age?.toStringAsFixed(0)}',
                        ),
                        BoxPlusMinus(
                          actionPlus: () => provider.plusHeight(1),
                          actionMinus: () => provider.plusHeight(-1),
                          title: 'Your height',
                          value: '${provider.user.height?.toStringAsFixed(0)}',
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
          bottomSheet: Padding(
            padding: EdgeInsets.all(ConstantSize.spaceMargin),
            child: SafeArea(
              child: ButtonShadowOuter(
                size: const Size(double.infinity, 56),
                action: () {
                  LoadingProcessBuilder.showProgressDialog();
                  provider.saveUserInfo();
                  Future.delayed(const Duration(milliseconds: 500), () {
                    LoadingProcessBuilder.closeProgressDialog();
                    Navigator.pop(context);
                    SnackBarBuilder.showSnackBar(content: 'TXT_CHANGE_INFO'.tr(), status: true);
                  });
                },
                child: Text(
                  'TXT_SAVE'.tr(),
                  style: theme.textTheme.button,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildItemGender({required String gender, required String urlIcon, required UserProvider provider}) {
    return ButtonShadowOuter(
      size: Size((size.width / 2) - 30, (size.width / 2) - 30),
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
