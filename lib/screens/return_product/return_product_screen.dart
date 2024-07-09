import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/provider/product/product_return_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/screens/return_product/filter_screens.dart';
import 'package:mephar_app/widgets/app_number_paging.dart';
import 'package:mephar_app/widgets/card_product_check.dart';
import 'package:mephar_app/widgets/mephar_big_appbar.dart';
import 'package:mephar_app/widgets/mephar_floating_action_button.dart';
import 'package:provider/provider.dart';

class ReturnProductScreen extends StatefulWidget {
  const ReturnProductScreen({super.key});

  @override
  State<ReturnProductScreen> createState() => _ReturnProductScreenState();
}

class _ReturnProductScreenState extends State<ReturnProductScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => context
        .read<ProductReturnProvider>()
        .fetchProductReturn(context, firstCall: true));
  }

  int selectedPage = 1;

  @override
  Widget build(BuildContext context) {
    return MepharBigAppbar(
        onTapIconNearSearch: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const FilterScreen())),
        // haveIconNearSearch: true,
        title: "Trả hàng nhập",
        haveSuffixSearch: false,
        // haveOneIcon: true,
        controllerSearch:
            context.watch<ProductReturnProvider>().keywordController,
        floatingActionButton: MepharFloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRoutes.createReturnProductScreen,
            );
            // context.read<ProductReturnProvider>().changeLimit(context, 5);
          },
          heroTag: '',
        ),
        onChanged: (value) =>
            context.read<ProductReturnProvider>().fetchProductReturn(context),
        body: Consumer<ProductReturnProvider>(
            builder: (context, provider, child) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: SizedBox()
                            // MepharCheckbox(
                            //   isChecked: false,
                            //   text: "Danh sách trả hàng nhập",
                            //   isCheckBoxRight: true,
                            // ),
                            ),
                        provider.loading
                            ? const Padding(
                                padding: EdgeInsets.only(top: 100),
                                child: CircularProgressIndicator(),
                              )
                            : provider.listProductReturn.isEmpty
                                ? const SizedBox.shrink()
                                : ListView(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: List.generate(
                                      provider.listProductReturn.length,
                                      (index) => CardProductCheck(
                                        noCheckBox: true,
                                        listData: [
                                          {
                                            "titleLeft": "Mã trả hàng",
                                            "titleRight": provider
                                                .listProductReturn[index].code,
                                            "isTextBlue": true,
                                          },
                                          {
                                            "titleLeft": "Thời gian",
                                            "titleRight": provider
                                                .listProductReturn[index]
                                                .createdAt,
                                          },
                                          {
                                            "titleLeft": "Thời gian tạo",
                                            "titleRight": provider
                                                .listProductReturn[index]
                                                .createdAt,
                                          },
                                          {
                                            "titleLeft": "Chi nhánh",
                                            "titleRight": provider
                                                .listProductReturn[index]
                                                .branch
                                                ?.name,
                                          },
                                          {
                                            "titleLeft": "Người trả",
                                            "titleRight": provider
                                                .listProductReturn[index]
                                                .user
                                                ?.fullName,
                                          },
                                          {
                                            "titleLeft": "Người tạo",
                                            "titleRight": provider
                                                .listProductReturn[index]
                                                .creator
                                                ?.fullName,
                                          },
                                          {
                                            "titleLeft": "Ghi chú",
                                            "titleRight": provider
                                                .listProductReturn[index]
                                                .description,
                                            "isFinal": true,
                                          },
                                        ],
                                        numberCard: index,
                                        onPressed: () =>
                                            provider.navigateDetails(
                                                context,
                                                provider
                                                    .listProductReturn[index]
                                                    .id),
                                      ),
                                    ),
                                  )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    color: AppThemes.white,
                    border: Border(top: BorderSide(color: Color(0xffF5F5F5)))),
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tổng: ${context.watch<ProductReturnProvider>().total}",
                      style: const TextStyle(
                          fontFamily: AppFonts.laTo,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: AppThemes.dark2),
                    ),
                    AppNumberPaging(
                        currentPage:
                            context.watch<ProductReturnProvider>().page,
                        totalPage:
                            context.watch<ProductReturnProvider>().totalPage,
                        onTap: (value) => context
                            .read<ProductReturnProvider>()
                            .changePage(context, value)),
                  ],
                ),
              )
            ],
          );
        }));
  }
}
