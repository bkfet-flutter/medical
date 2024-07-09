import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/app/constant.dart';
import 'package:mephar_app/model/sell_products_model.dart';
import 'package:mephar_app/provider/sell_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/mephar_dropdown_button.dart';
import 'package:mephar_app/widgets/row_in_card_product.dart';
import 'package:mephar_app/widgets/touchable_widget.dart';
import 'package:provider/provider.dart';

class PayCounterScreen extends BaseScreen {
  final int? discount;
  final int? discountType;
  final int? customerId;
  final int? cashOfCustomer;
  final String? payType;

  const PayCounterScreen(
      {super.key,
      required this.discount,
      required this.discountType,
      this.customerId,
      required this.cashOfCustomer,
      required this.payType});

  @override
  PayCounterScreenState createState() => PayCounterScreenState();
}

class PayCounterScreenState extends BaseState<PayCounterScreen> with BaseScreenMixin {
  PayType payType = PayType.cash;

  TextEditingController cashOfCustomer = TextEditingController();

  String get cash => cashOfCustomer.text;

  _initData() {
    cashOfCustomer.text = (widget.cashOfCustomer ?? "").toString();
    switch (widget.payType) {
      case "BANK":
        payType = PayType.bank;
      case "DEBT":
        payType = PayType.debt;
      case "CASH":
        payType = PayType.cash;
      default:
        payType = PayType.cash;
    }
    setState(() {});
  }

  String _getReturnMoney(BuildContext context) {
    if (cash.isEmpty) {
      return "0";
    } else {
      return AppFunction.formatNum((AppFunction.textToInt(cashOfCustomer) -
          context
              .watch<SellProvider>()
              .getTotalPrice(discountValue: widget.discount, discountType: widget.discountType)
              .toInt()));
    }
  }

  Widget _buildViewCASH(BuildContext context) {
    return Column(
      children: [
        RowInCardProduct(
          cross: CrossAxisAlignment.center,
          titleLeft: "Tiền khách đưa",
          titleRight: cash.isEmpty ? "0" : AppFunction.formatNum(int.parse(cash)),
          colorLeft: AppThemes.dark1,
        ),
        RowInCardProduct(
          titleLeft: "Tiền thừa trả khách",
          titleRight: _getReturnMoney(context),
          isFinal: true,
        ),
        Container(
          height: 8,
          color: AppThemes.blue4,
        ),
      ],
    );
  }

  Widget _buildViewQR() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Chọn loại mã QR",
          style: AppFonts.normalBold(
            14,
            AppThemes.dark1,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TouchableWidget(
              onPressed: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return Center(
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 370,
                              child: AlertDialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                titlePadding: const EdgeInsets.all(0),
                                title: Image.asset(
                                  AppImages.qrDemo,
                                  height: MediaQuery.of(context).size.width - 100,
                                  width: MediaQuery.of(context).size.width - 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 50,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Image.asset(
                                  AppImages.iconCloseCircle,
                                  height: 20,
                                  width: 20,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    });
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  AppImages.vnPay,
                  height: 86,
                  width: 86,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            TouchableWidget(
              onPressed: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return Center(
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 370,
                              child: AlertDialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                titlePadding: const EdgeInsets.all(0),
                                title: Image.asset(
                                  AppImages.qrDemo,
                                  height: MediaQuery.of(context).size.width - 100,
                                  width: MediaQuery.of(context).size.width - 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 50,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Image.asset(
                                  AppImages.iconCloseCircle,
                                  height: 20,
                                  width: 20,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    });
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  AppImages.vietQR,
                  height: 86,
                  width: 86,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            TouchableWidget(
              onPressed: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return Center(
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 370,
                              child: AlertDialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                titlePadding: const EdgeInsets.all(0),
                                title: Image.asset(
                                  AppImages.qrDemo,
                                  height: MediaQuery.of(context).size.width - 100,
                                  width: MediaQuery.of(context).size.width - 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 50,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Image.asset(
                                  AppImages.iconCloseCircle,
                                  height: 20,
                                  width: 20,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    });
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  AppImages.momo,
                  height: 86,
                  width: 86,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildView(PayType payType) {
    switch (payType) {
      case PayType.cash:
        return _buildViewCASH(context);
      case PayType.bank:
        return _buildViewQR();
      case PayType.debt:
        return _buildViewCASH(context);
    }
  }

  @override
  String setTitle() => "Thanh toán tại quầy";

  @override
  Widget? buildRightWidget() => const SizedBox.shrink();

  @override
  Color setMainBackgroundColor() => const Color(0xffF3FAFF);

  @override
  void initState() {
    _initData();
    super.initState();
  }

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Text(
                      "Tổng khách phải trả",
                      style: AppFonts.regular(
                        14,
                        AppThemes.dark1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${AppFunction.formatNum(context.watch<SellProvider>().getTotalPrice(discountValue: widget.discount, discountType: widget.discountType))}đ',
                      style: AppFonts.bold(
                        36,
                        AppThemes.dark1,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Image.asset(
                                  AppImages.iconWallet,
                                  height: 20,
                                  width: 20,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "Khách thanh toán",
                                  style: AppFonts.normalBold(
                                    14,
                                    AppThemes.dark1,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: MepharDropDownButton(
                                    isNormal: true,
                                    height: 50,
                                    padding: const EdgeInsets.only(left: 12),
                                    haveHintText: false,
                                    value: AppConstant.mapPayType[payType]?.label,
                                    hintText: "Loại thanh toán",
                                    items: widget.customerId != null
                                        ? AppConstant.mapPayType.values.map((e) => e.label).toList()
                                        : ["Tiền mặt", "Chuyển khoản"],
                                    onChanged: (value) {
                                      final result =
                                          AppConstant.mapPayType.values.firstWhere((element) => element.label == value);
                                      payType = AppConstant.mapPayType.entries
                                          .firstWhere((element) => element.value == result)
                                          .key;
                                      setState(() {});
                                    }),
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(left: 24),
                                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: AppThemes.light0,
                                        width: 1,
                                      )),
                                  child: TextFormField(
                                    onChanged: (value) => setState(() => cash),
                                    textAlign: TextAlign.center,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero),
                                    controller: cashOfCustomer,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ]),
                ),
                _buildView(payType)
              ],
            ),
          ),
        ),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
          child: Row(
            children: [
              Expanded(
                child: MepharButton(
                  isButtonWhite: true,
                  titleButton: "Hủy",
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: MepharButton(
                    titleButton: "Hoàn thành",
                    onPressed: () => Navigator.pop(
                        context,
                        SellModel(
                            paymentType: AppConstant.mapPayType[payType]?.value,
                            cashOfCustomer: AppFunction.textToInt(cashOfCustomer)))),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
