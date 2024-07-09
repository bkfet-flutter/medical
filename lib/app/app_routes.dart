import 'package:flutter/material.dart';
import 'package:mephar_app/screens/cash_book/cash_book_screen.dart';
import 'package:mephar_app/screens/cash_book/cash_bool_detail_screen.dart';
import 'package:mephar_app/screens/configuration/branch/add_new_branch_screen.dart';
import 'package:mephar_app/screens/configuration/branch/branch_management_screen.dart';
import 'package:mephar_app/screens/configuration/configuration_screen.dart';
import 'package:mephar_app/screens/configuration/delegation/add_new_role_screen.dart';
import 'package:mephar_app/screens/configuration/delegation/delegation_role_screen.dart';
import 'package:mephar_app/screens/configuration/delegation/edit_permission_screen.dart';
import 'package:mephar_app/screens/configuration/point/set_up_point_screen.dart';
import 'package:mephar_app/screens/configuration/promotion/add_new_promotion_screen.dart';
import 'package:mephar_app/screens/configuration/promotion/configuration_promotion_screen.dart';
import 'package:mephar_app/screens/configuration/promotion/promotion_detail_screen.dart';
import 'package:mephar_app/screens/configuration/staff/add_new_staff_screen.dart';
import 'package:mephar_app/screens/configuration/staff/staff_manager_screen.dart';
import 'package:mephar_app/screens/configuration/store/store_information_screen.dart';
import 'package:mephar_app/screens/customer/group_customer/edit_group_customer_screen.dart';
import 'package:mephar_app/screens/customer/single_customer/add_customer_screen.dart';
import 'package:mephar_app/screens/customer/group_customer/add_group_customer_screen.dart';
import 'package:mephar_app/screens/customer/single_customer/customer_detail_screen.dart';
import 'package:mephar_app/screens/customer/customer_screen.dart';
import 'package:mephar_app/screens/customer/single_customer/debts_from_customer.dart';
import 'package:mephar_app/screens/customer/single_customer/edit_information_customer.dart';
import 'package:mephar_app/screens/customer/group_customer/group_customer_screen.dart';
import 'package:mephar_app/screens/customer/single_customer/list_customer_screen.dart';
import 'package:mephar_app/screens/doctor/add_doctor_screen.dart';
import 'package:mephar_app/screens/doctor/detail_doctor_screen.dart';
import 'package:mephar_app/screens/doctor/edit_doctor_screen.dart';
import 'package:mephar_app/screens/doctor/list_doctor_screen.dart';
import 'package:mephar_app/screens/enter_product/enter_product_screen.dart';
import 'package:mephar_app/screens/home/add_setting_screen.dart';
import 'package:mephar_app/screens/home/edit_profile_screen.dart';
import 'package:mephar_app/screens/home/home_main.dart';
import 'package:mephar_app/screens/intro/onboarding_screen.dart';
import 'package:mephar_app/screens/intro/splash_screen.dart';
import 'package:mephar_app/screens/inventory/inventory_control_add_screen.dart';
import 'package:mephar_app/screens/inventory/inventory_control_detail_screen.dart';
import 'package:mephar_app/screens/inventory/inventory_control_screen.dart';
import 'package:mephar_app/screens/login/forgot_password_screen.dart';
import 'package:mephar_app/screens/login/login_screen.dart';
import 'package:mephar_app/screens/login/otp_screen.dart';
import 'package:mephar_app/screens/login/register_screen.dart';
import 'package:mephar_app/screens/login/reset_password_screen.dart';
import 'package:mephar_app/screens/market/pages/add_address_page.dart';
import 'package:mephar_app/screens/market/pages/add_new_product_to_market_page.dart';
import 'package:mephar_app/screens/market/pages/cart_page.dart';
import 'package:mephar_app/screens/market/pages/delivery_address_page.dart';
import 'package:mephar_app/screens/market/pages/edit_address_page.dart';
import 'package:mephar_app/screens/market/pages/edit_product_market.dart';
import 'package:mephar_app/screens/market/pages/filter_market_page.dart';
import 'package:mephar_app/screens/market/pages/list_store_page.dart';
import 'package:mephar_app/screens/market/pages/order_details_page.dart';
import 'package:mephar_app/screens/market/pages/order_history_page.dart';
import 'package:mephar_app/screens/market/pages/order_page.dart';
import 'package:mephar_app/screens/market/pages/payment_page.dart';
import 'package:mephar_app/screens/market/pages/product_details.dart';
import 'package:mephar_app/screens/market/pages/product_details_in_market.dart';
import 'package:mephar_app/screens/market/pages/product_in_markert_page.dart';
import 'package:mephar_app/screens/market/pages/purchase_order_page.dart';
import 'package:mephar_app/screens/market/pages/sales_order_page.dart';
import 'package:mephar_app/screens/market/pages/search_page.dart';
import 'package:mephar_app/screens/market/pages/shipping_method_page.dart';
import 'package:mephar_app/screens/market/pages/store_profile_page.dart';
import 'package:mephar_app/screens/medicine/medicine_category_screen.dart';
import 'package:mephar_app/screens/oder/oder_buy_screen.dart';
import 'package:mephar_app/screens/product/combo/add_new_combo_screen.dart';
import 'package:mephar_app/screens/product/medicine/add_new_medicine_screen.dart';
import 'package:mephar_app/screens/product/medicine/copy_medicine.dart';
import 'package:mephar_app/screens/product/medicine/edit_medeicine.dart';
import 'package:mephar_app/screens/product/product/add_new_product_screen.dart';
import 'package:mephar_app/screens/product/product/copy_product.dart';
import 'package:mephar_app/screens/product/product/edit_information_product.dart';
import 'package:mephar_app/screens/report/report_customer_screen.dart';
import 'package:mephar_app/screens/report/report_product_screen.dart';
import 'package:mephar_app/screens/report/report_sale_screen.dart';
import 'package:mephar_app/screens/report/report_screen.dart';
import 'package:mephar_app/screens/report/report_staff_screen.dart';
import 'package:mephar_app/screens/report/report_supplier_screen.dart';
import 'package:mephar_app/screens/return_product/filter_return_product_screen.dart';
import 'package:mephar_app/screens/return_product/return_product_detail_screen.dart';
import 'package:mephar_app/screens/return_product/return_product_screen.dart';
import 'package:mephar_app/screens/enter_product/create_receipt_screen.dart';
import 'package:mephar_app/screens/return_product/create_return_product_screen.dart';
import 'package:mephar_app/screens/product/list_of_products_screen.dart';
import 'package:mephar_app/screens/price/price_setting_screen.dart';
import 'package:mephar_app/screens/sell/counter/add_customer_buy_screen.dart';
import 'package:mephar_app/screens/sell/counter/choose_product_screen.dart';
import 'package:mephar_app/screens/sell/counter/create_order_counter_screen.dart';
import 'package:mephar_app/screens/sell/counter/pay_counter_screen.dart';
import 'package:mephar_app/screens/sell/counter/qr_code_pay_counter.dart';
import 'package:mephar_app/screens/sell/delivery/create_order_deliver_screen.dart';
import 'package:mephar_app/screens/supplier/group_supplier/edit_group_supplier.dart';
import 'package:mephar_app/screens/supplier/group_supplier/group_supplier_screen.dart';
import 'package:mephar_app/screens/supplier/group_supplier/add_group_supplier_screen.dart';
import 'package:mephar_app/screens/supplier/single_supplier/add_supplier_screen.dart';
import 'package:mephar_app/screens/supplier/single_supplier/edit_supplier_screen.dart';
import 'package:mephar_app/screens/supplier/single_supplier/list_supplier_screen.dart';
import 'package:mephar_app/screens/supplier/single_supplier/supplier_detail_screen.dart';
import 'package:mephar_app/screens/supplier/supplier_screen.dart';
import 'package:mephar_app/screens/template_medicine/add_sample_medicine.dart';
import 'package:mephar_app/screens/template_medicine/detail_sample_medicine.dart';
import 'package:mephar_app/screens/template_medicine/edit_sample_medicine.dart';
import 'package:mephar_app/screens/transaction/back_bill_customer/back_bill_screen.dart';
import 'package:mephar_app/screens/transaction/bill_customer/customer_pay_screen.dart';
import 'package:mephar_app/screens/transaction/bill_customer/information_customer_pay.dart';
import 'package:mephar_app/screens/transaction/create_transaction_bill.dart';
import 'package:mephar_app/screens/transaction/filter_transaction_screen.dart';
import 'package:mephar_app/screens/transaction/goods_shipped_detail_screen.dart';
import 'package:mephar_app/screens/transaction/goods_shipped_screen.dart';
import 'package:mephar_app/screens/transaction/goods_shipped_to_screen.dart';
import 'package:mephar_app/screens/transaction/oder_customer/information_order_customer.dart';
import 'package:mephar_app/screens/transaction/oder_customer/list_oder_customer_screen.dart';
import 'package:mephar_app/screens/transaction/transaction_bill_detail_screen.dart';
import 'package:mephar_app/screens/transaction/transaction_bill_screen.dart';
import 'package:mephar_app/screens/transaction/transaction_screen.dart';
import 'package:mephar_app/widgets/test.dart';

