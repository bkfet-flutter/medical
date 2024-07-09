import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      // Don't allow user to remove the leading digit
      return newValue;
    }

    String formattedText = _formatNumber(newValue.text);
    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String _formatNumber(String text) {
    // Remove all non-digit characters from the input
    String cleanedText = text.replaceAll(RegExp(r'\D'), '');

    // Format the number with commas
    final formatter = NumberFormat("#,###");
    int value = int.tryParse(cleanedText) ?? 0;
    return formatter.format(value);
  }
}