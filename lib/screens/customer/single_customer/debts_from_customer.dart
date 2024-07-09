import 'package:flutter/material.dart';
import 'package:mephar_app/model/config/province_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:mephar_app/provider/debt_customer_provider.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/card_product_check.dart';
import 'package:mephar_app/widgets/mephar_input.dart';
import 'package:mephar_app/widgets/object_dropdown_button.dart';
import 'package:provider/provider.dart';

class DebtsFromCustomer extends StatefulWidget {
  const DebtsFromCustomer({super.key});

  @override
  State<DebtsFromCustomer> createState() => _DebtsFromCustomerState();
}

class _DebtsFromCustomerState extends State<DebtsFromCustomer> {
  TextEditingController debtNowController = TextEditingController();
  TextEditingController payCustomerController = TextEditingController();
  TextEditingController debtLastController = TextEditingController();
  List<String> items = ["Tiền mặt", "Chuyển khoản"];
  List<ProvinceModel> listItems = [ProvinceModel(id: 1, name: "Tiền mặt"), ProvinceModel(id: 2, name: "Chuyển khoản")];
  int? typePay;

  @override
  Widget build(BuildContext context) {
    return Consumer<DebtCustomerProvider>(builder: (context, debt, child) {
      return Container(
        color: const Color(0xffF3FAFF),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: debt.listDebt.length,
            itemBuilder: (context, int index) {
              return CardProductCheck(
                listData: [
                  {
                    "titleLeft": "Thời gian",
                    "titleRight": debt.listDebt[index].createdAt,
                  },
                  {
                    "titleLeft": "Loại",
                    "titleRight": debt.listDebt[index].type == "ORDER" ? "Bán hàng" : "Đang cập nhật",
                  },
                  {
                    "titleLeft": "Giá trị",
                    "titleRight": debt.listDebt[index].totalAmount.toString(),
                  },
                  {
                    "titleLeft": "Dư nợ khách hàng",
                    "titleRight": debt.listDebt[index].debtAmount,
                    "isFinal": true,
                  },
                ],
                numberCard: index,
                onPressed: () {},
                isPay: true,
                onPay: () {
                  debtLastController = TextEditingController(text: 0.toString());
                  debtNowController = TextEditingController(text: debt.listDebt[index].debtAmount.toString());
                  setState(() {});
                  AppFunction.showDialogAlert(
                    context,
                    isTwoButton: true,
                    title: "Thanh toán",
                    widgetDescription: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        children: [
                          MepharInput(
                            titleInput: "Nợ hiện tại",
                            controller: debtNowController,
                          ),
                          MepharInput(
                            titleInput: "Thu từ khách",
                            controller: payCustomerController,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              debtLastController.text =
                                  (int.parse(payCustomerController.text) - int.parse(debtNowController.text))
                                      .toString();
                            },
                          ),
                          MepharInput(
                            titleInput: "Nợ sau",
                            controller: debtLastController,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ObjectDropdownButton(
                            havePadding: true,
                            haveBorder: true,
                            hinText: "Phương thức thanh toán",
                            listItems: listItems,
                            onChange: (e) => {
                              setState(() {
                                typePay = e?.id;
                              })
                            },
                          ),
                        ],
                      ),
                    ),
                    text1stButton: "Huỷ bỏ",
                    text2ndButton: "Xong",
                    onPress2ndButton: () async {
                      ApiResponse res = await ApiRequest.payForDebt(
                        id: debt.listDebt[index].id,
                        paymentMethod: typePay == 1 ? "CASH" : "",
                        amount: int.parse(payCustomerController.text),
                        totalAmount: debt.listDebt[index].totalAmount,
                      );
                      if (res.result = true) {
                        Navigator.of(context, rootNavigator: true).pop();

                        await debt.getListDebt(
                          branchId: context.read<BranchProvider>().defaultBranch?.id,
                          id: debt.listDebt[index].customerId,
                          page: 1,
                          limit: 20,
                        );
                        AppFunction.showDialogSuccess(context, content: "Thanh toán thành công");
                      } else {
                        Navigator.of(context, rootNavigator: true).pop();
                        AppFunction.showDialogError(context, res.message ?? "Lỗi không xác định");
                      }
                    },
                  );
                },
              );
            },
          ),
        ),
      );
    });
  }
}