class AppRoutes {
  //intro
  static const String splashScreen = '/splash-screen';
  static const String onboardingScreen = '/onboarding-screen';

  //login
  static const String loginScreen = '/login-screen';
  static const String registerScreen = '/register-screen';
  static const String registerSecondScreen = '/register-second-screen';

  static const String forgotPasswordScreen = '/forgot-password-screen';
  static const String otpScreen = '/otp-screen';
  static const String resetPasswordScreen = '/reset-password-screen';

  //home
  static const String homeMain = '/home-main';
  static const String homePageScreen = '/home-page';
  static const String addSettingScreen = '/add-setting';
  static const String editProfileScreen = '/edit-profile-screen';

  //sell
  static const String createOrderDeliverScreen = '/create-order-deliver';
  static const String createOrderCounterScreen = '/create-order-counter';
  static const String addCustomerBuyScreen = '/add-customer-buy-screen';
  // static const String payCounterScreen = '/pay-counter-screen';
  static const String qrCodePayCounter = '/qr-code-pay-counter';

  //product
  static const String productScreen = '/product-screen';
  static const String addNewMedicineScreen = '/add-new-medicine-screen';
  static const String addNewProductScreen = '/add-new-product-screen';
  static const String addNewComboProductScreen = '/addNewComboProductScreen';
  static const String listOfProductsScreen = '/list-of-products-screen';
  static const String enterProductScreen = '/enter-product-screen';
  static const String createReceiptScreen = '/create-receipt-screen';
  static const String filterEnterProductScreen = '/filter-enter-product-screen';
  static const String returnProductScreen = '/return-product-screen';
  static const String createReturnProductScreen = '/createReturnProductScreen';
  static const String inventoryControlScreen = '/inventory-control-screen';
  static const String inventoryControlDetailScreen =
      '/inventory-control-detail-screen';
  static const String inventoryControlAddScreen =
      '/inventory-control-add-screen';
  static const String priceSettingScreen = '/price-setting-screen';
  static const String chooseProductScreen = '/choose-product-screen';
  static const String editMedicineScreen = '/editMedicineScreen';
  static const String editProductScreen = '/editProductScreen';
  static const String filterReturnProductScreen = '/filterReturnProductScreen';

