import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:mephar_app/provider/group_customer_provider.dart';
import 'package:mephar_app/provider/sample_prescription_provider.dart';
import 'package:mephar_app/provider/supplier_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/app_number_paging.dart';
import 'package:mephar_app/widgets/card_product_check.dart';
import 'package:mephar_app/widgets/mephar_big_appbar.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/mephar_checkbox.dart';
import 'package:mephar_app/widgets/mephar_floating_action_button.dart';
import 'package:mephar_app/widgets/normal_text.dart';
import 'package:provider/provider.dart';

class ListTemplateMedicineScreen extends StatefulWidget {
  const ListTemplateMedicineScreen({super.key});

  @override
  State<ListTemplateMedicineScreen> createState() =>
      _ListTemplateMedicineScreenState();
}

class _ListTemplateMedicineScreenState
    extends State<ListTemplateMedicineScreen> {
  TextEditingController searchController = TextEditingController();
  String? keyword;
  int selectedPage = 1;
  int? branchId;
  callApi() async {
    var branch =
        Provider.of<BranchProvider>(context, listen: false).defaultBranch;
    branchId = branch?.id;
    await Provider.of<SampleProvider>(context, listen: false)
        .getListSample(
            context: context, limit: 5, page: 1, search: "", branchId: branchId)
        .whenComplete(() => AppFunction.hideLoading(context));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callApi();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SampleProvider>(
      builder: (context, sample, child) {
        return MepharBigAppbar(
            haveSuffixSearch: false,
            title: "Danh sách đơn thuốc mẫu",
            controllerSearch: searchController,
            floatingActionButton: MepharFloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.addInformationSampleMedicine,
                );
              }, heroTag: 'addInformationSampleMedicine',
            ),
            onChanged: (value) async {
              String search = value.replaceAll(" ", "+");
              await sample.getListSample(
                  context: context, search: search, page: 1, limit: 5);
            },
            onFieldSubmitted: (String? search) async {
              setState(() {
                // Chuyển đổi khoảng trắng thành dấu cộng
                keyword = searchController.text.replaceAll(' ', '+');
              });

              await sample.getListSample(
                  context: context, search: keyword, page: 1, limit: 5);
            },
            body: sample.listSample.isEmpty
                ? SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 60),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 90,
                          ),
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Image.asset(
                                AppImages.avatarBoy,
                                width: 150,
                                height: 150,
                                fit: BoxFit.fill,
                              ),
                              Positioned(
                                right: -10,
                                bottom: -10,
                                child: MepharFloatingActionButton(
                                  onPressed: () {}, heroTag: '',
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 43,
                          ),
                          Text(
                            "Chưa có đơn thuốc mẫu nào!",
                            textAlign: TextAlign.center,
                            style: AppFonts.bold(
                              16,
                              AppThemes.dark0,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            "Thêm đơn thuốc mẫu vào danh sách ngay nào",
                            textAlign: TextAlign.center,
                            style: AppFonts.bold(
                              16,
                              AppThemes.dark3,
                            ),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          MepharButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.addInformationSampleMedicine,
                              );
                            },
                            titleButton: "Tạo đơn thuốc mẫu",
                          )
                        ],
                      ),
                    ),
                  )
                : Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: MepharCheckbox(
                          isChecked: false,
                          text: "Đơn thuốc mẫu",
                          isCheckBoxRight: true,
                        ),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: sample.listSample.length,
                            itemBuilder: (context, index) {
                              return CardProductCheck(
                                  numberCard: index,
                                  haveIcon: true,
                                  listData: [
                                    {
                                      "titleLeft": "Mã đơn thuốc",
                                      "titleRight":
                                          sample.listSample[index].code,
                                    },
                                    {
                                      "titleLeft": "Tên đơn thuốc",
                                      "titleRight":
                                          sample.listSample[index].name,
                                    },
                                    {
                                      "titleLeft": "Tổng mua",
                                      "titleRight":
                                          sample.listSample[index].status == 1
                                              ? "Hoạt động"
                                              : "Ngưng hoạt động",
                                      "isFinal": true,
                                    },
                                  ],
                                  onTapDelete: () {
                                    AppFunction.showDialogAlert(context,
                                        title: "Xóa nhà cung cấp",
                                        styleTitle:
                                            AppFonts.bold(20, AppThemes.dark0),
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
                                              "Bạn có chắc chắn muốn xóa dđơn thuốc mẫu ${sample.listSample[index].name}?",
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
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                        },
                                        text2ndButton: "Xóa",
                                        onPress2ndButton: () async {
                                          ApiResponse res = await ApiRequest
                                              .deleteSampleMedicine(
                                                  sample.listSample[index].id);
                                          if (res.code == 200) {
                                            sample.clearList();
                                            await sample.getListSample(
                                                context: context,
                                                search: "",
                                                page: 1,
                                                limit: 5);

                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop();
                                          }
                                        });
                                  },
                                  onPressed: () async {
                                    await sample.getDetailSample(
                                        sample.listSample[index].id ?? 1);
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.supplierDetailScreen,
                                      // arguments: supplier.listSupplier[index],
                                    );
                                  });
                            }),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimens.spaceMedium,
                          vertical: AppDimens.spaceXSmall,
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: NormalText(
                                "Tổng: ${sample.total}",
                                style: AppFonts.regular(14, AppThemes.dark2),
                                minFontSize: 8,
                                maxLines: 1,
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: AppNumberPaging(
                                currentPage: sample.currentPage,
                                totalPage: ((sample.total / 5).ceil() > 0)
                                    ? (sample.total / 5).ceil()
                                    : 1,
                                onTap: (value) {
                                  AppFunction.hideKeyboard(context);
                                  setState(() {
                                    selectedPage = value;
                                  });
                                  sample.updatePage(value);

                                  callApi();
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ));
      },
    );
  }
}
