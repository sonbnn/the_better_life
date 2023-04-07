import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:the_better_life/configs/constants/constants.dart';
import 'package:the_better_life/utils/snackbar_builder.dart';

abstract class LoadingProcessBuilder {

  static void showProgressDialog({bool? isShowText = false, String? text = 'Verifying'}) {
    Constants.isShowingDialog = true;
    showDialog(
      context: navigationService.getCurrentContext,
      barrierDismissible: false,
      builder: (_) {
        return WillPopScope(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xFFFCFCFC).withOpacity(0.08),
                border: Border.all(
                  color: Color(0xFFFCFCFC).withOpacity(0.16),
                )
              ),
              width: 100,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset('assets/json/loading.json'),
                  SizedBox(height: isShowText! ? 15 : 0),
                  isShowText ?  Text(
                    'Verifying',
                    style: TextStyle(
                      color: Color(0xFFFFE87B),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      decoration: TextDecoration.none
                    ),
                  ) : SizedBox()
                ],
              )
            ),
          ),
          onWillPop: () async => false,
        );
      }
    ).then((value) {
      Constants.isShowingDialog = false;
    });
  }

  //need "await" when close
  static Future<void> closeProgressDialog() async {
    if (Constants.isShowingDialog) {
      Navigator.of(navigationService.getCurrentContext).pop();
    }
  }
}
