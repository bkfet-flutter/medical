import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/provider/user_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/configuration/staff/edit_information_staff_screen.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/blank_page.dart';
import 'package:mephar_app/widgets/card_detail_product.dart';
import 'package:provider/provider.dart';

class ListStaff extends StatefulWidget {
  const ListStaff({super.key});

  @override
  State<ListStaff> createState() => _ListStaffState();
}

class _ListStaffState extends State<ListStaff> {
  @override
  Widget build(BuildContext contextScreen) {
    return Consumer<UserProvider>(builder: (context, provider, child) {
      return provider.loading
          ? buildLoadingUi()
          : provider.listStaff.isEmpty
              ? buildEmptyUi()
              : ListView.separated(
                  itemCount: provider.listStaff.length + 1,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  itemBuilder: (BuildContext context, int index) {
                    return (index < provider.listStaff.length)
                        ? CardDetailProduct(
                            listData: [
                              {
                                "titleLeft": "Tên nhân viên",
                                "titleRight": provider.listStaff[index].fullName,
                              },
                              {
                                "titleLeft": "Số điện thoại",
                                "titleRight": provider.listStaff[index].phone,
                              },
                              {
                                "titleLeft": "Email",
                                "titleRight": provider.listStaff[index].email,
                              },
                              {
                                "titleLeft": "Vai trò",
                                "titleRight": provider.listStaff[index].role?.name,
                              },
                              {
                                "titleLeft": "Ngày tạo",
                                "titleRight": AppFunction.formatDateTimeFromApi(provider.listStaff[index].createdAt),
                              },
                              {
                                "titleLeft": "Trạng thái",
                                "isStatus": true,
                                "titleRight":
                                    provider.listStaff[index].status == "active" ? "Đang hoạt động" : "Ngưng hoạt động",
                              },
                            ],
                            onTapDelete: () => deleteDialog(context, provider.listStaff[index].id),
                            onTapEdit: () => navigateEdit(contextScreen, provider.listStaff[index].id),
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
    final result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => EditInformationStaffScreen(id: id))) as bool?;
    if (result == true) {
      if (context.mounted) {
        context
            .read<UserProvider>()
            .fetchStaffs(context)
            .then((value) => AppFunction.showDialogSuccess(context, content: "Chỉnh sửa thành công"));
      }
    }
  }

  void deleteDialog(BuildContext context, int? id) => AppFunction.showDialogAlert(context,
      title: "Xóa nhân viên",
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
            "Bạn có chắc chắn muốn xóa nhân viên này không?",
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
    context.read<UserProvider>().deleteStaff(context, id).then((value) {
      AppFunction.hideLoading(context);
      if (value == true) {
        context.read<UserProvider>().fetchStaffs(context);
      }
    });
  }

  Widget buildEmptyUi() => const Center(
        child: BlankPage(
          title: "Không có nhân viên nào",
          content: "",
        ),
      );

  Widget buildLoadingUi() => const Center(
        child: CircularProgressIndicator(
          color: AppThemes.red0,
        ),
      );
}
