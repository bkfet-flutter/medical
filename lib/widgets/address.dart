import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/provider/address_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/widgets/object_dropdown_button.dart';
import 'package:provider/provider.dart';

class DropdownAddressWidget extends StatefulWidget {
  final bool? haveBoder;
  final bool? havePadding;
  final bool? hideText;
  final bool? paddingText;
  final String? labelText1;
  final String? labelText2;
  final String? labelText3;

  const DropdownAddressWidget(
      {super.key,
      this.haveBoder,
      this.havePadding,
      this.hideText,
      this.paddingText,
      this.labelText1,
      this.labelText2,
      this.labelText3});

  @override
  State<DropdownAddressWidget> createState() => _DropdownAddressWidgetState();
}

class _DropdownAddressWidgetState extends State<DropdownAddressWidget> {
  void _initData(BuildContext context) {
    final addressProvider = context.read<AddressProvider>();
    addressProvider.resetData();
    addressProvider.getDataListProvince();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initData(context));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressProvider>(builder: (context, provider, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
                bottom: 0, left: widget.havePadding == true ? 0 : 16),
            child: Text(
              widget.hideText == true ? "Tỉnh/Thành phố" : "",
              style: AppFonts.normalBold(
                12,
                AppThemes.gray,
              ),
            ),
          ),
          ObjectDropdownButton(
              paddingText: widget.paddingText,
              initValue: widget.labelText1,
              havePadding: widget.havePadding,
              haveBorder: widget.haveBoder,
              labelText: widget.hideText == true ? "" : "Tỉnh/Thành phố",
              value: provider.provinceValue,
              listItems: provider.listProvince,
              onChange: (data) => provider.selectProvince(data)),
          const SizedBox(
            height: 16,
          ),
          Container(
            padding: EdgeInsets.only(
                bottom: 0, left: widget.havePadding == true ? 0 : 16),
            child: Text(
              widget.hideText == true ? "Quận/Huyện" : "",
              style: AppFonts.normalBold(
                12,
                AppThemes.gray,
              ),
            ),
          ),
          ObjectDropdownButton(
            initValue: widget.labelText2,
            havePadding: widget.havePadding,
            haveBorder: widget.haveBoder,
            labelText: widget.hideText == true ? "" : "Quận/Huyện",
            listItems: provider.listDistrict,
            value: provider.districtValue,
            onChange: (data) => provider.selectDistrict(data),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            padding: EdgeInsets.only(
                bottom: 0, left: widget.havePadding == true ? 0 : 16),
            child: Text(
              widget.hideText == true ? "Xã/Phường" : "",
              style: AppFonts.normalBold(
                12,
                AppThemes.gray,
              ),
            ),
          ),
          ObjectDropdownButton(
              initValue: widget.labelText3,
              havePadding: widget.havePadding,
              haveBorder: widget.haveBoder,
              labelText: widget.hideText == true ? "" : "Xã/Phường",
              listItems: provider.listWard,
              value: provider.wardValue,
              onChange: (data) => provider.selectWard(data)),
        ],
      );
    });
  }
}
