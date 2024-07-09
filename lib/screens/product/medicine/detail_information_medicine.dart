import 'package:flutter/material.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/widgets/header_add_product.dart';
import 'package:mephar_app/widgets/mephar_textfield.dart';

class DetailInformationMedicine extends StatelessWidget {
  const DetailInformationMedicine({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Container(
              color: Colors.white,
              margin: const EdgeInsets.only(top: 7, bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Image.asset(
                  AppImages.iconAddImage,
                  height: 32,
                  width: 32,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const HeaderAddProduct(
                    icon: AppImages.iconInfo,
                    title: "Định mức tồn",
                  ),
                  MepharTextfield(hintText: "Ít nhất"),
                  MepharTextfield(hintText: "Nhiều nhất"),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  MepharTextfield(
                    hintText: "Mô tả",
                    maxLines: 4,
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  MepharTextfield(
                    hintText: "Mẫu ghi chú (hóa đơn, đặt hàng)",
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
