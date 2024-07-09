import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/screens/configuration/branch/list_branch.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/utils/extension.dart';
import 'package:mephar_app/widgets/mephar_floating_action_button.dart';
import 'package:provider/provider.dart';

class BranchManagementScreen extends BaseScreen {
  const BranchManagementScreen({super.key});

  @override
  BranchManagementScreenState createState() => BranchManagementScreenState();
}

class BranchManagementScreenState extends BaseState<BranchManagementScreen>
    with BaseScreenMixin {
  @override
  String setTitle() {
    return "Quản lý chi nhánh";
  }

  @override
  Widget? buildRightWidget() {
    return const SizedBox();
  }

  @override
  void afterFirstLayout(BuildContext context) =>
      context.read<BranchProvider>().fetchBranches(context);

  @override
  Widget buildBody(BuildContext context) {
    return Consumer<BranchProvider>(
      builder: (context, branch, child) {
        return Scaffold(
            backgroundColor: const Color(0xffF3FAFF),
            floatingActionButton: MepharFloatingActionButton(
              heroTag: "add branch",
                onPressed: () => navigateAdd(context)),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  child: Text(
                    "Quản lý chi nhánh",
                    style: AppFonts.bold(
                      18,
                      AppThemes.dark1,
                    ),
                  ),
                ),
                const Expanded(
                  child: ListBranch(),
                ),
              ].addBetween(const SizedBox(height: 16), bound: true),
            ));
      },
    );
  }

  void navigateAdd(BuildContext context) async {
    final checkAdd = await Navigator.pushNamed(
      context,
      AppRoutes.addNewBranchScreen,
    ) as bool?;
    if (checkAdd == true) {
      if (context.mounted) {
        context.read<BranchProvider>().fetchBranches(context).then((value) =>
            AppFunction.showDialogSuccess(context,
                content: "Thêm mới chi nhánh thành công"));
      }
    }
  }
}
