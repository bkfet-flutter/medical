import 'package:flutter/material.dart';

class CustomInputFiled extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSubmit;
  final bool? readOnly;

  const CustomInputFiled({super.key, required this.controller, this.onChanged, this.onSubmit, this.readOnly});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10, top: 10),
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: const Border.fromBorderSide(
          BorderSide(
            width: 1,
            color: Color(0xffC7C9D9),
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: TextFormField(
        readOnly: readOnly == true ? true : false,
        controller: controller,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        onFieldSubmitted: onSubmit,
        decoration: const InputDecoration(
          hintText: "0",
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
