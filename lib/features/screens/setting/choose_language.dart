import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_better_life/configs/constants/constant_size.dart';
import 'package:the_better_life/utils/loading_process_builder.dart';
import 'package:the_better_life/utils/snackbar_builder.dart';
import 'package:the_better_life/widgets/buttons/button_shadow_out.dart';

class ChooseLanguageScreen extends StatefulWidget {
  const ChooseLanguageScreen({Key? key}) : super(key: key);

  @override
  State<ChooseLanguageScreen> createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  List _language = [];
  late TextTheme textTheme;

  @override
  void initState() {
    initLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TXT_CHOOSE_YOUR_LANGUAGE'.tr(),
          style: textTheme.headline3,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: _language.length,
              itemBuilder: (context, index) {
                return _buildItemLanguage(
                  name: _language[index]["name"] ?? '',
                  isoCode: _language[index]["isoCode"] ?? '',
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> initLanguage() async {
    final String response = await rootBundle.loadString('assets/jsons/language.json');
    final data = await json.decode(response);
    setState(() {
      _language = data['language'];
    });
  }

  Widget _buildItemLanguage({required String name, required isoCode}) {
    return ButtonShadowOuter(
      margin: EdgeInsets.symmetric(horizontal: ConstantSize.spaceMargin, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      radius: 12,
      size: const Size(double.infinity, 56),
      action: () async {
        LoadingProcessBuilder.showProgressDialog();
        await context.setLocale(Locale(isoCode));
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.pop(context);
          LoadingProcessBuilder.closeProgressDialog();
          SnackBarBuilder.showSnackBar(content: 'TXT_CHANGE_LANGUAGE_SUCCESS'.tr(), status: true);
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(name, style: textTheme.bodyText1), const Icon(Icons.navigate_next)],
      ),
    );
  }
}
