import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final NavigationService navigationService = injector.get<NavigationService>();

abstract class SnackBarBuilder {
  static void showSnackBar({required String content, bool status = true, String? subContent, int? seconds}) {
    String _subContent = '';
    if (subContent != null) {
      _subContent = ': $subContent';
    }
    Fluttertoast.showToast(
      msg: content + _subContent,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP_RIGHT,
      timeInSecForIosWeb: seconds ?? 2,
      backgroundColor: (status
        ? Theme.of(navigationService.getCurrentContext).primaryColor
        : Theme.of(navigationService.getCurrentContext).colorScheme.error),
      textColor: Colors.white,
      fontSize: 12.0,
      webPosition: 'center',
    );
  }
}
