import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';

class AppSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final bool? filled;
  final dynamic model;
  final void Function(dynamic) onSuggestionSelected;
  final FutureOr<Iterable<dynamic>> Function(String) suggestionsCallback;

  const AppSearchBar(
      {Key? key,
      required this.controller,
      this.hintText,
      required this.onSuggestionSelected,
      required this.suggestionsCallback,
      this.filled,
      this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      hideSuggestionsOnKeyboardHide: true,
      textFieldConfiguration: TextFieldConfiguration(
        controller: controller,
        style: const TextStyle(
            fontFamily: AppFonts.laTo, fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xff333333)),
        decoration: InputDecoration(
          hintStyle: AppFonts.normalBold(
            12,
            AppThemes.gray,
          ),
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          border: InputBorder.none,
          filled: filled,
          fillColor: AppThemes.light2,
          focusedBorder: filled == true
              ? const OutlineInputBorder(
                  borderSide: BorderSide(color: AppThemes.red0),
                )
              : const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppThemes.red0),
                ),
          enabledBorder: filled == true
              ? const OutlineInputBorder(
                  borderSide: BorderSide(color: AppThemes.kPrimary),
                  borderRadius: BorderRadius.all(Radius.circular(24.0)))
              : const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppThemes.light1),
                ),
        ),
      ),
      itemBuilder: (BuildContext context, dynamic suggest) {
        final item = suggest;
        return ListTile(
          title: Text(
            item.name ?? '',
            style: const TextStyle(
                fontFamily: AppFonts.laTo, fontSize: 14, fontWeight: FontWeight.w400, color: AppThemes.dark1),
          ),
        );
      },
      onSuggestionSelected: onSuggestionSelected,
      suggestionsCallback: suggestionsCallback,
    );
  }
}
