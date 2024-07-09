import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/model/market/address_model.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/market/base/address_widget.dart';
import 'package:mephar_app/screens/market/base/market_screen.dart';

class DeliveryAddressPage extends StatefulWidget {
  const DeliveryAddressPage({super.key});

  @override
  State<DeliveryAddressPage> createState() => _DeliveryAddressPageState();
}

class _DeliveryAddressPageState extends State<DeliveryAddressPage> {
  List<AddressModel> listAddress = [
    AddressModel(
        name: 'Chu Dung',
        phone: '0868666888',
        province: 'Hà Nội',
        district: 'Quận Nam Từ Liêm',
        commune: 'Mễ Trì Thượng',
        detail: '9, 89',
        defaultAddress: true),
    AddressModel(
        name: 'Linh',
        phone: '0868666888',
        province: 'Hà Nội',
        district: 'Quận Nam Từ Liêm',
        commune: '9, 89 Mễ Trì Thượng',
        defaultAddress: false),
    AddressModel(
        name: 'Lee Van Linh',
        phone: '0868666888',
        province: 'Hà Nội',
        district: 'Quận Nam Từ Liêm',
        commune: '9, 89 Mễ Trì Thượng',
        defaultAddress: false),
  ];
  AddressModel? currentAddress;

  void getData() {
    if (listAddress.isNotEmpty) {
      currentAddress =
          listAddress.firstWhere((element) => element.defaultAddress == true, orElse: (() => listAddress[0]));
    }
    setState(() {
      currentAddress;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MarketScreen(
        title: 'Địa chỉ nhận hàng',
        iconRight: AppImages.iconAddRed,
        onTapIconRight: () {
          Navigator.pushNamed(context, AppRoutes.addAddressPage);
        },
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: List.generate(
                listAddress.length,
                (index) => Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                          border:
                              Border(top: BorderSide(color: index == 0 ? AppThemes.transparent : AppThemes.light1))),
                      child: RadioListTile(
                        value: listAddress[index],
                        activeColor: const Color(0xffEE0033),
                        contentPadding: const EdgeInsets.only(right: 12),
                        visualDensity: const VisualDensity(horizontal: -4.0),
                        groupValue: currentAddress,
                        onChanged: (value) {
                          setState(() {
                            currentAddress = value;
                          });
                        },
                        title: AddressWidget(
                          onTapPen: () {
                            Navigator.pushNamed(context, AppRoutes.editAddressPage);
                          },
                          name: listAddress[index].name ?? "",
                          number: listAddress[index].phone ?? "",
                          address:
                              '${listAddress[index].detail ?? ""}, ${listAddress[index].commune ?? ""}, ${listAddress[index].district ?? ""}, ${listAddress[index].province ?? ""}',
                          isDefault: listAddress[index].defaultAddress,
                        ),
                      ),
                    )),
          ),
        ));
  }
}
