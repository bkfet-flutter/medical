import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/provider/role_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/screens/configuration/delegation/edit_permission_screen.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/card_detail_product.dart';
import 'package:mephar_app/widgets/mephar_floating_action_button.dart';
import 'package:provider/provider.dart';

class DelegationRoleScreen extends BaseScreen {
  const DelegationRoleScreen({super.key});

  @override
  DelegationRoleScreenState createState() => DelegationRoleScreenState();
}

class DelegationRoleScreenState extends BaseState<DelegationRoleScreen> with BaseScreenMixin {
  @override
  String setTitle() => "Danh sách vai trò";

  @override
  Widget? buildRightWidget() => const SizedBox.shrink();




  void navigateAdd(BuildContext context) async {
    final checkAdd = await Navigator.pushNamed(
      context,
      AppRoutes.addNewRoleScreen,
    ) as bool?;
    if (checkAdd == true) {
      if (context.mounted) {
        context
            .read<RoleProvider>()
            .fetchRoles(context)
            .then((value) => AppFunction.showDialogSuccess(context, content: "Thêm mới vai trò thành công"));
      }
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => context.read<RoleProvider>().fetchRoles(context);

  @override
  Widget buildBody(BuildContext context) {
    return Scaffold(
      floatingActionButton: MepharFloatingActionButton(onPressed: () => navigateAdd(context), heroTag: 'add role',),
      backgroundColor: AppThemes.blueBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Danh sách nhân viên",
                  style: AppFonts.bold(
                    18,
                    AppThemes.dark1,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Consumer<RoleProvider>(builder: (context, role, child) {
                return Column(
                  children: [
                    ...List.generate(
                        role.listRole.length,
                        (index) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: CardDetailProduct(
                                listData: [
                                  {
                                    "titleLeft": "Vai trò",
                                    "titleRight": role.listRole[index].name,
                                  },
                                  {
                                    "titleLeft": "Ghi chú",
                                    "titleRight": role.listRole[index].description,
                                  },
                                  {
                                    "titleLeft": "Ngày tạo",
                                    "titleRight": AppFunction.formatDateTimeFromApi(role.listRole[index].createdAt),
                                  },
                                  {
                                    "titleLeft": "Thao tác",
                                    "isWidget": true,
                                    "widgetRight": Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            if (role.listRole[index].id != null) {
                                              final checkUpdate = await Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditPermissionScreen(role.listRole[index].id!))) as bool?;

                                              if (checkUpdate == true) {
                                                if (context.mounted) {
                                                  context.read<RoleProvider>().fetchRoles(context).then((value) =>
                                                      AppFunction.showDialogSuccess(context,
                                                          content: "Chỉnh sửa vai trò thành công"));
                                                }
                                              }
                                            }
                                          },
                                          child: Container(
                                            height: 44,
                                            width: 44,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppThemes.blue4,
                                            ),
                                            child: Center(
                                                child: Image.asset(
                                              AppImages.iconPenRed,
                                              height: 24,
                                              width: 24,
                                              fit: BoxFit.fill,
                                            )),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        InkWell(
                                          onTap: () => deleteDialog(context, role.listRole[index].id),
                                          child: Container(
                                            height: 44,
                                            width: 44,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppThemes.blue4,
                                            ),
                                            child: Center(
                                                child: Image.asset(
                                              AppImages.iconTrashGrey,
                                              height: 24,
                                              width: 24,
                                              color: AppThemes.red0,
                                              fit: BoxFit.fill,
                                            )),
                                          ),
                                        ),
                                      ],
                                    ),
                                    "isFinal": true,
                                  },
                                ],
                                haveBorder: true,
                              ),
                            ))
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void deleteDialog(BuildContext context, int? id) => AppFunction.showDialogAlert(context,
      title: "Xóa vai trò",
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
            "Bạn có chắc chắn muốn xóa vai trò này không?",
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
    context.read<RoleProvider>().deleteRole(context, id).then((value) {
      AppFunction.hideLoading(context);
      if (value == true) {
        context.read<RoleProvider>().fetchRoles(context);
      }
    });
  }
}
