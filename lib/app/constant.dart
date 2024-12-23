class PaymentMethodModel {
  String label;
  String value;

  PaymentMethodModel({required this.label, required this.value});
}

class AppConstant {
  static Map<PayType, PaymentMethodModel> mapPayType = {
    PayType.cash: PaymentMethodModel(label: "Tiền mặt", value: "CASH"),
    PayType.bank: PaymentMethodModel(label: "Chuyển khoản", value: "BANK"),
    PayType.debt: PaymentMethodModel(label: "Khách nợ", value: "DEBT"),
  };

  static List<Map<String, String>> mapPermission = [
    {"model": "home", "action": "read"},
    {"model": "sale", "action": "read"},
    {"model": "product"},
    {"model": "list_product", "action": "read", "parentId": "product"},
    {"model": "list_product", "action": "create", "parentId": "product"},
    {"model": "list_product", "action": "update", "parentId": "product"},
    {"model": "list_product", "action": "delete", "parentId": "product"},
    {"model": "import_product", "action": "read", "parentId": "product"},
    {"model": "import_product", "action": "create", "parentId": "product"},
    {"model": "import_product", "action": "update", "parentId": "product"},
    {"model": "import_product", "action": "delete", "parentId": "product"},
    {"model": "return_product", "action": "read", "parentId": "product"},
    {"model": "return_product", "action": "create", "parentId": "product"},
    {"model": "return_product", "action": "update", "parentId": "product"},
    {"model": "return_product", "action": "delete", "parentId": "product"},
    {"model": "check_inventory", "action": "read", "parentId": "product"},
    {"model": "check_inventory", "action": "create", "parentId": "product"},
    {"model": "check_inventory", "action": "update", "parentId": "product"},
    {"model": "check_inventory", "action": "delete", "parentId": "product"},
    {"model": "price_setting", "action": "read", "parentId": "product"},
    {"model": "price_setting", "action": "create", "parentId": "product"},
    {"model": "price_setting", "action": "update", "parentId": "product"},
    {"model": "price_setting", "action": "delete", "parentId": "product"},
    {"model": "market"},
    {"model": "market_common", "action": "read", "parentId": "market"},
    {"model": "market_common", "action": "create", "parentId": "market"},
    {"model": "market_common", "action": "update", "parentId": "market"},
    {"model": "market_common", "action": "delete", "parentId": "market"},
    {"model": "market_store", "action": "read", "parentId": "market"},
    {"model": "market_store", "action": "create", "parentId": "market"},
    {"model": "market_store", "action": "update", "parentId": "market"},
    {"model": "market_store", "action": "delete", "parentId": "market"},
    {"model": "market_setting", "action": "read", "parentId": "market"},
    {"model": "market_setting", "action": "create", "parentId": "market"},
    {"model": "market_setting", "action": "update", "parentId": "market"},
    {"model": "market_setting", "action": "delete", "parentId": "market"},
    {"model": "medicine_category", "action": "read", "parentId": "medicine_category"},
    {"model": "medicine_category", "action": "create", "parentId": "medicine_category"},
    {"model": "medicine_category", "action": "update", "parentId": "medicine_category"},
    {"model": "medicine_category", "action": "delete", "parentId": "medicine_category"},
    {"model": "transaction"},
    {"model": "bill", "action": "read", "parentId": "transaction"},
    {"model": "bill", "action": "create", "parentId": "transaction"},
    {"model": "bill", "action": "update", "parentId": "transaction"},
    {"model": "bill", "action": "delete", "parentId": "transaction"},
    {"model": "order", "action": "read", "parentId": "transaction"},
    {"model": "order", "action": "create", "parentId": "transaction"},
    {"model": "order", "action": "update", "parentId": "transaction"},
    {"model": "order", "action": "delete", "parentId": "transaction"},
    {"model": "return", "action": "read", "parentId": "transaction"},
    {"model": "return", "action": "create", "parentId": "transaction"},
    {"model": "return", "action": "update", "parentId": "transaction"},
    {"model": "return", "action": "delete", "parentId": "transaction"},
    {"model": "delivery", "action": "read", "parentId": "transaction"},
    {"model": "delivery", "action": "create", "parentId": "transaction"},
    {"model": "delivery", "action": "update", "parentId": "transaction"},
    {"model": "delivery", "action": "delete", "parentId": "transaction"},

    //doi tac
    {"model": "partner"},
    {"model": "customer", "action": "read", "parentId": "partner"},
    {"model": "customer", "action": "create", "parentId": "partner"},
    {"model": "customer", "action": "update", "parentId": "partner"},
    {"model": "customer", "action": "delete", "parentId": "partner"},
    {"model": "group_customer", "action": "read", "parentId": "partner"},
    {"model": "group_customer", "action": "create", "parentId": "partner"},
    {"model": "group_customer", "action": "update", "parentId": "partner"},
    {"model": "group_customer", "action": "delete", "parentId": "partner"},
    {"model": "provider", "action": "read", "parentId": "partner"},
    {"model": "provider", "action": "create", "parentId": "partner"},
    {"model": "provider", "action": "update", "parentId": "partner"},
    {"model": "provider", "action": "delete", "parentId": "partner"},
    {"model": "group_provider", "action": "read", "parentId": "partner"},
    {"model": "group_provider", "action": "create", "parentId": "partner"},
    {"model": "group_provider", "action": "update", "parentId": "partner"},
    {"model": "group_provider", "action": "delete", "parentId": "partner"},
    {"model": "doctor", "action": "read", "parentId": "partner"},
    {"model": "doctor", "action": "create", "parentId": "partner"},
    {"model": "doctor", "action": "update", "parentId": "partner"},
    {"model": "doctor", "action": "delete", "parentId": "partner"},
    {"model": "cashbook", "action": "read"},
    {"model": "cashbook", "action": "create"},
    {"model": "cashbook", "action": "update"},
    {"model": "cashbook", "action": "delete"},

    //bao cao
    {"model": "report"},
    {"model": "customer_report", "action": "read", "parentId": "report"},
    {"model": "customer_report", "action": "create", "parentId": "report"},
    {"model": "customer_report", "action": "update", "parentId": "report"},
    {"model": "customer_report", "action": "delete", "parentId": "report"},
    {"model": "provider_report", "action": "read", "parentId": "report"},
    {"model": "provider_report", "action": "create", "parentId": "report"},
    {"model": "provider_report", "action": "update", "parentId": "report"},
    {"model": "provider_report", "action": "delete", "parentId": "report"},
    {"model": "employee_report", "action": "read", "parentId": "report"},
    {"model": "employee_report", "action": "create", "parentId": "report"},
    {"model": "employee_report", "action": "update", "parentId": "report"},
    {"model": "employee_report", "action": "delete", "parentId": "report"},
    {"model": "sale_report", "action": "read", "parentId": "report"},
    {"model": "sale_report", "action": "create", "parentId": "report"},
    {"model": "sale_report", "action": "update", "parentId": "report"},
    {"model": "sale_report", "action": "delete", "parentId": "report"},
    {"model": "product_report", "action": "read", "parentId": "report"},
    {"model": "product_report", "action": "create", "parentId": "report"},
    {"model": "product_report", "action": "update", "parentId": "report"},
    {"model": "product_report", "action": "delete", "parentId": "report"},

    //cau hinh
    {"model": "config"},
    {"model": "store", "action": "read", "parentId": "config"},
    {"model": "store", "action": "create", "parentId": "config"},
    {"model": "store", "action": "update", "parentId": "config"},
    {"model": "store", "action": "delete", "parentId": "config"},
    {"model": "branch", "action": "read", "parentId": "config"},
    {"model": "branch", "action": "create", "parentId": "config"},
    {"model": "branch", "action": "update", "parentId": "config"},
    {"model": "branch", "action": "delete", "parentId": "config"},
    {"model": "employee", "action": "read", "parentId": "config"},
    {"model": "employee", "action": "create", "parentId": "config"},
    {"model": "employee", "action": "update", "parentId": "config"},
    {"model": "employee", "action": "delete", "parentId": "config"},
    {"model": "role", "action": "read", "parentId": "config"},
    {"model": "role", "action": "create", "parentId": "config"},
    {"model": "role", "action": "update", "parentId": "config"},
    {"model": "role", "action": "delete", "parentId": "config"},
    {"model": "discount", "action": "read", "parentId": "config"},
    {"model": "discount", "action": "create", "parentId": "config"},
    {"model": "discount", "action": "update", "parentId": "config"},
    {"model": "discount", "action": "delete", "parentId": "config"},
    {"model": "point_setting", "action": "read", "parentId": "config"},
    {"model": "point_setting", "action": "create", "parentId": "config"},
    {"model": "point_setting", "action": "update", "parentId": "config"},
    {"model": "point_setting", "action": "delete", "parentId": "config"},
    {"model": "connect_system", "action": "read", "parentId": "config"},
    {"model": "connect_system", "action": "create", "parentId": "config"},
    {"model": "connect_system", "action": "update", "parentId": "config"},
    {"model": "connect_system", "action": "delete", "parentId": "config"},
    {"model": "delivery_fee", "action": "read", "parentId": "config"},
    {"model": "delivery_fee", "action": "create", "parentId": "config"},
    {"model": "delivery_fee", "action": "update", "parentId": "config"},
    {"model": "delivery_fee", "action": "delete", "parentId": "config"},
    {"model": "connect_delivery", "action": "read", "parentId": "config"},
    {"model": "connect_delivery", "action": "create", "parentId": "config"},
    {"model": "connect_delivery", "action": "update", "parentId": "config"},
    {"model": "connect_delivery", "action": "delete", "parentId": "config"}
  ];
  static Map<String, String> mapSub = {
    "home": "Tổng quát",
    "sale": "Bán hàng",
    "list_product": "Danh sách sản phẩm",
    "import_product": "Nhập sản phẩm",
    "return_product": "Trả hàng nhập",
    "check_inventory": "Kiểm kho",
    "price_setting": "Thiết lập giá",
    "market_common": "Chợ",
    "market_store": "Chợ đại lý",
    "market_setting": "Cấu hình sản phẩm",
    "medicine_category": "Danh mục thuốc",
    "bill": "Hóa đơn",
    "order": "Đơn hàng",
    "return": "Trả hàng",
    "delivery": "Chuyển hàng",
    "customer": "Khách hàng",
    "group_customer": "Nhóm khách hàng",
    "provider": "Nhà cung cấp",
    "group_provider": "Nhóm nhà cung cấp",
    "doctor": "Bác sĩ",
    "cashbook": "Sổ quỹ",
    "customer_report": "Báo cáo khách hàng",
    "provider_report": "Báo cáo nhà cung cấp",
    "employee_report": "Báo cáo nhân viên",
    "sale_report": "Báo cáo bán hàng",
    "product_report": "Báo cáo sản phẩm",
    "store": "TT cửa hàng",
    "branch": "Quản lý chi nhánh",
    "employee": "Quản lý nhân viên",
    "role": "Quản lý vai trò và phân quyền",
    "discount": "Khuyến mại",
    "point_setting": "Thiết lập điểm",
    "connect_system": "Liên thông hệ thống dược",
    "delivery_fee": "Cấu hình phí vận chuyển",
    "connect_delivery": "Kết nối vận chuyển",
    "read": "Xem",
    "create": "Tạo",
    "update": "Sửa",
    "delete": "Xoá",
    "product": "Sản phẩm",
    "market": "Chợ",
    "transaction": "Giao dịch",
    "partner": "Đối tác",
    "report": "Báo cáo",
    "config": "Cấu hình",
  };
}

enum PayType { cash, bank, debt }



enum Permission { read, create, update, delete }
