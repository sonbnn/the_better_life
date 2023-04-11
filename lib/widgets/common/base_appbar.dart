import 'package:flutter/material.dart';
import 'package:the_better_life/configs/constants/constant_size.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BaseAppBar({
    Key? key,
    this.title,
    this.actions,
    this.bottom,
    this.centerTitle,
    this.iconLeading,
    this.bgColor,
  }) : super(key: key);

  final String? title;
  final List<Widget>? actions;
  final PreferredSize? bottom;
  final bool? centerTitle;
  final Widget? iconLeading;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Navigator.of(context).canPop()
          ? IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_ios_sharp),
            )
          : const SizedBox(),
      centerTitle: centerTitle ?? true,
      title: Text(
        title ?? '',
        style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 22),
      ),
      backgroundColor: bgColor ?? Theme.of(context).backgroundColor,
      elevation: 0,
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