  //medicine
  static const String medicineCategoryScreen = '/medicine-category-screen';
  static const String addInformationSampleMedicine =
      '/addInformationSampleMedicine';
  static const String editInformationSampleMedicine =
      '/editInformationSampleMedicine';
  static const String detailInformationSampleMedicine =
      '/detailInformationSampleMedicine';

  //transaction
  static const String transactionScreen = '/transaction-screen';
  static const String transactionBillScreen = '/transaction-bill-screen';
  static const String transactionBillDetailScreen =
      '/transactionBillDetailScreen';
  static const String customerPayScreen = '/customer-pay-screen';
  static const String goodsShippedToScreen = '/goods-shipped-to-screen';
  static const String goodsShippedScreen = '/goods-shipped-screen';
  static const String goodsShippedDetailScreen = '/goods-shipped-detail-screen';
  static const String informationCustomerPayScreen =
      '/informationCustomerPayScreen';

  //customer
  static const String customerScreen = '/customer-screen';
  static const String listCustomerScreen = '/list-customer-screen';
  static const String groupCustomerScreen = '/group-customer-screen';
  static const String addCustomerScreen = '/add-customer-screen';
  static const String customerDetailScreen = '/customer-detail-screen';
  static const String debtsFromCustomer = '/debts-from-customer';

  static const String editInformationCustomer = '/edit-information-customer';
  static const String addGroupCustomerScreen = '/add-group-cusomter-screen';
  static const String editGroupCustomerScreen = '/edit-group-cusomter-screen';

