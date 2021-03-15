import 'package:flutter/material.dart';
import 'package:wallo_flutter/theme.dart';

class CustomAppBar extends PreferredSize {
  final Widget child;
  final double height;

  CustomAppBar({@required this.child, this.height = kToolbarHeight});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: AppTheme().primaryColor,
      alignment: Alignment.center,
      child: child,
    );
  }
}
