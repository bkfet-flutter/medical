import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/model/promotion_model.dart';
import 'package:mephar_app/model/search_customer_model.dart';
import 'package:mephar_app/model/search_supplier_model.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/configuration/promotion/promotion_widget/button_add_method.dart';
import 'package:mephar_app/screens/configuration/promotion/promotion_widget/card_method.dart';
import 'package:mephar_app/screens/configuration/promotion/promotion_widget/muilti_search.dart';
import 'package:mephar_app/screens/configuration/promotion/promotion_widget/multi_select.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/custom_tab_indicator.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/mephar_checkbox.dart';
import 'package:mephar_app/widgets/mephar_dropdown_button.dart';
import 'package:mephar_app/widgets/mephar_picker_datetime.dart';
import 'package:mephar_app/widgets/mephar_radio_button.dart';
import 'package:mephar_app/widgets/mephar_red_appbar.dart';
import 'package:mephar_app/widgets/mephar_textfield.dart';
import 'package:provider/provider.dart';

class AddNewPromotionScreen extends BaseScreen {
  const AddNewPromotionScreen({super.key});

  @override
  State<AddNewPromotionScreen> createState() => _AddNewPromotionScreenState();
}

class _AddNewPromotionScreenState extends BaseState<AddNewPromotionScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;
  String selected = 'Kích hoạt';
  String selectedAll = 'Toàn hệ thống';
  String selectedCustomer = "Toàn bộ khách hàng";
  String selectedSeller = "Toàn bộ người bán";
  List<SearchCustomerModel> listCustomerSelected = [];
  List<SearchSupplierModel> listSupplierSelected = [];
  List<String> listBranchSelect = [];
  String startDay = DateTime.now().toString();
  String branchIds = "";
  String groupCustomerIds = "";
  String sellerIds = "";
  String endDay = DateTime.now().toString();
  String type = 'BILL';
  String birthdayPromotionType = 'DAY';
  String method = "DISCOUNT_BILL";
  bool multiplyByQuantity = false;
  bool isBirthdayPromotion = false;
  List<ListPolicy> listPolicy = [
    ListPolicy(
        startPriceController: TextEditingController(),
        discountController: TextEditingController(),
        givenController: TextEditingController(),
        discountNumController: TextEditingController(),
        discountType: "VALUE",
        startPrice: 0,
        discountValue: 0,
        givenProductQuantity: 0,
        givenProductGroups: "",
        givenProductIds: "",
        discountProductGroups: "",
        discountProductIds: "",
        discountProductQuantity: 0,
        plusPointValue: 0,
        plusPointType: "VALUE",
        newPrice: 0,
        purchaseQuantity: 0,
        purchaseProductGroups: "",
        purchaseProductIds: "",
        listProductGiven: [],
        listProductDiscount: [],
        listProductPurchase: []),
  ];
  TextEditingController code = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController note = TextEditingController();

  List<String> listMonthsSelect = [];

  List<String> listDaysSelect = [];
  List<String> listDayOfWeekSelect = [];
  List<String> listHourSelect = [];
  String selectedMonth = "";
  String selectedDay = "";
  String selectedDayOfWeek = "";
  List<String> listHour = [
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
  ];

  void _getBranchIds() {
    List<String> list = [];
    var provider = Provider.of<BranchProvider>(context, listen: false);
    // for (var e in listBranchSelect) {
    //   String? id = provider.listBranch.firstWhere((element) => element.name == e).id;
    //   if (id != null) {
    //     list.add(id);
    //   }
    // }
    setState(() {
      branchIds = list.join(",");
    });
  }

  void _getGivenProductIds(index) {
    List<String> list = [];
    if (listPolicy[index].listProductGiven != null && listPolicy[index].listProductGiven!.isNotEmpty) {
      for (var e in listPolicy[index].listProductGiven!) {
        if (e.id != null) {
          list.add(e.id!);
        }
      }
      listPolicy[index].givenProductIds = list.join(",");
    }
    setState(() {});
  }

  void _resetCard() {
    listPolicy.clear();
    listPolicy.add(
      ListPolicy(
          startPriceController: TextEditingController(),
          discountController: TextEditingController(),
          givenController: TextEditingController(),
          discountType: "VALUE",
          startPrice: 0,
          discountValue: 0,
          givenProductQuantity: 0,
          givenProductGroups: "",
          givenProductIds: "",
          discountProductGroups: "",
          discountProductIds: "",
          discountProductQuantity: 0,
          plusPointValue: 0,
          plusPointType: "VALUE",
          newPrice: 0,
          purchaseQuantity: 0,
          purchaseProductGroups: "",
          purchaseProductIds: "",
          listProductGiven: [],
          listProductDiscount: [],
          listProductPurchase: []),
    );
    setState(() {});
  }

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
    name.dispose();
    code.dispose();
    note.dispose();
  }

  @override
  Widget buildBody(BuildContext context) {
    return MepharRedAppbar(
      title: "Khuyến mại",
      backgroundColor: const Color(0xffF3FAFF),
      isCheck: false,
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            color: const Color(0xffF3FAFF),
            child: TabBar(
                onTap: (index) {
                  AppFunction.hideKeyboard(context);
                },
                labelStyle: AppFonts.normalBold(),
                controller: tabController,
                labelColor: AppThemes.red0,
                unselectedLabelColor: AppThemes.dark3,
                indicator: const CustomTabIndicator(color: AppThemes.red0, indicatorHeight: 4),
                isScrollable: true,
                tabs: const [
                  Tab(
                    text: "Thông tin",
                  ),
                  Tab(
                    text: "Thời gian áp dụng",
                  ),
                  Tab(
                    text: "Phạm vi áp dụng",
                  ),
                ]),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Thông tin",
                          style: AppFonts.normalBold(
                            16,
                            AppThemes.dark1,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MepharTextfield(
                                hintText: "Mã chương trình",
                                controller: code,
                              ),
                              MepharTextfield(
                                hintText: "Tên chương trình",
                                controller: name,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Trạng thái",
                                      style: AppFonts.normalBold(12, AppThemes.gray),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: MepharRadioButton(
                                              title: "Kích hoạt",
                                              isSelected: selected == "Kích hoạt",
                                              onSelected: (value) {
                                                setState(() {
                                                  selected = value;
                                                });
                                              }),
                                        ),
                                        Expanded(
                                          child: MepharRadioButton(
                                              title: "Chưa Kích hoạt",
                                              isSelected: selected == "Chưa Kích hoạt",
                                              onSelected: (value) {
                                                setState(() {
                                                  selected = value;
                                                });
                                              }),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                color: AppThemes.gray,
                                height: 1,
                                width: MediaQuery.of(context).size.width,
                              ),
                              MepharTextfield(
                                hintText: "Thêm ghi chú",
                                controller: note,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Hình thức khuyến mại",
                          style: AppFonts.normalBold(16, AppThemes.dark1),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MepharDropDownButton(
                                  haveBorder: false,
                                  hintText: "Khuyến mại",
                                  items: const ['Hóa đơn', 'Hàng Hóa'],
                                  onChanged: (value) {
                                    _resetCard();
                                    if (value == 'Hóa đơn') {
                                      type = 'BILL';
                                      method = AppFunction.findMethod('Giảm giá hóa đơn');
                                    } else {
                                      type = 'PRODUCT';
                                      method = AppFunction.findMethod('Mua hàng giảm giá hàng');
                                    }
                                    setState(() {});
                                  }),
                              MepharDropDownButton(
                                  haveBorder: false,
                                  hintText: "Hình thức",
                                  items: (type == 'BILL')
                                      ? const ['Giảm giá hóa đơn', 'Tặng hàng']
                                      : const ['Mua hàng giảm giá hàng', 'Mua hàng tặng hàng'],
                                  onChanged: (value) {
                                    _resetCard();
                                    setState(() {
                                      method = AppFunction.findMethod(value);
                                    });
                                  }),
                              const SizedBox(
                                height: 16,
                              ),
                              (type == "PRODUCT")
                                  ? Padding(
                                      padding: const EdgeInsets.only(bottom: 16),
                                      child: Row(
                                        children: [
                                          MepharCheckbox(
                                            onlyCheckBox: true,
                                            isChecked: multiplyByQuantity,
                                            onTap: () {
                                              setState(() {
                                                multiplyByQuantity = !multiplyByQuantity;
                                              });
                                            },
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            "Không nhân theo số lượng mua",
                                            style: AppFonts.regular(14, const Color(0xff555770)),
                                          )
                                        ],
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              Column(
                                children: List.generate(
                                  listPolicy.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: CardMethod(
                                      givenController: listPolicy[index].givenController,
                                      listProductGivenSelect: listPolicy[index].listProductGiven!,
                                      listProductDiscountSelect: listPolicy[index].listProductDiscount!,
                                      listProductPurchaseSelect: listPolicy[index].listProductPurchase!,
                                      method: method,
                                      isVND: listPolicy[index].discountType == 'VALUE',
                                      index: '${index + 1}',
                                      startPriceController: listPolicy[index].startPriceController,
                                      discountValueController: listPolicy[index].discountController,
                                      onChangedPurchaseValue: (value) {
                                        if (value == null) {
                                          listPolicy[index].purchaseQuantity = 0;
                                        } else {
                                          listPolicy[index].purchaseQuantity = int.parse(value);
                                        }
                                        setState(() {});
                                      },
                                      onChangedDiscountNum: (value) {
                                        if (value == null) {
                                          listPolicy[index].discountProductQuantity = 0;
                                        } else {
                                          listPolicy[index].discountProductQuantity = int.parse(value);
                                        }
                                        setState(() {});
                                      },
                                      getIdDiscount: () {
                                        setState(() {
                                          listPolicy[index].discountProductIds =
                                              listPolicy[index].listProductDiscount?.map((e) => e.id).join(",");
                                        });
                                      },
                                      getIdPurchase: () {
                                        setState(() {
                                          listPolicy[index].purchaseProductIds =
                                              listPolicy[index].listProductPurchase?.map((e) => e.id).join(",");
                                        });
                                      },
                                      getIdGiven: () {
                                        _getGivenProductIds(index);
                                      },
                                      onChangedGiven: (value) {
                                        if (value == null) {
                                          listPolicy[index].givenProductQuantity = 0;
                                        } else {
                                          listPolicy[index].givenProductQuantity = int.parse(value);
                                        }
                                        setState(() {});
                                      },
                                      onChangedDiscount: (value) {
                                        if (value == null) {
                                          listPolicy[index].discountValue = 0;
                                        } else {
                                          listPolicy[index].discountValue = int.parse(value);
                                        }
                                        setState(() {});
                                      },
                                      onChangedStartPrice: (value) {
                                        if (value == null) {
                                          listPolicy[index].startPrice = 0;
                                        } else {
                                          listPolicy[index].startPrice = int.parse(value);
                                        }
                                        setState(() {});
                                      },
                                      onTapClose: () {
                                        if (listPolicy.length > 1) {
                                          AppFunction.hideKeyboard(context);
                                          listPolicy.removeAt(index);
                                          setState(() {});
                                        } else {
                                          AppFunction.hideKeyboard(context);
                                        }
                                      },
                                      onTapSelectType: () {
                                        if (listPolicy[index].discountType == 'VALUE') {
                                          listPolicy[index].discountType = 'PERCENT';
                                        } else if (listPolicy[index].discountType == 'PERCENT') {
                                          listPolicy[index].discountType = 'VALUE';
                                        }
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              ButtonAddMethod(
                                onTap: () {
                                  AppFunction.hideKeyboard(context);
                                  listPolicy.add(
                                    ListPolicy(
                                        startPriceController: TextEditingController(),
                                        discountController: TextEditingController(),
                                        givenController: TextEditingController(),
                                        discountType: "VALUE",
                                        startPrice: 0,
                                        discountValue: 0,
                                        givenProductQuantity: 0,
                                        givenProductGroups: "",
                                        givenProductIds: "",
                                        discountProductGroups: "",
                                        discountProductIds: "",
                                        discountProductQuantity: 0,
                                        plusPointValue: 0,
                                        plusPointType: "VALUE",
                                        newPrice: 0,
                                        purchaseQuantity: 0,
                                        purchaseProductGroups: "",
                                        purchaseProductIds: "",
                                        listProductGiven: [],
                                        listProductDiscount: [],
                                        listProductPurchase: []),
                                  );
                                  setState(() {});
                                },
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MepharPickerDatetime(
                            icon: AppImages.iconCalendar,
                            labelText: "Từ ngày",
                            dateTimeByText: AppFunction.formatDate(DateTime.parse(startDay)),
                            onDateTimeChanged: (value) {
                              startDay = value.toString();
                              setState(() {});
                            },
                          ),
                          MepharPickerDatetime(
                            icon: AppImages.iconCalendar,
                            dateTimeByText: AppFunction.formatDate(DateTime.parse(endDay)),
                            labelText: "Đến ngày",
                            onDateTimeChanged: (value) {
                              endDay = value.toString();
                              setState(() {});
                            },
                          ),
                          const SizedBox(height: 16),
                          MultiSelect(
                            labelText: "Theo tháng",
                            hintText: "Chọn tháng",
                            options: AppFunction.mapMonth.keys.toList(),
                            selectedOptions: listMonthsSelect,
                            onSubmit: () {
                              selectedMonth = AppFunction.getValue(listMonthsSelect, AppFunction.mapMonth);
                              setState(() {});
                            },
                          ),
                          const SizedBox(height: 16),
                          MultiSelect(
                            labelText: "Theo ngày",
                            hintText: "Chọn ngày",
                            options: AppFunction.mapDay.keys.toList(),
                            selectedOptions: listDaysSelect,
                            onSubmit: () {
                              selectedDay = AppFunction.getValue(listDaysSelect, AppFunction.mapDay);
                              setState(() {});
                            },
                          ),
                          const SizedBox(height: 16),
                          MultiSelect(
                            labelText: "Theo thứ",
                            hintText: "Chọn thứ",
                            options: AppFunction.mapDayOfWeek.keys.toList(),
                            selectedOptions: listDayOfWeekSelect,
                            onSubmit: () {
                              selectedDayOfWeek = AppFunction.getValue(listDayOfWeekSelect, AppFunction.mapDayOfWeek);
                              setState(() {});
                            },
                          ),
                          const SizedBox(height: 16),
                          MultiSelect(
                            labelText: "Theo giờ",
                            hintText: "Chọn giờ",
                            options: listHour,
                            selectedOptions: listHourSelect,
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 12),
                            child: Wrap(
                              spacing: 0,
                              runSpacing: 0,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 8, left: 0),
                                  child: Checkbox(
                                      activeColor: AppThemes.red0,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                      value: isBirthdayPromotion,
                                      onChanged: (value) {
                                        setState(() {
                                          isBirthdayPromotion = value!;
                                        });
                                      }),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 25),
                                  child: Text(
                                    "Áp dụng vào",
                                    style: AppFonts.regular(
                                      14,
                                      AppThemes.dark2,
                                    ),
                                  ),
                                ),
                                MepharDropDownButton(
                                  width: 100,
                                  height: 50,
                                  hintText: "",
                                  items: const ["Ngày", "Tuần", "Tháng"],
                                  onChanged: (value) {
                                    if (value == "Tháng") {
                                      birthdayPromotionType = 'MONTH';
                                    } else if (value == 'Tuần') {
                                      birthdayPromotionType = 'WEEK';
                                    } else {
                                      birthdayPromotionType = 'DAY';
                                    }
                                    setState(() {});
                                  },
                                  haveHintText: false,
                                  haveBorder: false,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 25),
                                  child: Text(
                                    "sinh ",
                                    style: AppFonts.regular(
                                      14,
                                      AppThemes.dark2,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 25),
                                  child: Text(
                                    "nhật ",
                                    style: AppFonts.regular(
                                      14,
                                      AppThemes.dark2,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 25),
                                  child: Text(
                                    "của ",
                                    style: AppFonts.regular(
                                      14,
                                      AppThemes.dark2,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 25),
                                  child: Text(
                                    "khách ",
                                    style: AppFonts.regular(
                                      14,
                                      AppThemes.dark2,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 25),
                                  child: Text(
                                    "hàng.",
                                    style: AppFonts.regular(
                                      14,
                                      AppThemes.dark2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MepharRadioButton(
                              title: "Toàn hệ thống",
                              isSelected: selectedAll == "Toàn hệ thống",
                              onSelected: (value) {
                                setState(() {
                                  selectedAll = value;
                                });
                              }),
                          const SizedBox(
                            height: 18,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              MepharRadioButton(
                                title: "Chi nhánh",
                                isSelected: selectedAll == "Chi nhánh",
                                onSelected: (value) {
                                  setState(() {
                                    selectedAll = value;
                                  });
                                },
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              // Expanded(
                              //     child: (selectedAll == "Chi nhánh")
                              //         ? MultiSelect(
                              //             haveBorder: true,
                              //             options: context.watch<BranchProvider>().listStringBranch,
                              //             selectedOptions: listBranchSelect,
                              //             isArea: true,
                              //             labelText: '',
                              //             hintText: 'Chọn chi nhánh áp dụng',
                              //             onSubmit: _getBranchIds,
                              //           )
                              //         : const SizedBox.shrink()),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 5,
                            width: MediaQuery.of(context).size.width,
                            color: AppThemes.light2,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MepharRadioButton(
                              title: "Toàn bộ khách hàng",
                              isSelected: selectedCustomer == "Toàn bộ khách hàng",
                              onSelected: (value) {
                                setState(() {
                                  selectedCustomer = value;
                                });
                              }),
                          const SizedBox(
                            height: 18,
                          ),
                          Row(
                            children: [
                              MepharRadioButton(
                                title: "Nhóm khách hàng",
                                isSelected: selectedCustomer == "Nhóm khách hàng",
                                onSelected: (value) {
                                  setState(() {
                                    selectedCustomer = value;
                                  });
                                },
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                  child: (selectedCustomer == "Nhóm khách hàng")
                                      ? MultiSearch(
                                          listSelected: listCustomerSelected,
                                          getID: () {
                                            List<String> list = [];
                                            if (listCustomerSelected.isNotEmpty) {
                                              for (var e in listCustomerSelected) {
                                                if (e.id != null) {
                                                  list.add(e.id!);
                                                }
                                              }
                                              setState(() {
                                                groupCustomerIds = list.join(",");
                                              });
                                            }
                                          },
                                        )
                                      : const SizedBox.shrink())
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 5,
                            width: MediaQuery.of(context).size.width,
                            color: AppThemes.light2,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MepharRadioButton(
                              title: "Toàn bộ người bán",
                              isSelected: selectedSeller == "Toàn bộ người bán",
                              onSelected: (value) {
                                setState(() {
                                  selectedSeller = value;
                                });
                              }),
                          const SizedBox(
                            height: 18,
                          ),
                          Row(
                            children: [
                              MepharRadioButton(
                                title: "Người bán",
                                isSelected: selectedSeller == "Người bán",
                                onSelected: (value) {
                                  setState(() {
                                    selectedSeller = value;
                                  });
                                },
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: (selectedSeller == "Người bán")
                                    ? SearchSupplierMulti(
                                        listSelectedSupplier: listSupplierSelected,
                                        getID: () {
                                          List<String> list = [];
                                          if (listSupplierSelected.isNotEmpty) {
                                            for (var e in listSupplierSelected) {
                                              if (e.id != null) {
                                                list.add(e.id!);
                                              }
                                            }
                                            setState(() {
                                              sellerIds = list.join(",");
                                            });
                                          }
                                        },
                                      )
                                    : const SizedBox.shrink(),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(AppDimens.spaceMediumLarge),
              child: MepharButton(
                titleButton: "Lưu",
                onPressed: () async {
                  AppFunction.hideKeyboard(context);
                  if (name.text.trim() == "") {
                    AppFunction.showDialogError(context, "Không được để trống tên khuyến mãi");
                  } else {
                    var res = await ApiRequest.createPromotion(
                        code: code.text,
                        name: name.text,
                        branchIds: branchIds,
                        groupCustomerIds: groupCustomerIds,
                        sellerIds: sellerIds,
                        status: selected == "Kích hoạt" ? 'ACTIVATED' : 'NOT_ACTIVATED',
                        note: note.text,
                        type: type,
                        birthdayPromotionType: birthdayPromotionType,
                        method: method,
                        listPolicy: listPolicy,
                        multiplyByQuantity: multiplyByQuantity,
                        startTime: startDay,
                        endTime: endDay,
                        listMonths: selectedMonth,
                        listDayOfWeek: selectedDayOfWeek,
                        listDays: selectedDay,
                        listHours: listHourSelect.join(","));
                    if (res.result == true) {
                      if (context.mounted) Navigator.pop(context, true);
                    } else {
                      if (context.mounted) {
                        AppFunction.showDialogError(context, res.message ?? "Có lỗi bất ngờ xảy ra");
                      }
                    }
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
