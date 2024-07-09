import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/app/constant.dart';
import 'package:mephar_app/model/config/permission_model.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/mephar_checkbox.dart';
import 'package:mephar_app/widgets/mephar_textfield.dart';

class AddNewRoleScreen extends BaseScreen {
  const AddNewRoleScreen({super.key});

  @override
  AddNewRoleScreenState createState() => AddNewRoleScreenState();
}

class AddNewRoleScreenState extends BaseState<AddNewRoleScreen> with BaseScreenMixin {
  @override
  String setTitle() => "Thêm mới vai trò";

  @override
  Color setMainBackgroundColor() => AppThemes.blueBackground;

  @override
  Widget? buildRightWidget() => const SizedBox.shrink();

  TextEditingController nameController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  String get name => nameController.text;

  String get note => noteController.text;

  final List<Permissions> _list = [];
  Map<int, TableColumnWidth> columnWidths = {
    0: const FlexColumnWidth(2),
    1: const FlexColumnWidth(1),
  };

  void _initList() {
    _list.addAll(AppConstant.mapPermission.map((e) => Permissions.fromJson(e)));
    int numberOfActions = _list.where((element) => element.action != null).map((e) => e.action).toSet().length;
    for (int i = 0; i < numberOfActions; i++) {
      columnWidths[i + 2] = const FlexColumnWidth(1);
    }
    setState(() {});
  }

  @override
  void afterFirstLayout(BuildContext context) => _initList();

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      MepharTextfield(
                        hintText: "Tên vai trò*",
                        controller: nameController,
                      ),
                      MepharTextfield(
                        hintText: "Ghi chú",
                        controller: noteController,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: columnWidths,
                    children: [
                      TableRow(children: [
                        _buildText("Phân quyền", left: true),
                        _buildText("Tất cả"),
                        ..._list
                            .where((element) => element.action != null)
                            .map((permission) => permission.action)
                            .toSet()
                            .map((e) => _buildText(AppConstant.mapSub[e]))
                            .toList()
                      ]),
                      ..._list.map((permission) => permission.model).toSet().map((label) => TableRow(children: [
                            Text(
                              AppConstant.mapSub[label] ?? label.toString(),
                              style: TextStyle(
                                  fontFamily: AppFonts.laTo,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: _checkParentId(label.toString()).isEmpty ? AppThemes.dark0 : AppThemes.red0),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: MepharCheckbox(
                                isChecked: _checkParentId(label.toString()).isEmpty
                                    ? _list.where((element) => element.model == label).every((e) => e.select == true)
                                    : _list
                                        .where((element) => element.parentId == label)
                                        .every((e) => e.select == true),
                                onlyCheckBox: true,
                                onTap: () {
                                  List<Permissions> parent = _checkParentId(label.toString());
                                  if (parent.isNotEmpty) {
                                    bool shouldSelectAll = !_list
                                        .where((element) => element.parentId == parent.first.model)
                                        .every((e) => e.select == true);
                                    _list.where((element) => element.parentId == parent.first.model).forEach((element) {
                                      element.select = shouldSelectAll;
                                    });
                                    setState(() {});
                                  }
                                  bool shouldSelectAll =
                                      !_list.where((element) => element.model == label).every((e) => e.select == true);
                                  _list.where((element) => element.model == label).forEach((element) {
                                    element.select = shouldSelectAll;
                                  });
                                  setState(() {});
                                },
                              ),
                            ),
                            ..._list.where((element) => element.model == label && element.action != null).map(
                                  (e) => Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.symmetric(vertical: 8),
                                    child: MepharCheckbox(
                                        isChecked: e.select ?? false,
                                        onlyCheckBox: true,
                                        onTap: () => setState(() => e.select = !(e.select ?? false))),
                                  ),
                                ),
                            ...List.generate(
                                columnWidths.length -
                                    2 -
                                    _list.where((element) => element.model == label && element.action != null).length,
                                (index) => Container(
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.symmetric(vertical: 8),
                                      child: const SizedBox(
                                        width: 16,
                                        height: 16,
                                      ),
                                    ))
                          ]))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.spaceMediumLarge),
            child: MepharButton(
              titleButton: "Lưu",
              onPressed: () => _save(context),
            ),
          ),
        ),
      ],
    );
  }

  void _save(BuildContext context) async {
    AppFunction.hideKeyboard(context);
    if (name.trim().isEmpty) {
      return AppFunction.showDialogError(context, "Tên vai trò là bắt buộc");
    } else {
      AppFunction.showLoading(context);
      var res = await ApiRequest.roleCreate(
          permissionModel: PermissionModel(
              name: name,
              description: note,
              permissions: _list.where((element) => element.select == true && element.action != null).toList()));
      if (res.result == true && context.mounted) {
        AppFunction.hideLoading(context);
        Navigator.pop(context, true);
      } else {
        if (context.mounted) {
          AppFunction.hideLoading(context);
          AppFunction.showDialogError(context, res.message);
        }
      }
    }
  }

  _buildText(String? text, {bool? left}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text ?? "",
        textAlign: left == true ? TextAlign.left : TextAlign.center,
        style: AppFonts.normalBold(
          13,
          AppThemes.dark1,
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    noteController.dispose();
    super.dispose();
  }

  List<Permissions> _checkParentId(String model) {
    List<Permissions> result = _list.where((element) => element.model == model).toList();
    List<Permissions> noParent = result.where((element) => element.parentId == null && element.action == null).toList();
    return noParent;
  }
}
