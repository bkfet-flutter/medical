import 'package:flutter/material.dart';
import 'package:mephar_app/model/unit_product_model.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/mephar_textfield.dart';

class AddInformationUnit extends StatefulWidget {
  final UnitProductsModel unitProductsModel;
  final int price;

  const AddInformationUnit({
    super.key,
    required this.price,
    required this.unitProductsModel,
  });

  @override
  State<AddInformationUnit> createState() => _AddInformationUnitState();
}

class _AddInformationUnitState extends State<AddInformationUnit> {
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
                          widget.price)
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
