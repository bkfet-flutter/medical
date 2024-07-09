import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mephar_app/app/app_theme.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      color: AppThemes.black.withOpacity(0.6),
      child: const Center(
          child: SpinKitFadingCircle(
        color: Colors.white,
        size: 50,
      ),),
    );
  }
}
