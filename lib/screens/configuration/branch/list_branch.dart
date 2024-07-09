import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/configuration/branch/edit_branch_screen.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/blank_page.dart';
import 'package:mephar_app/widgets/card_detail_product.dart';
import 'package:provider/provider.dart';

class ListBranch extends StatefulWidget {
  const ListBranch({super.key});

  @override
  State<ListBranch> createState() => _ListBranchState();
}

class _ListBranchState extends State<ListBranch> {
  @override
  Widget build(BuildContext contextScreen) {
    return Consumer<BranchProvider>(builder: (context, provider, child) {
      return provider.loading
          ? buildLoadingUi()
          : provider.listBranch.isEmpty
              ? buildEmptyUi()
              : ListView.separated(
                  itemCount: provider.listBranch.length + 1,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  itemBuilder: (BuildContext context, int index) {
                    return (index < provider.listBranch.length)
                        ? CardDetailProduct(
                            listData: [
                              {
                                "titleLeft": "Tên chi nhánh",
                                "titleRight": provider.listBranch[index].name,
                                "isTextBlue": true,
                              },
                              {
                                "titleLeft": "Mã CN",
                                "titleRight": provider.listBranch[index].code,
                              },
                              {
                                "titleLeft": "Địa chỉ 1",
                                "titleRight": provider.listBranch[index].address1,
                              },
                              {
                                "titleLeft": "Phường/Xã",
                                "titleRight": provider.listBranch[index].ward?.name,
                              },
                              {
                                "titleLeft": "Quận/Huyện",
                                "titleRight": provider.listBranch[index].district?.name,
                              },
                              {
                                "titleLeft": "Tỉnh/Thành phố",
                                "titleRight": provider.listBranch[index].province?.name,
                              },
                              {
                                "titleLeft": "Địa chỉ 2",
                                "titleRight": provider.listBranch[index].address2,
                              },
                              {
                                "titleLeft": "Ngày tạo",
                                "titleRight": AppFunction.formatDateTimeFromApi(provider.listBranch[index].createdAt),
                              },
                              {
                                "titleLeft": "Trạng thái",
                                "titleRight":
                                    provider.listBranch[index].status == 1 ? "Đang hoạt động" : "Ngưng hoạt động",
                                "isStatus": true,
                              },
                              {
                                "titleLeft": "Chi nhánh mặc định",
                                "isWidget": true,
                                "widgetRight": provider.listBranch[index].isDefaultBranch == true
                                    ? Image.asset(
                                        AppImages.iconCheckGreen,
                                        width: 15,
                                        height: 11,
                                        fit: BoxFit.cover,
                                      )
                                    : const SizedBox.shrink(),
                              },
                            ],
                            onTapDelete: () => deleteDialog(context, provider.listBranch[index].id),
                            onTapEdit: () => navigateEdit(contextScreen, provider.listBranch[index].id),
                            haveTwoIcon: true,
                            onPressed: () {},
                            haveBorder: true,
                          )
                        : const SizedBox(height: 80);
                  },
                  separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 12),
                );
    });
  }

  Future<void> navigateEdit(BuildContext context, int? id) async {
    final result =
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditBranchScreen(id: id))) as bool?;
    if (result == true) {
      if (context.mounted) {
        context
            .read<BranchProvider>()
            .fetchBranches(context)
            .then((value) => AppFunction.showDialogSuccess(context, content: "Chỉnh sửa chi nhánh thành công"));
      }
    }
  }

  void deleteDialog(BuildContext context, int? id) => AppFunction.showDialogAlert(context,
      title: "Xóa chi nhánh",
      styleTitle: AppFonts.bold(20, AppThemes.dark0),
      showBtnClose: true,
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
            "Bạn có chắc chắn muốn xóa chi nhánh này không?",
            textAlign: TextAlign.center,
            style: AppFonts.light(
              16,
              AppThemes.dark2,
            ),
          ),
          const SizedBox(
            height: 24,
          )
        ],
      ),
      text1stButton: "Hủy",
      isTwoButton: true,
      onPress1stButton: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
      text2ndButton: "Xóa",
      onPress2ndButton: () {
        Navigator.of(context, rootNavigator: true).pop();
        delete(context, id);
      });

  delete(BuildContext context, int? id) {
    AppFunction.showLoading(context);
    context.read<BranchProvider>().deleteBranch(context, id).then((value) {
      AppFunction.hideLoading(context);
      if (value == true) {
        context.read<BranchProvider>().fetchBranches(context);
      }
    });
  }

  Widget buildEmptyUi() => const Center(
        child: BlankPage(
          title: "Không có chi nhánh nào",
          content: "",
        ),
      );

  Widget buildLoadingUi() => const Center(
        child: CircularProgressIndicator(
          color: AppThemes.red0,
        ),
      );
}
