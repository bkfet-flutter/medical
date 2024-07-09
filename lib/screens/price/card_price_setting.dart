import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/model/price_settings_model.dart';
import 'package:mephar_app/provider/product/price_setting_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/dropdown_unit.dart';
import 'package:mephar_app/widgets/price_adjustment.dart';
import 'package:mephar_app/widgets/row_in_card_product.dart';
import 'package:mephar_app/widgets/touchable_widget.dart';
import 'package:provider/provider.dart';

class CardPriceSetting extends StatefulWidget {
  final PriceSettingsModel priceSettingsModel;

  const CardPriceSetting({super.key, required this.priceSettingsModel});

  @override
  State<CardPriceSetting> createState() => _CardPriceSettingState();
}

class _CardPriceSettingState extends State<CardPriceSetting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          RowInCardProduct(
            titleLeft: "Mã hàng",
            titleRight: widget.priceSettingsModel.product?.code,
          ),
          RowInCardProduct(
            titleLeft: "Tên hàng",
            titleRight: widget.priceSettingsModel.product?.name,
          ),
          RowInCardProduct(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            cross: CrossAxisAlignment.center,
            flex: 3,
            titleLeft: 'Đơn vị',
            isWidget: true,
            widgetRight: Align(
              alignment: Alignment.centerRight,
              child: DropdownUnitButton(
                listItems: [],
                onChange: (value) {
                  setState(() {
                    // widget.inboundModel.priceUnitController?.text =
                    //     value!.price.toString();
                    // widget.inboundModel.productUnitId = value!.id;
                  });
                  // print(value!.price);
                  // print(widget.inboundModel.priceUnitController?.text);
                },
              ),
            ),
          ),
          RowInCardProduct(
            titleLeft: "Giá vốn",
            titleRight: (widget.priceSettingsModel.product?.primePrice ?? "---")
                .toString(),
          ),
          // const RowInCardProduct(
          //   titleLeft: "Tồn kho",
          //   titleRight: "240",
          // ),

          RowInCardProduct(
            titleLeft: "Giá nhập cuối",
            titleRight: (widget.priceSettingsModel.price ?? "---").toString(),
          ),
          RowInCardProduct(
            titleLeft: "Giá bán",
            isWidget: true,
            isFinal: true,
            widgetRight: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  (widget.priceSettingsModel.price ?? "---").toString(),
                  style: AppFonts.normalBold(
                    14,
                    AppThemes.dark1,
                  ).copyWith(
                    height: 18 / 14,
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                dialogEdit(context)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget dialogEdit(BuildContext context) {
    return Consumer<PriceSettingProvider>(builder: (context, setting, child) {
      return TouchableWidget(
        onPressed: () {
          setting.setPrice(widget.priceSettingsModel.price);
          setting.setBasePrice(widget.priceSettingsModel.price);
          AppFunction.showDialogAlert(context,
              widgetDescription: const PriceAdjustmentWidget(),
              title: widget.priceSettingsModel.product?.name,
              styleTitle: const TextStyle(
                  fontFamily: AppFonts.laTo,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: AppThemes.dark0),
              isTwoButton: true,
              text1stButton: "Hủy",
              onPress1stButton: () {
                Navigator.of(context, rootNavigator: true).pop();
                setting.resetData();
              },
              text2ndButton: "Lưu",
              onPress2ndButton: () {
                Navigator.of(context, rootNavigator: true).pop();
                save(context, widget.priceSettingsModel.id);
              });
        },
        padding: const EdgeInsets.all(0),
        child: Image.asset(
          AppImages.iconPenRed,
          height: 20,
          width: 20,
          fit: BoxFit.cover,
        ),
      );
    });
  }

  save(BuildContext context, int? id) {
    AppFunction.showLoading(context);
    context.read<PriceSettingProvider>().edit(context, id: id).then((value) {
      AppFunction.hideLoading(context);
      if (value == true) {
        context.read<PriceSettingProvider>().fetchPriceSettings(context);
      }
    });
  }
}
