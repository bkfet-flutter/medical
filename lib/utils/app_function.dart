import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/app/constant.dart';
import 'package:mephar_app/model/image_model.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/loading_provider.dart';
import 'package:mephar_app/provider/user_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/widgets/normal_dialog.dart';
import 'package:mephar_app/widgets/touchable_widget.dart';
import 'package:provider/provider.dart';

class AppFunction {
  static showLoading(BuildContext context) async {
    context.read<LoadingProvider>().showLoading();
  }

  static hideLoading(BuildContext context) async {
    context.read<LoadingProvider>().hideLoading();
  }

  static void hideKeyboard(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static bool checkNullAndFalse(bool? check) {
    if (check == null) {
      return false;
    } else if (check == false) {
      return false;
    }

    return true;
  }

  //Pick Time

  static void log(String text) {
    final pattern = RegExp('.{1,800}');
    pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
  }

  static bool isNullEmpty(Object o) => "" == o;

  static Future<DateTime> pickDate(BuildContext context, DateTime dateTimeText,
      {DateTime? minTime}) async {
    DateTime? pickedTime = await picker.DatePicker.showDatePicker(context,
        locale: picker.LocaleType.vi,
        currentTime: null,
        minTime: minTime,
        theme: picker.DatePickerTheme(
            cancelStyle: AppFonts.normalBold(16),
            doneStyle: AppFonts.normalBold(16)));
    if (pickedTime != null) {
      return pickedTime;
    } else {
      return dateTimeText;
    }
  }

  //Pick Date
  static Future<DateTime> pickTime(
      BuildContext context, DateTime dateTimeText) async {
    DateTime? pickedTime = await picker.DatePicker.showTimePicker(context,
        locale: picker.LocaleType.vi,
        showSecondsColumn: false,
        theme: picker.DatePickerTheme(
          cancelStyle: AppFonts.normalBold(
            16,
          ),
          doneStyle: AppFonts.normalBold(
            16,
          ),
        ));
    if (pickedTime != null) {
      return pickedTime;
    } else {
      return dateTimeText;
    }
  }

  //validate-phone
  static checkValidPhone(String? phone) {
    // String phoneNumber = AppUtils.convertPhoneToOrigin(phone);
    bool isValid = false;
    if (phone != null) {
      String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
      RegExp regExp = RegExp(pattern);
      if (phone.length == 10) {
        String firstNumber = phone.substring(0, 2);
        isValid = (firstNumber == '09' ||
            firstNumber == '08' ||
            firstNumber == '07' ||
            firstNumber == '03' ||
            firstNumber == '05');
      }
      if (!regExp.hasMatch(phone)) {
        isValid = false;
      }
      return isValid;
    }
    return isValid;
  }

  //validate-email
  static bool validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegex.hasMatch(email)) {
      return false;
    }
    return true;
  }

  // check_image
  static bool checkImage(String? image) {
    if (image == null) {
      return false;
    }

    try {
      Uri logoUri = Uri.parse(image);
      return (logoUri.isAbsolute && logoUri.hasScheme && logoUri.hasAuthority);
    } catch (e) {
      return false;
    }
  }

  static final imagePicker = ImagePicker();

  static Future<ImageModel?> pickImage({ImageSource? source}) async {
    XFile? image = await imagePicker.pickImage(
      maxHeight: 480,
      maxWidth: 640,
      source: source ?? ImageSource.gallery,
    );
    if (image != null) {
      var res = await ApiRequest.uploadImages(imagePaths: image);
      if (res.result == true) {
        ImageModel imageModel = ImageModel.fromJson(res.data);
        return imageModel;
      }
    }
    return null;
  }

  static Future<ImageModel?> pickCamera({ImageSource? source}) async {
    XFile? image = await imagePicker.pickImage(
      maxHeight: 480,
      maxWidth: 640,
      source: source ?? ImageSource.camera,
    );
    if (image != null) {
      var res = await ApiRequest.uploadImages(imagePaths: image);
      if (res.result == true) {
        ImageModel imageModel = ImageModel.fromJson(res.data);
        return imageModel;
      }
    }
    return null;
  }

  static void customBottomSheet({
    required BuildContext context, //bắt buộc phải có để show
    required Widget body, //phần thân
    Color? bodyColors, //màu của bottomsheeet
    String? title, //phần tittle k truyền vào sẽ k có nút close và devider
    bool? showButtonClose, // có show nút close k
    Color? backgroundColors, // màu đằng sau của mà hình khi có bottom sheeet
    bool? closeWhenTouch, //khi bấm ra màn hình sẽ close bottom sheet
    bool? isScroll, // bottom sheet có thể scroll hay k
    double? height,
  }) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: isScroll ?? true,
        isDismissible: closeWhenTouch ?? false,
        barrierColor: backgroundColors ?? AppThemes.black.withOpacity(0.3),
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            height: height ?? MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              color: bodyColors ?? Colors.white,
            ),
            child: Column(
              children: [
                (title != null && title != "")
                    ? Container(
                        //   margin: EdgeInsets.only(top: 15),
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 12),
                          child: Row(
                            children: [
                              const Expanded(flex: 1, child: SizedBox()),
                              Expanded(
                                flex: 4,
                                child: Center(
                                  child: Text(
                                    title,
                                    style: AppFonts.bold(),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child:
                                    (showButtonClose != null && showButtonClose)
                                        ? TouchableWidget(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Icon(
                                              Icons.close,
                                              size: 25,
                                              weight: 10,
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                              )
                            ],
                          ),
                        ),
                      )
                    : const Padding(padding: EdgeInsets.only(top: 30)),
                (title != null && title != "")
                    ? Container(
                        height: 1,
                        color: AppThemes.light1,
                        width: MediaQuery.of(context).size.width,
                      )
                    : const SizedBox.shrink(),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                  ),
                  child: Center(child: body),
                ))
              ],
            ),
          );
        });
  }

  static void customRightSheet({
    required BuildContext context,
    required Widget body,
    Color? bodyColors,
    String? title,
    bool? showButtonClose,
    Color? backgroundColors,
    bool? closeWhenTouch,
    bool? isScroll,
    double? height,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: body,
          ),
        );
      },
    );
  }

  //showDialog Error
  static void showDialogError(BuildContext context, String? errText,
      {String? title,
      Function()? onPressButton,
      String? image,
      TextAlign? descriptionTextAlign,
      String? textButton}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return NormalDialog(
            image: image,
            onPress1stButton: onPressButton,
            title: title ?? "Lỗi",
            description: errText ?? "Bad Error",
            styleDescription: const TextStyle(
                color: AppThemes.red0, fontSize: 16, fontFamily: AppFonts.laTo),
            descriptionTextAlign: descriptionTextAlign,
            text1stButton: textButton ?? "Đóng lại",
          );
        });
  }

  //show dialog
  static void showDialogAlert(BuildContext context,
      {String? title,
      String? description,
      String? text1stButton,
      String? text2ndButton,
      Function()? onPress1stButton,
      Function()? onPress2ndButton,
      Function()? onPressedClose,
      bool? isTwoButton,
      Widget? widgetDescription,
      String? image,
      Widget? customImage,
      bool? hideBtnBottom,
      TextStyle? styleTitle,
      TextStyle? styleDescription,
      String? imageClose,
      bool? noDivider,
      bool? dismiss,
      bool? showBtnClose}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return NormalDialog(
            dismiss: dismiss,
            onPressedClose: onPressedClose,
            title: title,
            styleTitle: styleTitle,
            description: description,
            text1stButton: text1stButton,
            text2ndButton: text2ndButton,
            onPress1stButton: onPress1stButton,
            onPress2ndButton: onPress2ndButton,
            isTwoButton: isTwoButton,
            widgetDescription: widgetDescription,
            image: image,
            showBtnClose: showBtnClose,
            customImage: customImage,
            hideBtnBottom: hideBtnBottom,
            noDivider: noDivider,
            styleDescription: styleDescription,
            imageClose: imageClose,
          );
        });
  }

  static void showDialogAddGroup(BuildContext context,
      {String? title,
      String? description,
      String? text1stButton,
      String? text2ndButton,
      Function()? onPress1stButton,
      Function()? onPress2ndButton,
      Function()? onPressedClose,
      bool? isTwoButton,
      Widget? widgetDescription,
      String? image,
      Widget? customImage,
      bool? hideBtnBottom,
      TextStyle? styleTitle,
      TextStyle? styleDescription,
      String? imageClose,
      bool? noDivider,
      bool? showBtnClose}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return NormalDialog(
          onPressedClose: onPressedClose,
          title: title,
          styleTitle: styleTitle,
          description: description,
          text1stButton: text1stButton,
          text2ndButton: text2ndButton,
          onPress1stButton: onPress1stButton,
          onPress2ndButton: onPress2ndButton,
          isTwoButton: isTwoButton,
          widgetDescription: widgetDescription,
          image: image,
          showBtnClose: showBtnClose,
          customImage: customImage,
          hideBtnBottom: hideBtnBottom,
          noDivider: noDivider,
          styleDescription: styleDescription,
          imageClose: imageClose,
        );
      },
    );
  }

  // //print-pdf
  // static Future<void> printPdf() async {
  //   final pdf = pw.Document();

  //   pdf.addPage(
  //     pw.Page(
  //       build: (pw.Context context) => pw.Center(
  //         child: pw.Text('Hello World!'),
  //       ),
  //     ),
  //   );

  //   final file = File('example.pdf');
  //   await file.writeAsBytes(await pdf.save());
  // }
  static void scrollToTextField(
      TextEditingController controller, BuildContext context) {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (controller.selection.baseOffset > -1) {
        final scrollController = PrimaryScrollController.of(context);
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // static String formatCurrency(num amount) {
  //   // Tạo đối tượng NumberFormat để format số
  //   NumberFormat format = NumberFormat.currency(locale: 'vi_VN', symbol: '');
  //
  //   // Định dạng số thành chuỗi yêu cầu
  //   String formattedAmount = format.format(amount);
  //
  //   return '$formattedAmount';
  // }

  static String formatDateString(String dateString) {
    try {
      if (dateString == null || dateString.isEmpty) {
        throw Exception('Date string is null or empty.');
      }

      DateTime dateTime = DateTime.parse(dateString);

      // Format the date as "dd-MM-yyyy".
      String formattedDate =
          "${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year.toString()}";

      return formattedDate;
    } catch (e) {
      // Handle any parsing or formatting errors here.
      print("Error: $e");
      return ''; // Return an empty string in case of errors.
    }
  }

  static String removeSpecialCharacters(String inputString) {
    if (inputString == null || inputString.isEmpty) {
      return '';
    }

    // Sử dụng biểu thức chính quy để loại bỏ tất cả các kí tự không phải là số (\d)
    return inputString.replaceAll(RegExp(r'[^\d]+'), '');
  }

  static findMethod(String? element) {
    return map.keys.firstWhere((k) => map[k] == element, orElse: () => "");
  }

  static Map<String, String> map = {
    "DISCOUNT_BILL": "Giảm giá hóa đơn",
    "GIFTING_PRODUCTS": "Tặng hàng",
    "GIFTING_PRODUCT_WHEN_BUY_PRODUCT": "Mua hàng tặng hàng",
    "DISCOUNT_PRODUCT_WHEN_BUY_PRODUCT": "Mua hàng giảm giá hàng",
  };

  static getStatus(String? status) {
    if (status?.toUpperCase() == "ACTIVATED") {
      return "Kích hoạt";
    } else if (status?.toUpperCase() == "NOT_ACTIVATED") {
      return "Chưa áp dụng";
    } else {
      return status;
    }
  }

  static String? formatValueDiscount(int? value, String? type) {
    if (type == "VALUE") {
      String newValue = NumberFormat('#,###.##').format(value);
      return '$newValue VNĐ';
    }
    if (type == "PERCENT") {
      String newValue = NumberFormat('#,###.##').format(value);
      return '$newValue %';
    } else {
      return null;
    }
  }

// validate
  static bool checkFullName(BuildContext context, String fullName) {
    bool checkfullName = true;
    if (fullName.length >= 6 && fullName.length <= 40) {
      return checkfullName;
    } else {
      AppFunction.showDialogError(
          context, "Vui lòng điền đầy đủ họ và tên của bạn");
      return !checkfullName;
    }
  }

  static bool checkNameSupplier(BuildContext context, String name) {
    bool checkNameSupplier = true;
    if (name.length >= 6 && name.length <= 40) {
      return checkNameSupplier;
    } else {
      AppFunction.showDialogError(context, "Vui lòng ghĩ rõ tên nhà cung cấp ");
      return !checkNameSupplier;
    }
  }

  static bool checkNameCompany(BuildContext context, String name) {
    bool checkNameCompany = true;
    if (name.length >= 6 && name.length <= 40) {
      return checkNameCompany;
    } else {
      AppFunction.showDialogError(context, "Vui lòng ghi tên công ty ");
      return !checkNameCompany;
    }
  }

  static bool checkName(BuildContext context, String name) {
    bool checkNameCompany = true;
    if (name.length >= 6 && name.length <= 40) {
      return checkNameCompany;
    } else {
      AppFunction.showDialogError(context, "Vui lòng ghi tên công ty ");
      return !checkNameCompany;
    }
  }

  static bool checkPhone(BuildContext context, String phone) {
    bool checkPhone = true;
    String pattern = r'^(09|08|07|03|05)[0-9]{8}$';
    RegExp regExp = RegExp(pattern);

    if (regExp.hasMatch(phone) && phone.length == 10) {
      return checkPhone;
    } else {
      AppFunction.showDialogError(context, 'Số điện thoại không hợp lệ');
      return !checkPhone;
    }
  }

  static bool checkEmail(BuildContext context, String email) {
    bool checkEmail = true;
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    bool isValidEmail = RegExp(pattern).hasMatch(email);
    if (isValidEmail) {
      return checkEmail;
    } else {
      AppFunction.showDialogError(
        context,
        "Email không hợp lệ",
      );
      return !checkEmail;
    }
  }

  static bool checkGender(BuildContext context, String? gender) {
    bool checkGender = true;
    if (gender == null) {
      AppFunction.showDialogError(
        context,
        "Vui lòng chọn giới tính",
      );
      return !checkGender;
    } else {
      return checkGender;
    }
  }

  static bool checkGroupCustomer(BuildContext context, int? groupCustomer) {
    bool checkGroupCustomer = true;
    if (groupCustomer == null) {
      AppFunction.showDialogError(
        context,
        "Vui lòng chọn nhóm khách hàng",
      );
      return !checkGroupCustomer;
    } else {
      return checkGroupCustomer;
    }
  }

  static bool checkGroupSupplier(BuildContext context, int? typeSupplier) {
    bool checkTypeSupplier = true;
    if (typeSupplier == null) {
      AppFunction.showDialogError(
        context,
        "Vui lòng chọn nhóm nhà cung cấp",
      );
      return !checkTypeSupplier;
    } else {
      return checkTypeSupplier;
    }
  }

  static bool checkTypeCustomer(BuildContext context, int? typeCustomer) {
    bool checkTypeCustomer = true;
    if (typeCustomer == null) {
      AppFunction.showDialogError(
        context,
        "Vui lòng chọn loại khách hàng",
      );
      return !checkTypeCustomer;
    } else {
      return checkTypeCustomer;
    }
  }

  static bool checkStore(BuildContext context, int? typeCustomer) {
    bool checkStore = true;
    if (typeCustomer == null) {
      AppFunction.showDialogError(
        context,
        "Vui lòng chi nhánh",
      );
      return !checkStore;
    } else {
      return checkStore;
    }
  }

  static bool checkBirthDayCustomer(BuildContext context, String? birthDay) {
    bool checkBirthDayCustomer = true;
    if (birthDay == null) {
      AppFunction.showDialogError(
        context,
        "Vui lòng chọn ngày sinh",
      );
      return !checkBirthDayCustomer;
    } else {
      return checkBirthDayCustomer;
    }
  }

  static bool checkStatusCustomer(BuildContext context, String? status) {
    bool checkStatusCustomer = true;
    if (status == null) {
      AppFunction.showDialogError(
        context,
        "Vui lòng chọn trạng thái hoạt động",
      );
      return !checkStatusCustomer;
    } else {
      return checkStatusCustomer;
    }
  }

  static bool checkAddress(
      BuildContext context, int? province, int? district, int? ward) {
    bool checkAddress = true;
    if (province == null && district == null && ward == null) {
      AppFunction.showDialogError(
        context,
        "Vui lòng chọn đầy đủ thông tin địa chỉ",
      );
      return !checkAddress;
    } else {
      return checkAddress;
    }
  }

  static bool checkString(BuildContext context, String string) {
    bool checkString = true;
    if (string.isNotEmpty == true) {
      return checkString;
    } else {
      AppFunction.showDialogError(
        context,
        "Vui lòng hoàn thành các thông tin",
      );
      return !checkString;
    }
  }

  static bool checkBusinessNumber(BuildContext context, String string) {
    bool checkBusinessNumber = true;
    if (string.isNotEmpty == false) {
      AppFunction.showDialogError(
        context,
        "Vui lòng điền mã số thuế",
      );
      return !checkBusinessNumber;
    } else {
      return checkBusinessNumber;
    }
  }

  static List<int> getVisiblePages(int currentPage, int totalPages) {
    const int maxVisiblePages = 4;

    if (totalPages <= maxVisiblePages) {
      return List.generate(totalPages, (index) => index + 1);
    } else {
      const int halfVisiblePages = maxVisiblePages ~/ 2;
      final int start = currentPage - halfVisiblePages;
      final int end = currentPage + halfVisiblePages;

      if (start <= 0) {
        return List.generate(maxVisiblePages, (index) => index + 1);
      } else if (end >= totalPages) {
        return List.generate(maxVisiblePages,
            (index) => totalPages - maxVisiblePages + index + 1);
      } else {
        return List.generate(maxVisiblePages, (index) => start + index);
      }
    }
  }

  static Map<String, String> mapMonth = {
    "Tháng 1": "1",
    "Tháng 2": "2",
    "Tháng 3": "3",
    "Tháng 4": "4",
    "Tháng 5": "5",
    "Tháng 6": "6",
    "Tháng 7": "7",
    "Tháng 8": "8",
    "Tháng 9": "9",
    "Tháng 10": "10",
    "Tháng 11": "11",
    "Tháng 12": "12",
  };
  static Map<String, String> mapDay = {
    "Ngày 1": "1",
    "Ngày 2": "2",
    "Ngày 3": "3",
    "Ngày 4": "4",
    "Ngày 5": "5",
    "Ngày 6": "6",
    "Ngày 7": "7",
    "Ngày 8": "8",
    "Ngày 9": "9",
    "Ngày 10": "10",
    "Ngày 11": "11",
    "Ngày 12": "12",
    "Ngày 13": "13",
    "Ngày 14": "14",
    "Ngày 15": "15",
    "Ngày 16": "16",
    "Ngày 17": "17",
    "Ngày 18": "18",
    "Ngày 19": "19",
    "Ngày 20": "20",
    "Ngày 21": "21",
    "Ngày 22": "22",
    "Ngày 23": "23",
    "Ngày 24": "24",
    "Ngày 25": "25",
    "Ngày 26": "26",
    "Ngày 27": "27",
    "Ngày 28": "28",
    "Ngày 29": "29",
    "Ngày 30": "30",
    "Ngày 31": "31",
  };
  static Map<String, String> mapDayOfWeek = {
    "Chủ nhật": "0",
    "Thứ 2": "1",
    "Thứ 3": "2",
    "Thứ 4": "3",
    "Thứ 5": "4",
    "Thứ 6": "5",
    "Thứ 7": "6",
  };

  static getDayOfWeekFromApi(String? input) {
    List<String> value = [];
    if (input == null || input == "") {
      return null;
    } else {
      List<String> list = input.split(',');
      for (var e in list) {
        value.add(mapDayOfWeek.keys
            .firstWhere((k) => mapDayOfWeek[k] == e, orElse: () => ""));
      }
      return value.join(", ");
    }
  }

  static String getValue(List<String> keysList, Map<String, String> map) {
    List<String> valueList = [];
    for (var e in keysList) {
      String? value = map[e];
      if (value != null) {
        valueList.add(value);
      }
    }
    return valueList.join(",");
  }

  static formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(date);
    return formatted;
  }

  static formatDateRange(DateTime? date) {
    if (date == null) {
      return 'dd/MM/yyyy';
    } else {
      final DateFormat formatter = DateFormat('dd/MM/yyyy');
      final String formatted = formatter.format(date);
      return formatted;
    }
  }
  static String getYearMonthDay(DateTime dateTime) {
  return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
}

  static Future<List<XFile>?> pickImages() async {
    final picker = ImagePicker();

    // Hiển thị hộp thoại chọn ảnh
    final pickedFiles = await picker.pickMultiImage(
      imageQuality: 80,
      maxWidth: 800,
      maxHeight: 800,
    );
    if (pickedFiles.isNotEmpty) {
      // Trả về danh sách File của các ảnh đã chọn
      return pickedFiles;
    } else {
      // Người dùng không chọn ảnh
      return null;
    }
  }

  static bool isNullOrEmpty(dynamic value) {
    if (value is String?) {
      return value == null || value.trim() == "";
    }
    if (value is int?) {
      return value == null;
    }
    return false;
  }

  static showDialogSuccess(BuildContext context, {required String content}) {
    AppFunction.showDialogAlert(context,
        customImage: Image.asset(
          AppImages.notiSuccess,
          width: 116,
          height: 120,
          fit: BoxFit.cover,
        ),
        noDivider: true,
        showBtnClose: true,
        hideBtnBottom: true,
        title: "Thành công",
        styleTitle: AppFonts.normalBoldInter(
          20,
          AppThemes.green0,
        ),
        styleDescription: AppFonts.light(
          16,
          AppThemes.dark1,
        ),
        imageClose: AppImages.closeNormal,
        description: content);
  }

  static String formatDateTimeFromApi(String? input, {bool? haveTime}) {
    if (input != null) {
      final date = DateTime.parse(input);
      if (haveTime == true) {
        final DateFormat formatter = DateFormat('dd/MM/yyyy hh:mm');
        final String formatted = formatter.format(date);
        return formatted;
      } else {
        final DateFormat formatter = DateFormat('dd/MM/yyyy');
        final String formatted = formatter.format(date);
        return formatted;
      }
    } else {
      return "";
    }
  }

  static int textToInt(TextEditingController? input) {
    if (input == null) {
      return 0;
    } else {
      int? inputInt = int.tryParse(input.text);
      return inputInt ?? 0;
    }
  }

  static int totalAmount(TextEditingController? quantity,
      TextEditingController? price, TextEditingController? discount) {
    int sum = textToInt(quantity) * textToInt(price) - textToInt(discount);
    return sum;
  }

  static int totalAmountNoDiscount(
      TextEditingController? quantity, TextEditingController? price) {
    int sum = textToInt(quantity) * textToInt(price);
    return sum;
  }

  static checkPermission(BuildContext context,
      {required String model, required Permission permission}) {
    var user = Provider.of<UserProvider>(context, listen: false);
    final check = user.userPermission
            .firstWhere((element) => element.model == model)
            .action ==
        permission.name;
    return check;
  }

  static String formatNum(num? input) {
    if (input != null) {
      final formatter = NumberFormat("#,###,###");
      return formatter.format(input);
    } else {
      return "0";
    }
  }

  static String formatStringNum(String? input) {
    if (input != null) {
      final cleanInput = input.replaceAll(RegExp(r'[,\s]'), '');

      // Nếu chuỗi rỗng, trả về "0"
      if (cleanInput.isEmpty) {
        return '0';
      }

      // Chuyển đổi chuỗi thành số nguyên
      final number = int.parse(cleanInput);

      // Định dạng số với dấu phẩy
      final formatter = NumberFormat('#,###,###');
      return formatter.format(number);
    } else {
      return "0";
    }
  }

  static int formatStringToNum(String? input) {
    if (input != null) {
      int number = int.parse(input.replaceAll(",", ""));
      return number;
    } else {
      return 0;
    }
  }
}
