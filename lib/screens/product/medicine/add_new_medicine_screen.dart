import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/provider/country_produce_provider.dart';
import 'package:mephar_app/provider/dosage_provider.dart';
import 'package:mephar_app/provider/group_product_provider.dart';
import 'package:mephar_app/provider/manufacture_provider.dart';
import 'package:mephar_app/provider/medicine_provider.dart';
import 'package:mephar_app/provider/position_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/screens/product/medicine/add_information_medicine.dart';
import 'package:mephar_app/screens/product/medicine/detail_information_medicine.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:provider/provider.dart';

class AddNewMedicineScreen extends BaseScreen {
  const AddNewMedicineScreen({super.key});

  @override
  AddNewMedicineScreenState createState() => AddNewMedicineScreenState();
}

class AddNewMedicineScreenState extends BaseState<AddNewMedicineScreen>
    with BaseScreenMixin {
  int _currentIndex = 0;
  Color colorBackground1 = Colors.white;
  Color colorText1 = AppThemes.red0;
  Color colorBackground2 = const Color(0xff767680).withOpacity(0.12);
  Color colorText2 = AppThemes.dark1;
  initData() async {
    AppFunction.showLoading(context);
    String dosage = await Provider.of<DosageProvider>(context, listen: false)
        .getListDosage(limit: 10, page: 1);
    String position =
        await Provider.of<PositionProvider>(context, listen: false)
            .getListPosition(limit: 10, page: 1);
    String groupProduct =
        await Provider.of<GroupProductProvider>(context, listen: false)
            .getListGroupProduct(limit: 10, page: 1);
    String manufacture =
        await Provider.of<ManufactureProvider>(context, listen: false)
            .getListManufacture(limit: 10, page: 1);
    String countryProduce =
        await Provider.of<CountryProduceProvider>(context, listen: false)
            .getListCountryProduce(limit: 10, page: 1);
    String medicine =
        await Provider.of<MedicineProvider>(context, listen: false)
            .getDataMedicine("", 10, 1);
    if (dosage == "success" &&
        position == "success" &&
        groupProduct == "success" &&
        manufacture == "success" &&
        countryProduce == "success" &&
        medicine == "success") {
      AppFunction.hideLoading(context);
    } else {
      AppFunction.hideLoading(context);
      AppFunction.showDialogError(context, "Lỗi không xác định");
    }
  }

  @override
  void afterFirstLayout(BuildContext context) {
    initData();
  }

  @override
  String setTitle() {
    return "Thêm mới thuốc";
  }

  @override
  TextStyle setTextStyleTitle() {
    return AppFonts.normalBold(18, Colors.white);
  }

  @override
  setOnPressRightButton() {
    Navigator.pop(context);
  }

  @override
  Widget buildBody(BuildContext context) {
    return Container(
      color: AppThemes.blue4,
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: const [
                AddInformationMeidcine(),
                DetailInformationMedicine(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildHeader() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xff767680).withOpacity(0.12)),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _currentIndex = 0;
                      colorBackground1 = Colors.white;
                      colorText1 = AppThemes.red0;
                      colorBackground2 = const Color(0xff767680).withOpacity(0);
                      colorText2 = AppThemes.dark1;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          boxShadow: _currentIndex == 0
                              ? [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      offset: const Offset(0, 3),
                                      blurRadius: 1,
                                      spreadRadius: 0),
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.12),
                                      offset: const Offset(0, 3),
                                      blurRadius: 8,
                                      spreadRadius: 0),
                                ]
                              : null,
                          color: colorBackground1),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 6),
                        child: Text(
                          "Thông tin",
                          style: AppFonts.normalBold(15, colorText1)
                              .copyWith(height: 20 / 15),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _currentIndex = 1;
                      colorBackground2 = Colors.white;
                      colorText2 = AppThemes.red0;
                      colorBackground1 = const Color(0xff767680).withOpacity(0);
                      colorText1 = AppThemes.dark1;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          boxShadow: _currentIndex == 1
                              ? [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      offset: const Offset(0, 3),
                                            blurRadius: 1,
                                      spreadRadius: 0),
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.12),
                                      offset: const Offset(0, 3),
                                      blurRadius: 8,
                                      spreadRadius: 0),
                                ]
                              : null,
                          color: colorBackground2),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 8),
                        child: Text(
                          "Mô tả chi tiết",
                          style: AppFonts.normalBold(15, colorText2)
                              .copyWith(height: 20 / 15),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
