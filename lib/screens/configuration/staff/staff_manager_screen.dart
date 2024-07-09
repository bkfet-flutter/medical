import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/provider/user_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/screens/configuration/staff/list_staff.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/utils/extension.dart';
import 'package:mephar_app/widgets/mephar_floating_action_button.dart';
import 'package:provider/provider.dart';

class StaffManagerScreen extends BaseScreen {
  const StaffManagerScreen({super.key});

  @override
  StaffManagerScreenState createState() => StaffManagerScreenState();
}

class StaffManagerScreenState extends BaseState<StaffManagerScreen> with BaseScreenMixin {
  @override
  String setTitle() {
    return "Quản lý nhân viên";
  }

  @override
  Widget? buildRightWidget() {
    return const SizedBox();
  }

  @override
  void afterFirstLayout(BuildContext context) => context.read<UserProvider>().fetchStaffs(context);

  @override
  Widget buildBody(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, branch, child) {
        return Scaffold(
            backgroundColor: const Color(0xffF3FAFF),
            floatingActionButton: MepharFloatingActionButton(onPressed: () => navigateAdd(context), heroTag: 'add staff',),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  child: Text(
                    "Danh sách nhân viên",
                    style: AppFonts.bold(
                      18,
                      AppThemes.dark1,
                    ),
                  ),
                ),
                const Expanded(
                  child: ListStaff(),
                ),
              ].addBetween(const SizedBox(height: 16), bound: true),
            ));
      },
    );
  }

  void navigateAdd(BuildContext context) async {
    final checkAdd = await Navigator.pushNamed(
      context,
      AppRoutes.addNewStaffScreen,
    ) as bool?;
    if (checkAdd == true) {
      if (context.mounted) {
        context
            .read<UserProvider>()
            .fetchStaffs(context)
            .then((value) => AppFunction.showDialogSuccess(context, content: "Thêm mới nhân viên thành công"));
      }
    }
  }
}
