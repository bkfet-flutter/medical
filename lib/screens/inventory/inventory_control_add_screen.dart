import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/widgets/item_order.dart';
import 'package:mephar_app/widgets/item_quantity_order.dart';
import 'package:mephar_app/widgets/mephar_big_appbar.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/mephar_dropdown_button.dart';
import 'package:mephar_app/widgets/mephar_textfield.dart';

class InventoryControlAddScreen extends BaseScreen {
  const InventoryControlAddScreen({super.key});

  @override
  InventoryControlAddScreenState createState() =>
      InventoryControlAddScreenState();
}

class InventoryControlAddScreenState
    extends BaseState<InventoryControlAddScreen> with BaseScreenMixin {
  @override
  Widget buildHeader() {
    return const SizedBox.shrink();
  }

  @override
  Widget buildBody(BuildContext context) {
    return MepharBigAppbar(
      title: "Kiểm kho",
      haveIconNearSearch: true,
      haveOneIcon: true,
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: const Color(0xffF3FAFF),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          MepharDropDownButton(
                              haveBorder: false,
                              hintText: "Nhân viên phụ trách",
                              items: const ["Admin", "Người dùng"],
                              onChanged: (value) {
                                setState(() {});
                              }),
                          MepharTextfield(
                            hintText: "Thời gian",
                          ),
                          MepharTextfield(
                            hintText: "Mã kiểm kho",
                          ),
                          MepharTextfield(
                            hintText: "Trạng thái",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 8,
                      color: AppThemes.blue4,
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: const ItemQuantityOrder(
                        title: "Tổng tiền hàng",
                        number: "83,000",
                      ),
                    ),
                    Container(
                      height: 8,
                      color: AppThemes.blue4,
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: const ItemQuantityOrder(
                        title: "Kiểm hàng gần đây",
                        number: "83,000",
                      ),
                    ),
                    Container(
                      height: 8,
                      color: AppThemes.blue4,
                    ),
                    const ItemOrder(
                      icon: AppImages.iconPenBlue,
                      title: "Thêm ghi chú",
                      isBlueText: false,
                    )
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(AppDimens.spaceMediumLarge),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: MepharButton(
                          onPressed: () {},
                          haveIcon: true,
                        )),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        flex: 3,
                        child: MepharButton(
                          onPressed: () {},
                          titleButton: "Thanh toán",
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
