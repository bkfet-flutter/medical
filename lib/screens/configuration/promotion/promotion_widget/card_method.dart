import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/model/search_product_model.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/configuration/promotion/promotion_widget/text_form_filed.dart';
import 'package:mephar_app/screens/configuration/promotion/search_api_product.dart';


class CardMethod extends StatefulWidget {
  final TextEditingController? startPriceController;
  final TextEditingController? discountValueController;
  final TextEditingController? discountProductQuantityController;
  final TextEditingController? givenController;
  final TextEditingController? purchaseController;
  final String? index;
  final bool? isVND;
  final String? method;
  final Function()? getIdGiven;
  final Function()? getIdDiscount;
  final Function()? getIdPurchase;
  final void Function()? onTapClose;
  final void Function(String?)? onChangedStartPrice;
  final void Function(String?)? onChangedDiscount;
  final void Function(String?)? onChangedDiscountNum;
  final void Function(String?)? onChangedGiven;
  final void Function(String?)? onChangedPurchaseValue;
  final List<SearchProductModel> listProductGivenSelect;
  final List<SearchProductModel> listProductPurchaseSelect;
  final List<SearchProductModel> listProductDiscountSelect;
  final void Function()? onTapSelectType;

  const CardMethod({
    super.key,
    required this.startPriceController,
    required this.discountValueController,
    this.index,
    this.onTapClose,
    this.isVND,
    this.onTapSelectType,
    this.onChangedStartPrice,
    this.onChangedDiscount,
    this.method,
    required this.listProductGivenSelect,
    this.getIdGiven,
    this.givenController,
    this.onChangedGiven,
    this.purchaseController,
    this.onChangedPurchaseValue,
    required this.listProductPurchaseSelect,
    this.getIdPurchase,
    required this.listProductDiscountSelect,
    this.discountProductQuantityController,
    this.getIdDiscount,
    this.onChangedDiscountNum,
  });

  @override
  State<CardMethod> createState() => _CardMethodState();
}

