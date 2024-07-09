import 'package:flutter/material.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Quay về màn hình trước đó
          },
        ),
        // Tiêu đề của màn hình
      ),
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Text(
          "Đang cập nhật",
          style: AppFonts.normalBold(
            18,
            Colors.black,
          ),
        ),
      ),
    );
  }
}
