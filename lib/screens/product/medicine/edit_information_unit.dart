import 'package:flutter/material.dart';
import 'package:mephar_app/model/product_model.dart';
import 'package:mephar_app/model/unit_product_model.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/mephar_textfield.dart';

class EditInformationUnit extends StatefulWidget {
  final UnitProductsModel unitProductsModel;
  final int? price;
  final ProductUnit? data;

  const EditInformationUnit({
    super.key,
    // required
    this.price,
    required this.unitProductsModel,
    required this.data,
  });

  @override
  State<EditInformationUnit> createState() => _EditInformationUnitState();
}

class _EditInformationUnitState extends State<EditInformationUnit> {
  initData() {
    widget.unitProductsModel.name =
        TextEditingController(text: widget.data?.unitName ?? "");
    widget.unitProductsModel.value = TextEditingController(
        text: widget.data?.exchangeValue == null
            ? "0"
            : widget.data?.exchangeValue.toString());
    widget.unitProductsModel.salePrice = TextEditingController(
      text: widget.data?.price == null ? "0" : widget.data?.price.toString(),
    );
    widget.unitProductsModel.codeUnit =
        TextEditingController(text: widget.data?.code ?? "");
    widget.unitProductsModel.barCode =
        TextEditingController(text: widget.data?.barCode ?? "");
    widget.unitProductsModel.point = TextEditingController(
      text: widget.data?.point == null ? "0" : widget.data?.point.toString(),
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MepharTextfield(
          hintText: "Tên đơn vị",
          controller: widget.unitProductsModel.name,
        ),
        MepharTextfield(
          hintText: "Giá trị quy đổi",
          controller: widget.unitProductsModel.value,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              widget.unitProductsModel.salePrice.text = AppFunction.formatNum(
                      int.parse(widget.unitProductsModel.value.text) *
                          widget.price!)
                  .toString();
            });
          },
        ),
        MepharTextfield(
          hintText: "Giá bán",
          controller: widget.unitProductsModel.salePrice,
          keyboardType: TextInputType.number,
          readOnly: true,
        ),
        MepharTextfield(
          hintText: "Mã hàng",
          controller: widget.unitProductsModel.codeUnit,
        ),
        MepharTextfield(
          hintText: "Mã vạch",
          controller: widget.unitProductsModel.barCode,
        ),
        MepharTextfield(
          hintText: "Điểm",
          controller: widget.unitProductsModel.point,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
