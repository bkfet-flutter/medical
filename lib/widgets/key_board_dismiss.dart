import 'package:flutter/material.dart';

class KeyboardDismiss extends StatelessWidget {
  final Widget child;
  const KeyboardDismiss({
    Key? key,
    required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: child,
    );
  }
}
