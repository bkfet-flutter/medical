import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/provider/address_provider.dart';
import 'package:mephar_app/provider/batch_product_provider.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:mephar_app/provider/country_produce_provider.dart';
import 'package:mephar_app/provider/customer_provider.dart';
import 'package:mephar_app/provider/data_unit_provider.dart';
import 'package:mephar_app/provider/debt_customer_provider.dart';
import 'package:mephar_app/provider/doctor_provider.dart';
import 'package:mephar_app/provider/dosage_provider.dart';
import 'package:mephar_app/provider/group_customer_provider.dart';
import 'package:mephar_app/provider/group_product_provider.dart';
import 'package:mephar_app/provider/home_provider.dart';
import 'package:mephar_app/provider/inventory_provider.dart';
import 'package:mephar_app/provider/level_provider.dart';
import 'package:mephar_app/provider/loading_provider.dart';
import 'package:mephar_app/provider/manufacture_provider.dart';
import 'package:mephar_app/provider/medicine_provider.dart';
import 'package:mephar_app/provider/order_page_provider.dart';
import 'package:mephar_app/provider/payment_history_provider.dart';
import 'package:mephar_app/provider/position_provider.dart';
import 'package:mephar_app/provider/product/price_setting_provider.dart';
import 'package:mephar_app/provider/product/import_product_provider.dart';
import 'package:mephar_app/provider/product/product_provider.dart';
import 'package:mephar_app/provider/oder_provider.dart';
import 'package:mephar_app/provider/pay_customer_provider.dart';
import 'package:mephar_app/provider/product/product_return_provider.dart';
import 'package:mephar_app/provider/promotion_provider.dart';
import 'package:mephar_app/provider/purchase_history_provider.dart';
import 'package:mephar_app/provider/role_provider.dart';
import 'package:mephar_app/provider/root_provider.dart';
import 'package:mephar_app/provider/sample_prescription_provider.dart';
import 'package:mephar_app/provider/sell_provider.dart';
import 'package:mephar_app/provider/setting_provider.dart';
import 'package:mephar_app/provider/shipping_provider.dart';
import 'package:mephar_app/provider/specialist_provider.dart';
import 'package:mephar_app/provider/store_provider.dart';
import 'package:mephar_app/provider/supplier_provider.dart';
import 'package:mephar_app/provider/user_provider.dart';
import 'package:mephar_app/provider/warehouse_card_provider.dart';
import 'package:mephar_app/provider/work_place_provider.dart';
import 'package:mephar_app/widgets/key_board_dismiss.dart';
import 'package:mephar_app/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ImportProductProvider()),
        ChangeNotifierProvider(create: (_) => CustomerProvider()),
        ChangeNotifierProvider(create: (_) => MedicineProvider()),
        ChangeNotifierProvider(create: (_) => SupplierProvider()),
        ChangeNotifierProvider(create: (_) => LoadingProvider()),
        ChangeNotifierProvider(create: (_) => GroupCustomerProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => BranchProvider()),
        ChangeNotifierProvider(create: (_) => AddressProvider()),
        ChangeNotifierProvider(create: (_) => StoreProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => RoleProvider()),
        ChangeNotifierProvider(create: (_) => PromotionProvider()),
        ChangeNotifierProvider(create: (_) => PriceSettingProvider()),
        ChangeNotifierProvider(create: (_) => PayCustomerProvider()),
        ChangeNotifierProvider(create: (_) => SettingProvider()),
        ChangeNotifierProvider(create: (_) => OderCustomerProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => ProductReturnProvider()),
        ChangeNotifierProvider(create: (_) => DosageProvider()),
        ChangeNotifierProvider(create: (_) => PositionProvider()),
        ChangeNotifierProvider(create: (_) => CountryProduceProvider()),
        ChangeNotifierProvider(create: (_) => ManufactureProvider()),
        ChangeNotifierProvider(create: (_) => GroupProductProvider()),
        ChangeNotifierProvider(create: (_) => SellProvider()),
        ChangeNotifierProvider(create: (_) => DataUnitProvider()),
        ChangeNotifierProvider(create: (_) => SampleProvider()),
        ChangeNotifierProvider(create: (_) => DoctorProvider()),
        ChangeNotifierProvider(create: (_) => SpecialistProvider()),
        ChangeNotifierProvider(create: (_) => LevelDoctorProvider()),
        ChangeNotifierProvider(create: (_) => WorkPlaceDoctorProvider()),
        ChangeNotifierProvider(create: (_) => PurchaseHistoryProvider()),
        ChangeNotifierProvider(create: (_) => ShippingProvider()),
        ChangeNotifierProvider(create: (_) => PaymentHistoryProvider()),
        ChangeNotifierProvider(create: (_) => DebtCustomerProvider()),
        ChangeNotifierProvider(create: (_) => WareHouseCradProvider()),
        ChangeNotifierProvider(create: (_) => InventoryProvider()),
        ChangeNotifierProvider(create: (_) => BatchProductProvider()),
        ChangeNotifierProvider(create: (_) => RootProvider()),
        ChangeNotifierProvider(create: (_) => OrderPageProvider()),
      ],
      builder: (context, _) {
        return Consumer<LoadingProvider>(
          builder: (context, loading, child) {
            return KeyboardDismiss(
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  useMaterial3: false,
                  primarySwatch: Colors.red,
                ),
                home: Stack(
                  children: [
                    MaterialApp(
                      title: 'Flutter Demo',
                      theme: ThemeData(
                        useMaterial3: false,
                        primarySwatch: Colors.red,
                      ),
                      debugShowCheckedModeBanner: false,
                      initialRoute: AppRoutes.splashScreen,
                      routes: AppRoutes.routes,
                    ),
                    loading.isLoading
                        ? const LoadingWidget()
                        : const SizedBox.shrink()
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