  //supplier
  static const String supplierScreen = '/supplier-screen';
  static const String editSupplier = '/editSupplier';
  static const String listSupplierScreen = '/list-supplier-screen';
  static const String addSupplierScreen = '/add-supplier-screen';
  static const String supplierDetailScreen = '/supplier-detail-screen';
  static const String groupSupplierScreen = '/group-supplier-screen';
  static const String addGroupSupplierScreen = '/add-group-supplier-screen';

  //cash-book
  static const String cashBookScreen = '/cash-book-screen';
  static const String cashBookDetailScreen = '/cash-book-detail-screen';

  //report
  static const String reportScreen = '/report-screen';
  static const String reportCustomerScreen = '/report-customer-screen';
  static const String reportSupplierScreen = '/report-supplier-screen';
  static const String reportStaffScreen = '/report-staff-screen';
  static const String reportSaleScreen = '/report-sale-screen';
  static const String reportProductScreen = '/report-product-screen';

  //configuration
  static const String configurationScreen = '/configuration-screen';
  static const String storeInformationScreen = '/store-information-screen';
  static const String branchManagementScreen = '/branch-management-screen';
  static const String addNewBranchScreen = '/add-new-branch-screen';
  static const String staffManagerScreen = '/staff-manager-screen';
  static const String addNewStaffScreen = '/add-new-staff-screen';
  static const String delegationRoleScreen = '/delegation-role-screen';
  static const String configurationPromotionScreen =
      '/configuration-promotion-screen';
  static const String promotionDetailScreen = '/promotion-detail-screen';
  static const String addNewPromotionScreen = '/add-new-promotion-screen';
  static const String setUpPointScreen = '/set-up-point-screen';
  static const String addNewRoleScreen = '/add-new-role-screen';

  //market
  static const String searchPage = '/searchPage';
  static const String listStorePage = '/listStorePage';
  static const String filterMarketPage = '/filterMarketPage';
  static const String productDetails = '/productDetails';
  static const String storeProfilePage = '/storeProfilePage';
  static const String cartPage = '/cartPage';
  static const String payment = '/payment';
  static const String deliveryAddressPage = '/deliveryAddressPage';
  static const String addAddressPage = '/addAddressPage';
  static const String editAddressPage = '/editAddressPage';
  static const String shippingMethod = '/shippingMethod';
  static const String orderPage = '/orderPage';
  static const String purchasePage = '/purchasePage';
  static const String salesPage = '/salesPage';
  static const String orderDetails = '/orderDetails';
  static const String orderHistory = '/orderHistory';
  static const String productInMarket = '/productInMarket';
  static const String addNewProductMarket = '/addNewProductMarket';
  static const String productDetailsInMarket = '/productDetailsInMarket';
  static const String editProductMarket = '/editProductMarket';

  //oder
  static const String oderBuy = '/oderBuy';
  static const String editGroupSupplier = '/editGroupSupplier';
  static const String backBillScreen = '/backBillScreen';
  static const String oderCustomerScreen = '/oderCustomerScreen';
  static const String oderInformationCustomerScreen =
      '/oderInformationCustomerScreen';
  //doctor
  static const String listDoctorScreen = '/listDoctorScreen';
  static const String addDoctorScreen = '/addDoctorScreen';
  static const String editDoctorScreen = '/editDoctorScreen';
  static const String doctorDetailScreen = '/doctorDetailScreen';
  //
  static const String filterTransactionScreen = '/filterTransactionScreen';
  static const String copyInformationMedicine = '/copyInformationMedicine';
  static const String copyInformationProduct = '/copyInformationProduct';
  static const String createTransactionBillScreen =
      '/createTransactionBillScreen';
  // test
  static const String test = '/test';

