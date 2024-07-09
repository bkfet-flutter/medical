import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/model/inbound_model.dart';
import 'package:mephar_app/provider/product/import_product_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/dropdown_unit.dart';
import 'package:mephar_app/widgets/line_separator.dart';
import 'package:mephar_app/widgets/row_in_card_product.dart';
import 'package:provider/provider.dart';

class CardProductCheck3 extends StatefulWidget {
  final int numberCard;
  final bool noClose;
  final bool haveIcon;
  final bool isCheck;
  final bool hideItems;
  final void Function()? onTapClose;
  final InboundModel inboundModel;

  const CardProductCheck3({
    super.key,
    required this.numberCard,
    this.haveIcon = false,
    this.noClose = false,
    this.isCheck = false,
    this.hideItems = false,
    required this.inboundModel,
    this.onTapClose,
  });

  @override
  State<CardProductCheck3> createState() => _CardProductCheck3State();
}

class _CardProductCheck3State extends State<CardProductCheck3> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(bottom: 12, right: 20, left: 20, top: 0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: const Color(0xff606170).withOpacity(0.16),
                offset: const Offset(0, 16),
                blurRadius: 24,
                spreadRadius: 0),
            BoxShadow(
                color: const Color(0xff28293D).withOpacity(0.04),
                offset: const Offset(0, 2),
                blurRadius: 8,
                spreadRadius: 0),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(
                  top: 20, right: 20, left: 20, bottom: 2),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text("${widget.numberCard + 1}",
                        style: AppFonts.normalBold(
                          14,
                          AppThemes.dark1,
                        )),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () => context
                          .read<ImportProductProvider>()
                          .removeIndex(widget.numberCard),
                      child: const Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.close,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                  )
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                RowInCardProduct(
                  titleLeft: 'Mã hàng',
                  titleRight: widget.inboundModel.product?.code,
                ),
                RowInCardProduct(
                  titleLeft: 'Tên hàng',
                  titleRight: widget.inboundModel.product?.name,
                ),
                widget.hideItems
                    ? const SizedBox.shrink()
                    : RowInCardProduct(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        cross: CrossAxisAlignment.center,
                        flex: 3,
                        titleLeft: 'Liều dùng',
                        isWidget: true,
                        widgetRight: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: width * 0.4,
                            padding: const EdgeInsets.only(
                                left: 10, bottom: 10, right: 10, top: 10),
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: const Border.fromBorderSide(
                                  BorderSide(
                                      width: 1,
                                      color: Color(0xffC7C9D9),
                                      style: BorderStyle.solid),
                                )),
                            child: TextFormField(
                              // onChanged: (value) => context
                              //     .read<ImportProductProvider>()
                              //     .totalAmount(numberCard),
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero),
                              controller: widget.inboundModel.dosageController,
                              // keyboardType: TextInputType.number,
                            ),
                          ),
                        )),
                RowInCardProduct(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  cross: CrossAxisAlignment.center,
                  flex: 3,
                  titleLeft: 'Đơn vị',
                  isWidget: true,
                  widgetRight: Align(
                    alignment: Alignment.centerRight,
                    child: DropdownUnitButton(
                      listItems: widget.inboundModel.unit!,
                      onChange: (value) {
                        setState(() {
                          widget.inboundModel.priceUnitController?.text =
                              value!.price.toString();
                          widget.inboundModel.productUnitId = value!.id;
                        });
                        print(value!.price);
                        print(widget.inboundModel.priceUnitController?.text);
                      },
                    ),
                  ),
                ),
                RowInCardProduct(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    cross: CrossAxisAlignment.center,
                    flex: 3,
                    titleLeft: 'Số lượng',
                    isWidget: true,
                    widgetRight: Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: width * 0.4,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  if (widget.inboundModel.quantityController !=
                                          null &&
                                      AppFunction.textToInt(widget.inboundModel
                                              .quantityController) >
                                          1) {
                                    widget.inboundModel.quantityController
                                        ?.text = (AppFunction.textToInt(widget
                                                .inboundModel
                                                .quantityController) -
                                            1)
                                        .toString();
                                  }
                                  // context
                                  //     .read<ImportProductProvider>()
                                  //     .totalAmountNoDiscount(widget.numberCard);
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  size: 16,
                                  color: AppThemes.kPrimary,
                                )),
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: const Border.fromBorderSide(
                                      BorderSide(
                                          width: 1,
                                          color: Color(0xffC7C9D9),
                                          style: BorderStyle.solid),
                                    )),
                                child: TextFormField(
                                  // onChanged: (value) => context
                                  //     .read<ImportProductProvider>()
                                  //     .totalAmountNoDiscount(widget.numberCard),
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero),
                                  controller:
                                      widget.inboundModel.quantityController,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  if (widget.inboundModel.quantityController !=
                                      null) {
                                    widget.inboundModel.quantityController
                                        ?.text = (AppFunction.textToInt(widget
                                                .inboundModel
                                                .quantityController) +
                                            1)
                                        .toString();
                                  }
                                  // context
                                  //     .read<ImportProductProvider>()
                                  //     .totalAmountNoDiscount(widget.numberCard);
                                },
                                icon: const Icon(
                                  Icons.add,
                                  size: 16,
                                  color: AppThemes.kPrimary,
                                )),
                          ],
                        ),
                      ),
                    )),
                RowInCardProduct(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  cross: CrossAxisAlignment.center,
                  flex: 3,
                  titleLeft: 'Đơn giá',
                  isWidget: true,
                  widgetRight: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: width * 0.4,
                      padding: const EdgeInsets.only(
                          left: 10, bottom: 10, right: 10, top: 10),
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: const Border.fromBorderSide(
                            BorderSide(
                                width: 1,
                                color: Color(0xffC7C9D9),
                                style: BorderStyle.solid),
                          )),
                      child: TextFormField(
                        onChanged: (value) {},
                        textAlign: TextAlign.center,
                        readOnly: true,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero),
                        controller: widget.inboundModel.priceUnitController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: const LineSeparator(
                    color: Colors.grey,
                    height: 1,
                  ),
                ),
                RowInCardProduct(
                    padding: const EdgeInsets.only(
                        bottom: 20, left: 20, right: 20, top: 20),
                    titleLeft: 'Thành tiền',
                    titleRight: AppFunction.totalAmountNoDiscount(
                      widget.inboundModel.quantityController,
                      widget.inboundModel.priceUnitController,
                    ).toString())
              ],
            ),
          ),
        ],
      ),
    );
  }
}
