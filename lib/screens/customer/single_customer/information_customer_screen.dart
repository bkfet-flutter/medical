import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:mephar_app/provider/customer_provider.dart';
import 'package:mephar_app/provider/group_customer_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/card_detail_product.dart';
import 'package:mephar_app/widgets/item_activity_card.dart';
import 'package:provider/provider.dart';

class InformationCustomerScreen extends StatefulWidget {
  const InformationCustomerScreen({super.key});

  @override
  State<InformationCustomerScreen> createState() =>
      _InformationCustomerScreenState();
}

class _InformationCustomerScreenState extends State<InformationCustomerScreen> {
  initData() {}
  @override
  Widget build(BuildContext context) {
    return Consumer3<CustomerProvider, GroupCustomerProvider, BranchProvider>(
      builder: (context, customer, groupcustomer, branch, child) {
        return Scaffold(
          backgroundColor: const Color(0xffF3FAFF),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: (customer.customer?.avatar?.path != null &&
                                  customer.customer?.avatar?.path != "")
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    '${ApiRequest.domain}${customer.customer?.avatar?.path}',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Image.asset(
                                  AppImages.defaultAvatar,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CardDetailProduct(
                        onPressed: () {},
                        listData: [
                          {
                            "titleLeft": "Mã khách hàng",
                            "titleRight": customer.customer?.code,
                          },
                          {
                            "titleLeft": "Tên khách",
                            "titleRight": customer.customer?.fullName,
                          },
                          {
                            "titleLeft": "Điện thoại",
                            "titleRight": customer.customer?.phone,
                          },
                          {
                            "titleLeft": "Email",
                            "titleRight": customer.customer?.email,
                          },
                          {
                            "titleLeft": "Ngày sinh",
                            "titleRight": customer.customer?.birthday,
                          },
                          {
                            "titleLeft": "Nhóm KH",
                            "titleRight":
                                customer.customer?.groupCustomer?.name ?? "",
                          },
                          {
                            "titleLeft": "Mã số thuế",
                            "titleRight": customer.customer?.taxCode.toString(),
                          },
                          {
                            "titleLeft": "Địa chỉ",
                            "titleRight": customer.customer?.address,
                          },
                          {
                            "titleLeft": "Phường/Xã",
                            "titleRight": customer.customer?.ward?.name ?? "",
                          },
                          {
                            "titleLeft": "Quận/Huyện",
                            "titleRight":
                                customer.customer?.district?.name ?? "",
                          },
                          {
                            "titleLeft": "Tỉnh/Thành phố",
                            "titleRight":
                                customer.customer?.province?.name ?? "",
                          },
                          // {
                          //   "titleLeft": "Ghi chú",
                          //   "titleRight":data.,
                          //   "isFinal": true,
                          // },
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CardDetailProduct(
                        onPressed: () {},
                        listData: [
                          {
                            "titleLeft": "Chi nhánh",
                            "titleRight": branch.defaultBranch?.name,
                          },
                          {
                            "titleLeft": "Người tạo",
                            "titleRight": customer.customer?.createBy?.name,
                          },
                          {
                            "titleLeft": "Ngày tạo",
                            "titleRight": customer.customer?.createdAt,
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
                        onPressed: () async {
                          await groupcustomer.getDataGroupCustomer("", 1, 20);
                          // groupcustomer.
                          Navigator.pushNamed(
                            context,
                            AppRoutes.editInformationCustomer,
                            // arguments: customer.customerDetail.id,
                          );
                        },
                        title: "Chỉnh sửa",
                        icon: AppImages.iconPenRed,
                      )),
                      // Expanded(
                      //     child: ItemActivityCard(
                      //   onPressed: () async {
                      //     ApiResponse res =
                      //         await ApiRequest.changeStatusCustomer(
                      //             id: customer.customer?.id,
                      //             status: customer.customer?.status == "active"
                      //                 ? "inactive"
                      //                 : "active");
                      //   },
                      //   title: "Cho phép hoạt động",
                      //   icon: AppImages.iconShieldGreen,
                      // )),
                      Expanded(
                          child: ItemActivityCard(
                        onPressed: () {
                          AppFunction.showDialogAlert(context,
                              title: "Xóa khách hàng",
                              styleTitle: AppFonts.bold(20, AppThemes.dark0),
                              showBtnClose: false,
                              widgetDescription: Column(
                                children: [
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Image.asset(
                                    AppImages.boyQuestion,
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Text(
                                    "Bạn có chắc chắn muốn xóa khách hàng  ${customer.customer?.fullName}?",
                                    style: AppFonts.light(
                                      16,
                                      AppThemes.dark2,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  )
                                ],
                              ),
                              text1stButton: "Hủy",
                              isTwoButton: true,
                              onPress1stButton: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              },
                              text2ndButton: "Xóa",
                              onPress2ndButton: () async {
                                ApiResponse res =
                                    await ApiRequest.deleteCustomer(
                                        customer.customer?.id);
                                if (res.code == 200) {
                                  customer.clearList();
                                  customer.getDataCustomer("", 10, 1);
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                  Navigator.of(context).pop();
                                }
                              });
                        },
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
      },
    );
  }
}
