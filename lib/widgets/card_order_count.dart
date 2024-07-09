import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/model/inbound_model.dart';
import 'package:mephar_app/model/product_model.dart';
import 'package:mephar_app/provider/sell_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/dropdown_unit.dart';
import 'package:provider/provider.dart';
import 'card_product_check.dart';
import 'normal_text.dart';

class CardOrderCount extends StatelessWidget {
  const CardOrderCount({
    super.key,
    required this.model,
    this.isShowUnit = false,
  });

  final InboundModel model;

  final bool? isShowUnit;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 12, 12),
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppThemes.light0))),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  '${model.product?.name ?? ""} - [${model.unitName ?? ""}]',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppFonts.normalBold(
                    16,
                    AppThemes.dark2,
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: _buildButtonIcon(
                          onTap: () => context.read<SellProvider>().removeValue(model), icon: Icons.close)))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "SKU: ${model.code}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppFonts.regular(
                      14,
                      AppThemes.dark3,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(children: [
                    _buildButtonIcon(
                        onTap: () {
                          if (model.quantityController != null && AppFunction.textToInt(model.quantityController) > 1) {
                            model.quantityController?.text =
                                (AppFunction.textToInt(model.quantityController) - 1).toString();
                          }
                          context.read<SellProvider>().getTotal();
                        },
                        icon: Icons.remove),
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: const Border.fromBorderSide(
                              BorderSide(width: 1, color: Color(0xffC7C9D9), style: BorderStyle.solid),
                            )),
                        child: TextFormField(
                          onChanged: (value) => context.read<SellProvider>().getTotal(),
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                              border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero),
                          controller: model.quantityController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    _buildButtonIcon(
                        onTap: () {
                          if (model.quantityController != null) {
                            model.quantityController?.text =
                                (AppFunction.textToInt(model.quantityController) + 1).toString();
                          }
                          context.read<SellProvider>().getTotal();
                        },
                        icon: Icons.add)
                  ]),
                ),
              ],
            ),
          ),
          isShowUnit == true
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Đơn vị thuốc",
                      style: AppFonts.regular(
                        14,
                        AppThemes.dark3,
                      ),
                    ),
                    SizedBox(
                      width: 80,
                      child: DropdownUnitButton(
                        listItems: model.unit as List<ProductUnit>,
                        onChange: (value) {
                          context.read<SellProvider>().productUnitId = value!.id!;
                        },
                      ),
                    )
                  ],
                )
              : const SizedBox.shrink(),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${AppFunction.formatNum(model.price)}đ',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppFonts.bold(
                    16,
                    AppThemes.dark1,
                  ),
                ),
              ),
              if (model.product?.isBatchExpireControl == true)
                Flexible(
                    flex: 1,
                    child: model.batchesForSale!.every((element) => element.isSelected == false)
                        ? GestureDetector(
                            onTap: () {
                              AppFunction.showDialogAlert(context,
                                  isTwoButton: true, dismiss: true, title: "Lô sản phẩm", text1stButton: "Đóng",
                                  widgetDescription: Consumer<SellProvider>(builder: (context, provider, child) {
                                return BodyDialog(
                                  list: model.batchesForSale,
                                  select: (value) => provider.selectBatch(value),
                                );
                              }), onPress2ndButton: () {
                                List<BatchForSale>? list =
                                    model.batchesForSale?.where((e) => e.isSelected == true).toList();
                                if (list != null) {
                                  model.quantityController?.text = list
                                      .fold(
                                          0,
                                          (previousValue, element) =>
                                              previousValue + AppFunction.textToInt(element.batchQuantityController))
                                      .toString();
                                }
                                context.read<SellProvider>().getTotal();
                                Navigator.of(context, rootNavigator: true).pop();
                              }, text2ndButton: "Lưu");
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.centerRight,
                              child: const Text(
                                'Chọn lô',
                                textAlign: TextAlign.right,
                                style: TextStyle(color: Color(0xFFEE0033), fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                          )
                        : Wrap(
                            crossAxisAlignment: WrapCrossAlignment.end,
                            alignment: WrapAlignment.end,
                            spacing: 10,
                            runSpacing: 5,
                            children: model.batchesForSale!.where((element) => element.isSelected == true).map((e) {
                              return Container(
                                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  border: Border.all(color: Colors.grey, width: 1),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: NormalText(
                                        '${e.name ?? ''}-${AppFunction.formatDateTimeFromApi(e.expiryDate ?? '')}-SL: ${(AppFunction.textToInt(e.batchQuantityController))}',
                                        maxFontSize: 14,
                                        minFontSize: 10,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () => context.read<SellProvider>().selectBatch(e),
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }).toList(),
                          ))
            ],
          ),
        ]));
  }

  Widget _buildButtonIcon({required void Function() onTap, required IconData icon}) {
    return GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            size: 16,
            color: AppThemes.kPrimary,
          ),
        ));
  }
}

class BodyDialog extends StatelessWidget {
  final List<BatchForSale>? list;
  final void Function(BatchForSale) select;

  const BodyDialog({super.key, required this.list, required this.select});

  @override
  Widget build(BuildContext context) {
    return list == null
        ? const SizedBox.shrink()
        : Column(
            children: List.generate(
                list!.length,
                (index) =>
                    CardBatch(tapCheck: (value) => select(value), batchForSale: list![index], numberCard: index)),
          );
  }
}

class CardBatch extends StatelessWidget {
  final BatchForSale batchForSale;
  final int numberCard;
  final void Function(BatchForSale) tapCheck;

  const CardBatch({super.key, required this.batchForSale, required this.numberCard, required this.tapCheck});

  @override
  Widget build(BuildContext context) {
    return CardProductCheck(
        numberCard: numberCard,
        isCheck: batchForSale.isSelected,
        onTapCheckBox: () => tapCheck(batchForSale),
        listData: [
          {
            "titleLeft": "Tên",
            "titleRight": batchForSale.name,
          },
          {
            "titleLeft": "Hạn sử dụng",
            "titleRight": batchForSale.expiryDate,
          },
          {
            "titleLeft": "Số lượng",
            "widgetRight": Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: const Border.fromBorderSide(
                    BorderSide(width: 1, color: Color(0xffC7C9D9), style: BorderStyle.solid),
                  )),
              child: TextFormField(
                onChanged: (value) {},
                textAlign: TextAlign.center,
                decoration:
                    const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero),
                controller: batchForSale.batchQuantityController,
                keyboardType: TextInputType.number,
              ),
            ),
            "isWidget": true,
          },
          {
            "titleLeft": "Số lượng tồn",
            "titleRight": batchForSale.quantity.toString(),
            "isFinal": true,
          },
        ],
        onPressed: () {});
  }
}
