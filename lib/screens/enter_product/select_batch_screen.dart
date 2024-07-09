import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/model/batch_model.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/screens/enter_product/create_new_batch.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/app_search_bar.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/normal_text.dart';

class SelectBatchScreen extends BaseScreen {
  final int productId;
  final List<BatchModel> copyList;

  const SelectBatchScreen(
    this.productId, {
    required this.copyList,
    Key? key,
  }) : super(key: key);

  @override
  SelectBatchScreenState createState() => SelectBatchScreenState();
}

class SelectBatchScreenState extends BaseState<SelectBatchScreen> with BaseScreenMixin {
  List<BatchModel> batchesSelected = [];
  TextEditingController keywordController = TextEditingController();

  @override
  buildRightWidget() => const SizedBox.shrink();

  @override
  setOnPressLeftButton() => Navigator.of(context).pop();

  @override
  String setTitle() => 'Chọn lô sản phẩm';

  callApi() {
    batchesSelected.addAll(widget.copyList);
    setState(() {});
  }

  @override
  void afterFirstLayout(BuildContext context) => callApi();

  @override
  Color setMainBackgroundColor() => AppThemes.white;

  @override
  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 20, right: 10, left: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Chọn lô',
                        style: AppFonts.normalBoldInter(15, Colors.black),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: AppSearchBar(
                          filled: true,
                          controller: keywordController,
                          onSuggestionSelected: (item) {
                            if (batchesSelected.isEmpty || !batchesSelected.any((e) => e.id == item.id)) {
                              setState(() {
                                batchesSelected.add(item);
                              });
                            }
                            keywordController.clear();
                          },
                          suggestionsCallback: (String keyword) async {
                            List<BatchModel> items = [];
                            var res = await ApiRequest.batches(context, productId: widget.productId, keyword: keyword);
                            if (res.result == true) {
                              for (var e in res.data["items"]) {
                                items.add(BatchModel.fromJson(e));
                              }
                            }
                            return items;
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(2),
                      2: FlexColumnWidth(2),
                      3: FlexColumnWidth(3),
                      4: FlexColumnWidth(2),
                      5: FlexColumnWidth(1),
                    },
                    children: [
                      TableRow(
                          decoration: BoxDecoration(
                            color: Colors.blue.shade200,
                          ),
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                              child: Text("STT",
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                              child: Text("Tên Lô",
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                              child: Text(
                                maxLines: 1,
                                "Hạn SD",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                              child: const Text(
                                maxLines: 1,
                                "Số lượng",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                              child: Text("Tồn kho",
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                              child: SizedBox.shrink(),
                            ),
                          ]),
                      if (batchesSelected.isNotEmpty)
                        ...List.generate(
                            batchesSelected.length,
                            (index) => TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                                    child: NormalText("${index + 1}",
                                        maxLines: 1,
                                        minFontSize: 10,
                                        maxFontSize: 14,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                                    child: Text(
                                        maxLines: 2,
                                        batchesSelected[index].name ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                                    child: Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      AppFunction.formatDateString(batchesSelected[index].expiryDate ?? ''),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (batchesSelected[index].quantityController != null &&
                                                AppFunction.textToInt(batchesSelected[index].quantityController) > 1) {
                                              batchesSelected[index].quantityController?.text =
                                                  (AppFunction.textToInt(batchesSelected[index].quantityController) - 1)
                                                      .toString();
                                            }
                                          });
                                        },
                                        child: const Icon(
                                          Icons.remove,
                                          color: Colors.blue,
                                          size: 20,
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(vertical: 10),
                                          padding: const EdgeInsets.all(10),
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
                                            controller: batchesSelected[index].quantityController,
                                            onChanged: (value) {},
                                            textAlign: TextAlign.center,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                            ),
                                            // controller: copyList[index].cList,
                                            keyboardType: TextInputType.number,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (batchesSelected[index].quantityController != null) {
                                              batchesSelected[index].quantityController?.text =
                                                  (AppFunction.textToInt(batchesSelected[index].quantityController) + 1)
                                                      .toString();
                                            }
                                          });
                                        },
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.blue,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                                    child: Text(
                                        maxLines: 1,
                                        batchesSelected[index].quantity.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          batchesSelected.removeAt(index);
                                        });
                                      },
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: Image.asset(AppImages.iconTrashRed),
                                      ),
                                    ),
                                  ),
                                ])),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
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
                  child: MepharButton(
                    onPressed: () async {
                      final result = await Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) => CreateNewBatchScreen(widget.productId)));
                      if (result == true && context.mounted) {
                        //  provider.fetchBatches(context, productId: widget.productId);
                      }
                    },
                    isButtonWhite: true,
                    titleButton: 'Thêm mới lô',
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: MepharButton(
                    onPressed: () {
                      print(batchesSelected.length);
                      AppFunction.hideKeyboard(context);
                      Navigator.pop(context, batchesSelected);
                    },
                    isButtonWhite: false,
                    titleButton: 'Lưu',
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
