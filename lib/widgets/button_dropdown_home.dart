import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/model/config/branch_model.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/widgets/normal_text.dart';

class ButtonDropdownHome extends StatelessWidget {
  final Function(BranchModel?) onUpdate;
  final List<BranchModel> listBranch;
  final BranchModel? value;

  const ButtonDropdownHome({
    Key? key,
    required this.onUpdate,
    required this.listBranch,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<BranchModel>(
      isExpanded: true,
      isDense: true,
      underline: Container(),
      iconEnabledColor: AppThemes.white,
      iconDisabledColor: AppThemes.white,
      onChanged: (BranchModel? value) => onUpdate(value),
      value: value,
      items: listBranch.map<DropdownMenuItem<BranchModel>>((BranchModel item) {
        return DropdownMenuItem<BranchModel>(
          value: item,
          child: Text(item.name!),
        );
      }).toList(),
      selectedItemBuilder: (BuildContext context) {
        return listBranch.map<Widget>((BranchModel item) {
          return Container(
            alignment: Alignment.centerLeft,
            constraints: const BoxConstraints(minWidth: 100),
            child: NormalText(
              item.name!,
              style: AppFonts.regular(14, Colors.white),
              maxLines: 1,
              minFontSize: 10,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList();
      },
    );
  }
}
