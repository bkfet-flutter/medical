import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/doctor_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/card_detail_product.dart';
import 'package:mephar_app/widgets/item_activity_card.dart';
import 'package:mephar_app/widgets/mephar_big_appbar.dart';
import 'package:mephar_app/widgets/mephar_white_appbar.dart';
import 'package:provider/provider.dart';

class InformationDoctorScreen extends StatefulWidget {
  const InformationDoctorScreen({super.key});

  @override
  State<InformationDoctorScreen> createState() =>
      _InformationDoctorScreenState();
}

class _InformationDoctorScreenState extends State<InformationDoctorScreen> {
  initData() {}
  @override
  Widget build(BuildContext context) {
    return Consumer<DoctorProvider>(
      builder: (context, doctor, child) {
        return Scaffold(
          backgroundColor: const Color(0xffF3FAFF),
          body: MepharWhiteAppbar(
            title: "Thông tin chi tiết bác sĩ",
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
                            // child: (customer.customer?.avatar?.path != null &&
                            //         customer.customer?.avatar?.path != "")
                            //     ? ClipRRect(
                            //         borderRadius: BorderRadius.circular(10),
                            //         child: Image.network(
                            //           '${ApiRequest.domain}${customer.customer?.avatar?.path}',
                            //           width: 100,
                            //           height: 100,
                            //           fit: BoxFit.cover,
                            //         ),
                            //       )
                            child: Image.asset(
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
                              "titleLeft": "Mã bác sĩ",
                              "titleRight": doctor.doctor?.code,
                            },
                            {
                              "titleLeft": "Tên bác sĩ",
                              "titleRight": doctor.doctor?.name,
                            },
                            {
                              "titleLeft": "Giới tính",
                              "titleRight": doctor.doctor?.gender == "male"
                                  ? "Nam"
                                  : "Nữ",
                            },
                            {
                              "titleLeft": "Chuyên khoa",
                              "titleRight": doctor.doctor?.specialist?.name,
                            },
                            {
                              "titleLeft": "Trình độ",
                              "titleRight": doctor.doctor?.level?.name,
                            },
                            {
                              "titleLeft": "Nơi công tác",
                              "titleRight": doctor.doctor?.workPlace?.name,
                            },
                            {
                              "titleLeft": "Điện thoại",
                              "titleRight": doctor.doctor?.phone,
                            },
                            {
                              "titleLeft": "Email",
                              "titleRight": doctor.doctor?.email,
                            },
                            {
                              "titleLeft": "Địa chỉ",
                              "titleRight": doctor.doctor?.address,
                            },
                            {
                              "titleLeft": "Phường/Xã",
                              "titleRight": doctor.doctor?.ward?.name ?? "",
                            },
                            {
                              "titleLeft": "Quận/Huyện",
                              "titleRight": doctor.doctor?.district?.name ?? "",
                            },
                            {
                              "titleLeft": "Tỉnh/Thành phố",
                              "titleRight": doctor.doctor?.province?.name ?? "",
                              "isFinal": true,
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
                            Navigator.pushNamed(
                              context,
                              AppRoutes.editDoctorScreen,
                              // arguments: customer.customerDetail.id,
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
                          onPressed: () {
                            AppFunction.showDialogAlert(context,
                                title: "Xóa bác sĩ",
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
                                      "Bạn có chắc chắn muốn xóa bác sĩ  ${doctor.doctor?.name}?",
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
                                      await ApiRequest.deleteDoctor(
                                          doctor.doctor?.id);
                                  if (res.code == 200) {
                                    doctor.getListDoctor(limit: 10, page: 1);
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
          ),
        );
      },
    );
  }
}
