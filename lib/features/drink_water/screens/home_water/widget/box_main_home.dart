import 'dart:convert';

import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:the_better_life/configs/router/routing_name.dart';
import 'package:the_better_life/features/drink_water/providers/drink/drink_provider.dart';
import 'package:the_better_life/features/drink_water/providers/user/user_provider.dart';
import 'package:the_better_life/features/drink_water/screens/home_water/widget/draw_water.dart';
import 'package:the_better_life/helper/sound_controller.dart';
import 'package:the_better_life/utils/regex.dart';
import 'package:the_better_life/utils/snackbar_builder.dart';
import 'package:the_better_life/widgets/buttons/button_shadow_out.dart';
import 'package:the_better_life/widgets/circular_percent_indicator.dart';
import 'package:the_better_life/widgets/container/container_shadow_common.dart';
import 'package:material_dialogs/material_dialogs.dart';

class BoxMainHome extends StatefulWidget {
  final DrinkProvider drinkProvider;
  final UserProvider userProvider;

  const BoxMainHome({Key? key, required this.drinkProvider, required this.userProvider}) : super(key: key);

  @override
  State<BoxMainHome> createState() => _BoxMainHomeState();
}

class _BoxMainHomeState extends State<BoxMainHome> {
  List _listWater = [];
  final TextEditingController _controller = TextEditingController();
  late ThemeData theme;
  late Size size;

  @override
  void initState() {
    super.initState();
    initWatterSet();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    double oldValue = widget.drinkProvider.progress;
    DateTime today = DateTime.now();
    String timeNow = "${today.hour}:${today.minute}";
    String result =
        '${widget.drinkProvider.amountDrinkToday.toStringAsFixed(0)} / ${widget.userProvider.user.recommendedMilli?.toStringAsFixed(0)}';
    theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ContainerShadowCommon(
          size: const Size(50, 50),
          child: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RoutingNameConstants.HistoryScreen);
            },
            icon: const Icon(Icons.history),
          ),
        ),
        TweenAnimationBuilder(
          duration: const Duration(seconds: 2),
          tween: Tween<double>(begin: oldValue, end: widget.drinkProvider.progress),
          builder: (context, double sizeWatter, child) {
            return CircularPercentIndicator(
              radius: size.width / 3,
              lineWidth: 10,
              circularStrokeCap: CircularStrokeCap.round,
              percent: sizeWatter,
              progressColor: theme.primaryColor.withOpacity(0.5),
              backgroundColor: theme.disabledColor.withOpacity(0.3),
              center: Stack(
                children: [
                  SizedBox(
                    width: size.width / 1.7,
                    height: size.width / 1.7,
                    child: LiquidCircularProgressIndicator(
                      value: sizeWatter,
                      valueColor: AlwaysStoppedAnimation(Colors.lightBlueAccent.withOpacity(0.8)),
                      backgroundColor: Colors.lightBlueAccent.withOpacity(0.2),
                      direction: Axis.vertical,
                      center: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${(sizeWatter * 100).toStringAsFixed(0)}%",
                            style: theme.textTheme.headline3?.copyWith(color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '$result ml',
                            style: theme.textTheme.headline5?.copyWith(color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            child: ButtonShadowOuter(
                              action: () {
                                SoundController.playSoundDrink();
                                setState(() {
                                  oldValue = widget.drinkProvider.progress;
                                });
                                widget.drinkProvider.addWater();
                                widget.drinkProvider
                                    .addHistoryDay(timeRef: timeNow, amount: widget.drinkProvider.amount);
                                if (sizeWatter * 100 == 100.0) {
                                  showResultDialog();
                                }
                              },
                              color: theme.primaryColor,
                              size: const Size(110, 50),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Icon(Icons.add_task, color: Colors.white),
                                  Text(
                                    '${widget.drinkProvider.amount.toStringAsFixed(0)}ml',
                                    style: theme.textTheme.bodyText1?.copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        ContainerShadowCommon(
          size: const Size(50, 50),
          child: IconButton(
            onPressed: () {
              onChangeDrink();
            },
            icon: const Icon(Icons.local_drink_outlined),
          ),
        ),
      ],
    );
  }

  void onChangeDrink() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: const EdgeInsets.all(0),
          content: ContainerShadowCommon(
            padding: const EdgeInsets.all(24),
            size: Size(MediaQuery.of(context).size.width - 48, 350),
            colorShadowTopLeft: Colors.grey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'TXT_CHOOSE_AMOUNT_WATER'.tr(),
                  style: theme.textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _listWater.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return _buildItemWatter(
                        amount: _listWater[index]["amount"],
                        urlImage: _listWater[index]["iconSrc"],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'TXT_OR_ENTER_NUMBER'.tr(),
                  style: theme.textTheme.bodyText1,
                ),
                BasicTextField(
                  controller: _controller,
                  regexConfig: RegexConstant.none,
                  keyboardType: TextInputType.number,
                  hintText: widget.drinkProvider.amount.toStringAsFixed(0),
                  colorLabel: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                  borderRadius: 16,
                  suffixIcon: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('ml', style: TextStyle(color: Colors.grey)),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ButtonShadowOuter(
                      size: const Size(100, 46),
                      radius: 12,
                      action: () {
                        Navigator.pop(context);
                      },
                      child: Text('TXT_CANCEL'.tr(), style: theme.textTheme.button),
                    ),
                    const SizedBox(width: 12),
                    ButtonShadowOuter(
                      size: const Size(100, 46),
                      radius: 12,
                      action: () {
                        if (_controller.text.isNotEmpty && double.parse(_controller.text) != 0) {
                          widget.drinkProvider.setAmount(double.parse(_controller.text));
                          Navigator.pop(context);
                        } else {
                          SnackBarBuilder.showSnackBar(content: 'TXT_ERR_CHANGE_WATER'.tr(), status: false);
                        }
                      },
                      child: Text('TXT_CONFIRM'.tr(), style: theme.textTheme.button),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildItemWatter({required double? amount, required String? urlImage}) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ButtonShadowOuter(
            size: const Size(50, 50),
            radius: 12,
            action: () {
              widget.drinkProvider.setAmount(amount ?? 0);
              Navigator.pop(context);
            },
            child: CommonImage(
              url: urlImage ?? 'assets/icons/ic_water.svg',
              width: 30,
              height: 30,
              color: widget.drinkProvider.amount == amount ? Colors.blue : Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text('${amount?.toStringAsFixed(0)}ml'),
        ],
      ),
    );
  }

  Future<void> initWatterSet() async {
    final String response = await rootBundle.loadString('assets/jsons/watter_config.json');
    final data = await json.decode(response);
    setState(() {
      _listWater = data['watter'];
    });
  }

  Future<void> showResultDialog() {
    return Dialogs.materialDialog(
      color: theme.backgroundColor,
      title: 'TXT_CONGRATULATIONS'.tr(),
      msg: 'TXT_CONGRATULATIONS_DESCRIPTION'.tr(),
      titleStyle: theme.textTheme.headline5!.copyWith(color: theme.primaryColor),
      msgStyle: theme.textTheme.bodyText1!,
      lottieBuilder: Lottie.asset(
        'assets/jsons/lottie/congratulations_water.json',

      ),
      context: context,
      actions: [
        ButtonShadowOuter(
          action: () {
            Navigator.of(context).pop();
          },
          child: Text('TXT_CONFIRM'.tr(), style: theme.textTheme.button),
        ),
      ],
    );
  }
}
