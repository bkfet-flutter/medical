import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';

class MepharFloatingActionButton extends StatelessWidget {
  const MepharFloatingActionButton({
    super.key,
    required this.onPressed, required this.heroTag,
  });
  final Function() onPressed;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 16,
            spreadRadius: 0,
            color: const Color(0xffF14040).withOpacity(0.5))
      ]),
      child: FloatingActionButton(
        heroTag: heroTag,
        onPressed: onPressed,
        backgroundColor: AppThemes.red0,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