  static final routes = <String, WidgetBuilder>{
    loginScreen: (BuildContext context) => const LoginScreen(),
    homeMain: (BuildContext context) => const HomeMain(),
    // homePageScreen: (BuildContext context) =>  HomePageScreen(),
    addSettingScreen: (BuildContext context) => const AddSettingScreen(),
    editProfileScreen: (BuildContext context) => const EditProfileScreen(),
    createOrderDeliverScreen: (BuildContext context) =>
        const CreateOrderDeliverScreen(),
    createOrderCounterScreen: (BuildContext context) =>
        const CreateOrderCounterScreen(),
    transactionScreen: (BuildContext context) => const TransactionScreen(),
    addNewMedicineScreen: (BuildContext context) =>
        const AddNewMedicineScreen(),
    addNewProductScreen: (BuildContext context) => const AddNewProductScreen(),
    listOfProductsScreen: (BuildContext context) => const ListOfProductScreen(),
    enterProductScreen: (BuildContext context) => const EnterProductScreen(),
    createReceiptScreen: (BuildContext context) => const CreateReceiptScreen(),
    customerDetailScreen: (BuildContext context) =>
        const CustomerDetailScreen(),

    returnProductScreen: (BuildContext context) => const ReturnProductScreen(),
    createReturnProductScreen: (BuildContext context) =>
        const CreateReturnProductScreen(),
    medicineCategoryScreen: (BuildContext context) =>
        const MedicineCategoryScreen(),
    customerScreen: (BuildContext context) => const CustomerScreen(),
    supplierScreen: (BuildContext context) => const SupplierScreen(),
    transactionBillScreen: (BuildContext context) =>
        const TransactionBillScreen(),
    transactionBillDetailScreen: (BuildContext context) =>
        const TransactionBillDetailScreen(),
    // customerPayScreen: (BuildContext context) => const CustomerPayScreen(),
    goodsShippedToScreen: (BuildContext context) =>
        const GoodsShippedToScreen(),
    goodsShippedScreen: (BuildContext context) => const GoodsShippedScreen(),
    goodsShippedDetailScreen: (BuildContext context) =>
        const GoodsShippedDetailScreen(),
    listCustomerScreen: (BuildContext context) => const ListCustomerScreen(),
    groupCustomerScreen: (BuildContext context) => const GroupCustomerScreen(),
    addCustomerScreen: (BuildContext context) => const AddCustomerScreen(),
    // customerDetailScreen: (BuildContext context) =>
    //     const CustomerDetailScreen(),
    editSupplier: (BuildContext context) => const EditInformationSupplier(),
    debtsFromCustomer: (BuildContext context) => const DebtsFromCustomer(),
    editInformationCustomer: (BuildContext context) =>
        const EditInformationCustomer(),
    addGroupCustomerScreen: (BuildContext context) =>
        const AddGroupCustomerScreen(),
    listSupplierScreen: (BuildContext context) => const ListSupplierScreen(),
    addSupplierScreen: (BuildContext context) => const AddSupplierScreen(),
    supplierDetailScreen: (BuildContext context) =>
        const SupplierDetailScreen(),
    groupSupplierScreen: (BuildContext context) => const GroupSupplierScreen(),
    addGroupSupplierScreen: (BuildContext context) =>
        const AddGroupSupplierScreen(),
    inventoryControlScreen: (BuildContext context) =>
        const InventoryControlScreen(),
    inventoryControlDetailScreen: (BuildContext context) =>
        const InventoryControlDetailScreen(),
    inventoryControlAddScreen: (BuildContext context) =>
        const InventoryControlAddScreen(),
    priceSettingScreen: (BuildContext context) => const PriceSettingScreen(),
    chooseProductScreen: (BuildContext context) => const ChooseProductScreen(),
    addCustomerBuyScreen: (BuildContext context) =>
        const AddCustomerBuyScreen(),
    // payCounterScreen: (BuildContext context) => const PayCounterScreen(),
    qrCodePayCounter: (BuildContext context) => const QrCodePayCounter(),
    registerScreen: (BuildContext context) => const RegisterScreen(),

    cashBookScreen: (BuildContext context) => const CashBookScreen(),
    cashBookDetailScreen: (BuildContext context) =>
        const CashBookDetailScreen(),
    reportScreen: (BuildContext context) => const ReportScreen(),
    reportCustomerScreen: (BuildContext context) =>
        const ReportCustomerScreen(),
    reportSupplierScreen: (BuildContext context) =>
        const ReportSupplierScreen(),
    reportStaffScreen: (BuildContext context) => const ReportStaffScreen(),
    reportSaleScreen: (BuildContext context) => const ReportSaleScreen(),
    reportProductScreen: (BuildContext context) => const ReportProductScreen(),
    configurationScreen: (BuildContext context) => const ConfigurationScreen(),
    splashScreen: (BuildContext context) => const SplashScreen(),
    onboardingScreen: (BuildContext context) => const OnboardingScreen(),
    forgotPasswordScreen: (BuildContext context) =>
        const ForgotPasswordScreen(),
    otpScreen: (BuildContext context) => const OtpScreen(),
    resetPasswordScreen: (BuildContext context) => const ResetPasswordScreen(),
    storeInformationScreen: (BuildContext context) =>
        const StoreInformationScreen(),
    branchManagementScreen: (BuildContext context) =>
        const BranchManagementScreen(),
    addNewBranchScreen: (BuildContext context) => const AddNewBranchScreen(),
    staffManagerScreen: (BuildContext context) => const StaffManagerScreen(),
    addNewStaffScreen: (BuildContext context) => const AddNewStaffScreen(),
    delegationRoleScreen: (BuildContext context) =>
        const DelegationRoleScreen(),
    configurationPromotionScreen: (BuildContext context) =>
        const ConfigurationPromotionScreen(),
    promotionDetailScreen: (BuildContext context) =>
        const PromotionDetailScreen(),
    addNewPromotionScreen: (BuildContext context) =>
        const AddNewPromotionScreen(),
    setUpPointScreen: (BuildContext context) => const SetUpPointScreen(),
    addNewRoleScreen: (BuildContext context) => const AddNewRoleScreen(),
    editGroupCustomerScreen: (BuildContext context) =>
        const EditGroupCustomerScreen(),

    backBillScreen: (BuildContext context) => const BackbillScreen(),
    //new
    searchPage: (BuildContext context) => const SearchPage(),
    listStorePage: (BuildContext context) => const ListStorePage(),
    filterMarketPage: (BuildContext context) => const FilterMarketPage(),
    productDetails: (BuildContext context) => const ProductDetails(),
    storeProfilePage: (BuildContext context) => const StoreProfilePage(),
    cartPage: (BuildContext context) => const CartPage(),
    payment: (BuildContext context) => const PaymentPage(),
    deliveryAddressPage: (BuildContext context) => const DeliveryAddressPage(),
    addAddressPage: (BuildContext context) => const AddAddressPage(),
    editAddressPage: (BuildContext context) => const EditAddressPage(),
    shippingMethod: (BuildContext context) => const ShippingMethodPage(),
    orderPage: (BuildContext context) => const OrderPage(),
    purchasePage: (BuildContext context) => const PurchaseOrderPage(),
    orderDetails: (BuildContext context) => const OrderDetailsPage(),
    orderHistory: (BuildContext context) => const OrderHistoryPage(),
    salesPage: (BuildContext context) => const SalesOrderPage(),
    productInMarket: (BuildContext context) => const ProductInMarketPage(),
    addNewProductMarket: (BuildContext context) =>
        const AddNewProductMarketPage(),
    productDetailsInMarket: (BuildContext context) =>
        const ProductDetailsInMarket(),
    editProductMarket: (BuildContext context) => const EditProductMarket(),
    oderBuy: (BuildContext context) => const OderBuyScreen(),
    oderCustomerScreen: (BuildContext context) => const OderCustomerScreen(),
    customerPayScreen: (BuildContext context) => const CustomerPayScreen(),
    editGroupSupplier: (BuildContext context) =>
        const EditGroupSupplierScreen(),
    editMedicineScreen: (BuildContext context) => const EditMedicine(),
    editProductScreen: (BuildContext context) => const EditProductScreen(),
    addNewComboProductScreen: (BuildContext context) =>
        const AddNewComBoProductScreen(),
    addInformationSampleMedicine: (BuildContext context) =>
        const AddInformationSampleMedicine(),
    listDoctorScreen: (BuildContext context) => const ListDoctorScreen(),
    addDoctorScreen: (BuildContext context) => const AddDoctorScreen(),
    editDoctorScreen: (BuildContext context) => const EditInformationDoctor(),
    doctorDetailScreen: (BuildContext context) =>
        const InformationDoctorScreen(),
    editInformationSampleMedicine: (BuildContext context) =>
        const EditInformationSampleMedicine(),
    detailInformationSampleMedicine: (BuildContext context) =>
        const SampleMedicineDetailScreen(),
    informationCustomerPayScreen: (BuildContext context) =>
        const InformationCustomerPayScreen(),
    oderInformationCustomerScreen: (BuildContext context) =>
        const InformationCustomerOrderScreen(),
    test: (BuildContext context) => const TestScreen(),
    filterReturnProductScreen: (BuildContext context) =>
        const FilterReturnProductScreen(),
    filterTransactionScreen: (BuildContext context) =>
        const FilterTransactionScreen(),
    copyInformationMedicine: (BuildContext context) =>
        const CopyInformationMedicine(),
    copyInformationProduct: (BuildContext context) => const CopyProductScreen(),
    createTransactionBillScreen: (BuildContext context) =>
        const CreateTransactionBillScreen(),
  };
}
