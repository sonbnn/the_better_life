import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_better_life/utils/regex.dart';
import 'package:the_better_life/widgets/buttons/button_shadow_out.dart';
import 'package:the_better_life/widgets/container/container_shadow_common.dart';
import 'package:the_better_life/widgets/container/container_shdow_inner.dart';
import 'package:the_better_life/widgets/input/input_text_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFE3EDF7),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ContainerShadowCommon(),
                ContainerShadowCommon(),
                ContainerShadowCommon(),
                ContainerShadowCommon(),
              ],
            ),
            const SizedBox(height: 20),
            ContainerShadowInner(
              child: const Icon(
                Icons.abc_outlined,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            ButtonShadowOuter(
              child: const Icon(
                Icons.abc_outlined,
                color: Colors.black,
              ),
              action: () async {
                if (!_formKey.currentState!.validate()) return;
                await Future.delayed(const Duration(seconds: 2));
                print(11111);
              },
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  InputTextField(
                    regexConfig: RegexConstant.notEmpty,
                    labelText: 'Label Text',
                    prefixIcon: SizedBox(
                      width: 50,
                      child: Center(
                        child: SvgPicture.asset('assets/images/svg/ic_name.svg'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  InputTextField(
                    regexConfig: RegexConstant.notEmpty,
                    labelText: 'Label Text',
                    suffixIcon: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        child: Text(
                          'icon'.toUpperCase(),
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}