class _CardMethodState extends State<CardMethod> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: const [
        BoxShadow(offset: Offset(0, 4), blurRadius: 8, spreadRadius: 0, color: Color.fromRGBO(96, 97, 112, 0.16)),
        BoxShadow(offset: Offset(0, 0), blurRadius: 2, spreadRadius: 0, color: Color.fromRGBO(40, 41, 61, 0.04))
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(widget.index ?? "", style: AppFonts.normalBold(14, const Color(0xff28293D))),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: widget.onTapClose,
                child: Image.asset(
                  AppImages.iconClose,
                  width: 16,
                  height: 16,
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          (widget.method == "DISCOUNT_PRODUCT_WHEN_BUY_PRODUCT" || widget.method == "GIFTING_PRODUCT_WHEN_BUY_PRODUCT")
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hàng/Nhóm hàng mua", style: AppFonts.regular(14, const Color(0xff8F90A6))),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 4,
                      runSpacing: 0,
                      children: List.generate(
                          widget.listProductPurchaseSelect.length,
                          (index) => widget.listProductPurchaseSelect.isNotEmpty
                              ? Chip(
                                  label: Text(
                                    widget.listProductPurchaseSelect[index].name ?? "",
                                    style: AppFonts.regular(),
                                  ),
                                  onDeleted: () {
                                    widget.listProductPurchaseSelect.removeAt(index);
                                    setState(() {});
                                  },
                                )
                              : const SizedBox.shrink()),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 2,
                          child: CustomInputFiled(
                            controller: widget.purchaseController,
                            onChanged: widget.onChangedPurchaseValue,

                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 5,
                          child: SearchProduct(
                            select: (value) {
                              if (value == null || widget.listProductPurchaseSelect.contains(value)) {
                              } else {
                                widget.listProductPurchaseSelect.add(value);
                                setState(() {});
                                widget.getIdPurchase?.call();
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    ColumnProduct(
                      title: (widget.method == "GIFTING_PRODUCT_WHEN_BUY_PRODUCT")
                          ? 'Hàng/Nhóm hàng tặng'
                          : 'Hàng/Nhóm hàng được giảm giá',
                      onChanged: (widget.method == "GIFTING_PRODUCT_WHEN_BUY_PRODUCT")
                          ? widget.onChangedGiven
                          : widget.onChangedDiscountNum,
                      controller: (widget.method == "GIFTING_PRODUCT_WHEN_BUY_PRODUCT")
                          ? widget.givenController
                          : widget.discountProductQuantityController,
                      listSelected: (widget.method == "GIFTING_PRODUCT_WHEN_BUY_PRODUCT")
                          ? widget.listProductGivenSelect
                          : widget.listProductDiscountSelect,
                      onSelect: (value) {
                        if (widget.method == "GIFTING_PRODUCT_WHEN_BUY_PRODUCT") {
                          if (value == null || widget.listProductGivenSelect.contains(value)) {
                          } else {
                            widget.listProductGivenSelect.add(value);
                            setState(() {});
                            widget.getIdGiven?.call();
                          }
                        } else {
                          if (value == null || widget.listProductDiscountSelect.contains(value)) {
                          } else {
                            widget.listProductDiscountSelect.add(value);
                            setState(() {});
                            widget.getIdDiscount?.call();
                          }
                        }
                      },
                    )
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Tổng tiền hàng từ", style: AppFonts.regular(14, const Color(0xff8F90A6))),
                    const SizedBox(height: 8),
                    CustomInputFiled(
                      controller: widget.startPriceController,
                      onChanged: widget.onChangedStartPrice,
                    ),
                  ],
                ),
          const SizedBox(height: 16),
          (widget.method == "GIFTING_PRODUCTS")
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hàng/nhóm hàng tặng", style: AppFonts.regular(14, const Color(0xff8F90A6))),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: List.generate(
                          widget.listProductGivenSelect.length,
                          (index) => widget.listProductGivenSelect.isNotEmpty
                              ? Chip(
                                  label: Text(
                                    widget.listProductGivenSelect[index].name ?? "",
                                    style: AppFonts.regular(),
                                  ),
                                  onDeleted: () {
                                    widget.listProductGivenSelect.removeAt(index);
                                    setState(() {});
                                  },
                                )
                              : const SizedBox.shrink()),
                    ),
                    SearchProduct(
                      select: (value) {
                        if (value == null || widget.listProductGivenSelect.contains(value)) {
                        } else {
                          widget.listProductGivenSelect.add(value);
                          setState(() {});
                          widget.getIdGiven?.call();
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    Text("Tặng tổng", style: AppFonts.regular(14, const Color(0xff8F90A6))),
                    const SizedBox(height: 8),
                    CustomInputFiled(
                      controller: widget.givenController,
                      onChanged: widget.onChangedGiven,
                    ),
                  ],
                )
              : (widget.method == "GIFTING_PRODUCT_WHEN_BUY_PRODUCT")
                  ? const SizedBox.shrink()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Giá trị khuyến mại", style: AppFonts.regular(14, const Color(0xff8F90A6))),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: CustomInputFiled(
                                controller: widget.discountValueController,
                                onChanged: widget.onChangedDiscount,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(width: 1, color: AppThemes.light2),
                              ),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: widget.onTapSelectType,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                      decoration: BoxDecoration(
                                          color: (widget.isVND == true) ? AppThemes.kPrimary : AppThemes.white,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(8), bottomLeft: Radius.circular(8))),
                                      child: Text(
                                        "VND",
                                        style: AppFonts.regular(
                                            12, (widget.isVND == true) ? Colors.white : AppThemes.kPrimary),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: widget.onTapSelectType,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                      decoration: BoxDecoration(
                                          color: (widget.isVND == true) ? AppThemes.white : AppThemes.kPrimary,
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(8), bottomRight: Radius.circular(8))),
                                      child: Text(
                                        "%",
                                        style: AppFonts.regular(
                                            12, (widget.isVND == true) ? AppThemes.kPrimary : AppThemes.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    )
        ],
      ),
    );
  }
}

class ColumnProduct extends StatefulWidget {
  final String title;
  final List<SearchProductModel> listSelected;
  final TextEditingController? controller;
  final void Function(String?)? onChanged;
  final void Function(SearchProductModel?) onSelect;

  const ColumnProduct(
      {super.key,
      required this.title,
      required this.listSelected,
      this.controller,
      this.onChanged,
      required this.onSelect});

  @override
  State<ColumnProduct> createState() => _ColumnProductState();
}

class _ColumnProductState extends State<ColumnProduct> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: AppFonts.regular(14, const Color(0xff8F90A6))),
        const SizedBox(height: 8),
        Wrap(
          spacing: 4,
          runSpacing: 0,
          children: List.generate(
              widget.listSelected.length,
              (index) => widget.listSelected.isNotEmpty
                  ? Chip(
                      label: Text(
                        widget.listSelected[index].name ?? "",
                        style: AppFonts.regular(),
                      ),
                      onDeleted: () {
                        widget.listSelected.removeAt(index);
                        setState(() {});
                      },
                    )
                  : const SizedBox.shrink()),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 2,
              child: CustomInputFiled(
                controller: widget.controller,
                onChanged: widget.onChanged,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 5,
              child: SearchProduct(
                select: widget.onSelect,
              ),
            )
          ],
        ),
      ],
    );
  }
}
