import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/provider/supplier_provider.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/widgets/card_detail_product.dart';
import 'package:mephar_app/widgets/item_activity_card.dart';
import 'package:provider/provider.dart';

class SupplierInformation extends StatefulWidget {
  const SupplierInformation({
    super.key,
  });

  @override
  State<SupplierInformation> createState() => _SupplierInformationState();
}

class _SupplierInformationState extends State<SupplierInformation> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SupplierProvider>(builder: (context, supplier, child) {
      return Scaffold(
        backgroundColor: const Color(0xffF3FAFF),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Text(idSupplier.toString()),
                    CardDetailProduct(
                      onPressed: () {},
                      listData: [
                        {
                          "titleLeft": "Mã nhà cung cấp",
                          "titleRight": supplier.supplier?.code,
                        },
                        {
                          "titleLeft": "Tên nhà cung cấp",
                          "titleRight": supplier.supplier?.name,
                        },
                        {
                          "titleLeft": "Điện thoại",
                          "titleRight": supplier.supplier?.phone,
                        },
                        {
                          "titleLeft": "Email",
                          "titleRight": supplier.supplier?.email,
                        },
                        {
                          "titleLeft": "Ngày tạo",
                          "titleRight": supplier.supplier?.createdAt,
                        },
                        {
                          "titleLeft": "Nhóm KH",
                          "titleRight": supplier.supplier?.groupSupplier?.name,
                        },
                        {
                          "titleLeft": "Mã số thuế",
                          "titleRight": supplier.supplier?.taxCode ?? "---",
                        },
                        {
                          "titleLeft": "Địa chỉ",
                          "titleRight": supplier.supplier?.address,
                        },
                        {
                          "titleLeft": "Phường/Xã",
                          "titleRight": supplier.supplier?.ward?.name,
                        },
                        {
                          "titleLeft": "Quận/Huyện",
                          "titleRight": supplier.supplier?.district?.name,
                        },
                        {
                          "titleLeft": "Tỉnh/Thành phố",
                          "titleRight": supplier.supplier?.province?.name,
                        },
                        {
                          "titleLeft": "Ghi chú",
                          "titleRight": supplier.supplier?.note,
                          "isFinal": true,
                        },
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CardDetailProduct(
                      onPressed: () {},
                      listData: const [
                        {
                          "titleLeft": "Chi nhánh",
                          "titleRight": "Chi nhánh trung tâm",
                        },
                        {
                          "titleLeft": "Người tạo",
                          "titleRight": "Admin",
                        },
                        {
                          "titleLeft": "Ngày tạo",
                          "titleRight": "01/02/2023",
                          "isFinal": true,
                        },
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: const Color(0xffF3FAFF),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: AppDimens.spaceMediumLarge,
                  bottom: AppDimens.spaceXSmall10,
                  right: AppDimens.spaceXSmall10,
                  left: AppDimens.spaceXSmall10,
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: ItemActivityCard(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.editSupplier,
                        );
                      },
                      title: "Chỉnh sửa",
                      icon: AppImages.iconPenRed,
                    )),
                    Expanded(
                        child: ItemActivityCard(
                      onPressed: () {},
                      title: "Cho phép hoạt động",
                      icon: AppImages.iconShieldGreen,
                    )),
                    Expanded(
                        child: ItemActivityCard(
                      onPressed: () {},
                      title: "Xóa",
                      colorIcon: AppThemes.red0,
                      icon: AppImages.iconTrashGrey,
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
