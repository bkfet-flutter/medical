import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/widgets/normal_text.dart';
import 'package:number_paginator/number_paginator.dart';

class PagingBottomWidget extends StatelessWidget {
  final int total;
  final int size;
  final NumberPaginatorController? controller;
  final void Function(int)? onChanged;

  const PagingBottomWidget({
    super.key,
    required this.total,
    this.controller,
    this.onChanged,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: NormalText(
              "Tổng: $total",
              style: AppFonts.regular(14, AppThemes.dark2),
              minFontSize: 8,
              maxLines: 1,
            ),
          ),
          Expanded(
            flex: 6,
            child: NumberPaginator(
              controller: controller,
              initialPage: 0,
              onPageChange: onChanged,
              numberPages: ((total / size).ceil() > 0) ? (total / size).ceil() : 1,
              config: NumberPaginatorUIConfig(
                  height: 36,
                  buttonShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Color(0xffE0E2E7), width: 1.0),
                  ),
                  buttonSelectedForegroundColor: AppThemes.red0,
                  buttonUnselectedForegroundColor: const Color(0xff232325),
                  buttonUnselectedBackgroundColor: Colors.white,
                  buttonSelectedBackgroundColor: Colors.white,
                  contentPadding: const EdgeInsets.all(0)),
            ),
          ),
        ],
      ),
    );
  }
}
