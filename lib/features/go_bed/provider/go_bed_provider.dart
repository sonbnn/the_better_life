import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GoBedProvider extends ChangeNotifier {
  static GoBedProvider of(BuildContext context) => Provider.of<GoBedProvider>(context, listen: false);
}