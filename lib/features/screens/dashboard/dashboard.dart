import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_better_life/features/bmi_caculator/screen/bmi_calculator_sreen.dart';
import 'package:the_better_life/features/drink_water/providers/page/page_provider.dart';
import 'package:the_better_life/features/drink_water/screens/home_water/home/home_screen.dart';
import 'package:the_better_life/widgets/container/container_shadow_common.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final PageStorageBucket bucket = PageStorageBucket();
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  late ThemeData theme;
  List<Widget> screens = [const WatterScreen(), Container(), const BMICalculatorScreen()];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    theme = Theme.of(context);
    return Scaffold(
      key: _key,
      body: Consumer<PageProvider>(
        builder: (context, provider, child) {
          return Stack(
            children: [
              PageStorage(
                bucket: bucket,
                child: screens[provider.currentIndexPage],
              ),
              Positioned(
                bottom: 0,
                child: ContainerShadowCommon(
                  size: Size(size.width - 48, 80),
                  margin: EdgeInsets.only(left: 24, right: 24, bottom: MediaQuery.of(context).padding.bottom),
                  color: Theme.of(context).backgroundColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildIcon(index: 0, icon: 'water'),
                      _buildIcon(index: 1, icon: 'sleep'),
                      _buildIcon(index: 2, icon: 'bmi'),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),

    );
  }

  Widget _buildIcon({required String icon, required int index}) {
    return InkWell(
      onTap: () {
        PageProvider.of(context).setCurrentIndexPage(index);
      },
      child: CommonImage(
        url: 'assets/icons/ic_$icon.svg',
        width: 30,
        height: 30,
        color: PageProvider.of(context).currentIndexPage == index ?theme.primaryColor :  theme.disabledColor,
      ),
    );
  }

}
