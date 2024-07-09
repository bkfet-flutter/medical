import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/mephar_picker_datetime.dart';
import 'package:mephar_app/widgets/mephar_textfield.dart';
import 'package:provider/provider.dart';

class CreateNewBatchScreen extends BaseScreen {
  final int? productId;

  const CreateNewBatchScreen(this.productId, {Key? key}) : super(key: key);

  @override
  CreateNewBatchScreenState createState() => CreateNewBatchScreenState();
}

class CreateNewBatchScreenState extends BaseState<CreateNewBatchScreen>
    with BaseScreenMixin {
  TextEditingController batch = TextEditingController();
  TextEditingController quantity = TextEditingController(text: '1');
  String? errorText;
  DateTime hsd = DateTime.now();

  @override
  Color setMainBackgroundColor() => Colors.white;

  @override
  String setTitle() => "Thêm mới lô";

  @override
  buildRightWidget() => const SizedBox.shrink();

  @override
  Widget buildBody(BuildContext context) {
    return Consumer<BranchProvider>(builder: (context, provider, child) {
      return Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text('Lô',
                                style: AppFonts.regular(14, AppThemes.dark1)),
                          )),
                      Expanded(
                        flex: 3,
                        child: Align(
                          alignment: Alignment.center,
                          child: MepharTextfield(
                              axis: TextDirection.ltr,
                              vert: TextAlignVertical.center,
                              align: TextAlign.right,
                              hintText: '',
                              controller: batch),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 11),
                                child: Text('Hạn sử dụng',
                                    style: AppFonts.regular(
                                        14, AppThemes.dark1)))),
                        Expanded(
                          flex: 3,
                          child: Align(
                            alignment: Alignment.center,
                            child: MepharPickerDatetime(
                              minTime: DateTime.now(),
                              bgColor: Colors.white,
                              onDateTimeChanged: (value) {
                                setState(() {
                                  hsd = value;
                                });
                              },
                              icon: AppImages.iconCalendar,
                              labelText: '',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text('Số lượng',
                              style: AppFonts.regular(14, AppThemes.dark1)),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                int parse = int.tryParse(quantity.text) ?? 0;
                                parse = parse - 1;
                                quantity.text = parse.toString();
                                // search.minusValue = int.tryParse(
                                //     search.searchList[widget.index].listBatch.toList()[index].cList.text) ??
                                //     0;
                                // search.minusValue -= 1;
                                // if (search.minusValue <= 0) {
                                //   search.minusValue = 0;
                                // }
                                // search.searchList[widget.index].listBatch.toList()[index].cList.text =
                                //     search.minusValue.toString();
                              },
                              child: const Icon(
                                Icons.remove,
                                color: Colors.blue,
                                size: 20,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 10, bottom: 10, right: 10, top: 10),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: const Border.fromBorderSide(
                                    BorderSide(
                                      width: 1,
                                      color: Color(0xffC7C9D9),
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                ),
                                child: TextFormField(
                                  textAlignVertical: TextAlignVertical.center,
                                  onChanged: (value) {},
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  controller: quantity,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  int parse = int.tryParse(quantity.text) ?? 0;
                                  parse = parse + 1;
                                  quantity.text = parse.toString();
                                });
                                // search.minusValue = int.tryParse(
                                //     search.searchList[widget.index].listBatch.toList()[index].cList.text) ??
                                //     0;
                                // search.minusValue += 1;
                                // search.searchList[widget.index].listBatch.toList()[index].cList.text =
                                //     search.minusValue.toString();
                              },
                              child: const Icon(
                                Icons.add,
                                color: Colors.blue,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: MepharButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    isButtonWhite: true,
                    titleButton: 'Hủy',
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                Expanded(
                  flex: 6,
                  child: MepharButton(
                    onPressed: () async => createBatch(context,
                        branchId: provider.defaultBranch?.id),
                    isButtonWhite: false,
                    titleButton: 'Thêm mới lô',
                  ),
                ),
              ],
            ),
          )
        ],
      );
    });
  }

  bool validate(BuildContext context) {
    if (AppFunction.isNullOrEmpty(batch.text)) {
      AppFunction.showDialogError(context, "Tên lô là bắt buộc");
      return false;
    }
    return true;
  }

  Future createBatch(BuildContext context, {int? branchId}) async {
    AppFunction.hideKeyboard(context);
    if (branchId != null && validate(context)) {
      AppFunction.showLoading(context);
      ApiResponse response = await ApiRequest.batchCreate(
          branchId: branchId,
          productId: widget.productId!,
          quantity: int.parse(quantity.text),
          name: batch.text,
          expiryDate: AppFunction.formatDate(hsd));
      if (response.result == true && context.mounted) {
        AppFunction.hideLoading(context);
        AppFunction.showDialogAlert(context,
            customImage: Image.asset(
              AppImages.notiSuccess,
              width: 116,
              height: 120,
              fit: BoxFit.cover,
            ),
            noDivider: true,
            showBtnClose: false,
            hideBtnBottom: false,
            text1stButton: 'OK', onPress1stButton: () {
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.pop(context, true);
        },
            styleTitle: AppFonts.normalBoldInter(
              20,
              AppThemes.red0,
            ),
            title: "Thông báo",
            styleDescription: AppFonts.light(
              16,
              AppThemes.dark1,
            ),
            imageClose: AppImages.closeNormal,
            description: "Thêm mới thành công");
      } else if (context.mounted) {
        AppFunction.hideLoading(context);
        AppFunction.showDialogAlert(context,
            customImage: Image.asset(
              AppImages.notiFail,
              width: 116,
              height: 120,
              fit: BoxFit.cover,
            ),
            noDivider: true,
            showBtnClose: false,
            hideBtnBottom: false,
            text1stButton: 'OK', onPress1stButton: () {
          Navigator.of(context, rootNavigator: true).pop();
        },
            styleTitle: AppFonts.normalBoldInter(
              20,
              AppThemes.red0,
            ),
            title: "Thông báo",
            styleDescription: AppFonts.light(
              16,
              AppThemes.dark1,
            ),
            imageClose: AppImages.closeNormal,
            description: response.message);
      }
    }
  }
}
