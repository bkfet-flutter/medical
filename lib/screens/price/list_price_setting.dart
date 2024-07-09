import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/provider/product/price_setting_provider.dart';
import 'package:mephar_app/screens/price/card_price_setting.dart';
import 'package:mephar_app/widgets/blank_page.dart';
import 'package:provider/provider.dart';

class ListPriceSetting extends StatefulWidget {
  const ListPriceSetting({super.key});

  @override
  State<ListPriceSetting> createState() => _ListPriceSettingState();
}

class _ListPriceSettingState extends State<ListPriceSetting> {
  @override
  Widget build(BuildContext contextScreen) {
    return Consumer<PriceSettingProvider>(builder: (context, provider, child) {
      return provider.loading
          ? buildLoadingUi()
          : provider.listSetting.isEmpty
              ? buildEmptyUi()
              : ListView.separated(
                  itemCount: provider.listSetting.length + 1,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  itemBuilder: (BuildContext context, int index) {
                    return (index < provider.listSetting.length)
                        ? CardPriceSetting(priceSettingsModel: provider.listSetting[index])
                        : const SizedBox(height: 80);
                  },
                  separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 12),
                );
    });
  }

  // Future<void> navigateEdit(BuildContext context, int? id) async {
  //   final result = await Navigator.of(context)
  //       .push(MaterialPageRoute(builder: (context) => EditInformationStaffScreen(id: id))) as bool?;
  //   if (result == true) {
  //     if (context.mounted) {
  //       context
  //           .read<UserProvider>()
  //           .fetchUsers(context)
  //           .then((value) => AppFunction.showDialogSuccess(context, content: "Chỉnh sửa thành công"));
  //     }
  //   }
  // }

  //
  // void deleteDialog(BuildContext context, int? id) => AppFunction.showDialogAlert(context,
  //     title: "Xóa nhân viên",
  //     styleTitle: AppFonts.bold(20, AppThemes.dark0),
  //     showBtnClose: true,
  //     widgetDescription: Column(
  //       children: [
  //         const SizedBox(
  //           height: 24,
  //         ),
  //         Image.asset(
  //           AppImages.boyQuestion,
  //           height: 120,
  //           width: 120,
  //           fit: BoxFit.cover,
  //         ),
  //         const SizedBox(
  //           height: 24,
  //         ),
  //         Text(
  //           "Bạn có chắc chắn muốn xóa nhân viên này không?",
  //           textAlign: TextAlign.center,
  //           style: AppFonts.light(
  //             16,
  //             AppThemes.dark2,
  //           ),
  //         ),
  //         const SizedBox(
  //           height: 24,
  //         )
  //       ],
  //     ),
  //     text1stButton: "Hủy",
  //     isTwoButton: true,
  //     onPress1stButton: () {
  //       Navigator.of(context, rootNavigator: true).pop();
  //     },
  //     text2ndButton: "Xóa",
  //     onPress2ndButton: () {
  //       Navigator.of(context, rootNavigator: true).pop();
  //       delete(context, id);
  //     });
  //
  // delete(BuildContext context, int? id) {
  //   AppFunction.showLoading(context);
  //   context.read<UserProvider>().deleteUser(context, id).then((value) {
  //     AppFunction.hideLoading(context);
  //     if (value == true) {
  //       context.read<UserProvider>().fetchUsers(context);
  //     }
  //   });
  // }

  Widget buildEmptyUi() => const Center(
        child: BlankPage(
          title: "No data",
          content: "",
        ),
      );

  Widget buildLoadingUi() => const Center(
        child: CircularProgressIndicator(
          color: AppThemes.red0,
        ),
      );
}
