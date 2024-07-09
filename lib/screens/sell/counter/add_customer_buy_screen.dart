import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/provider/customer_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/widgets/item_customer.dart';
import 'package:mephar_app/widgets/mephar_big_appbar.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/mephar_floating_action_button.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class AddCustomerBuyScreen extends StatefulWidget {
  const AddCustomerBuyScreen({super.key});

  @override
  State<AddCustomerBuyScreen> createState() => _AddCustomerBuyScreenState();
}

class _AddCustomerBuyScreenState extends State<AddCustomerBuyScreen> {
  TextEditingController keywordController = TextEditingController();

  String get keyword => keywordController.text;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => context.read<CustomerProvider>().getDataCustomer(keyword, 10, 1));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerProvider>(
      builder: (context, customer, child) {
        return MepharBigAppbar(
          title: "Khách hàng",
          hintSearch: "Tìm tên, số điện thoại, mã...",
          haveOneIcon: true,
          haveIconNearSearch: true,
          haveSuffixSearch: false,
          controllerSearch: keywordController,
          backgroundColor: AppThemes.white,
          onFieldSubmitted: (value) => context.read<CustomerProvider>().getDataCustomer(keyword, 10, 1),
          onChanged: (value) => context.read<CustomerProvider>().getDataCustomer(keyword, 10, 1),
          floatingActionButton: customer.listAllCustomer.isNotEmpty
              ? MepharFloatingActionButton(onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.addCustomerScreen,
                  );
                }, heroTag: 'add customer',)
              : const SizedBox.shrink(),
          icon: AppImages.iconMoreVertical,
          body: customer.loading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppThemes.kPrimary,
                  ),
                )
              : customer.listAllCustomer.isEmpty
                  ? SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 60),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 90,
                            ),
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Image.asset(
                                  AppImages.avatarBoy,
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.fill,
                                ),
                                Positioned(right: -10, bottom: -10, child: MepharFloatingActionButton(onPressed: () {}, heroTag: '',))
                              ],
                            ),
                            const SizedBox(
                              height: 43,
                            ),
                            Text(
                              "Chưa có khách hàng nào!",
                              textAlign: TextAlign.center,
                              style: AppFonts.bold(
                                16,
                                AppThemes.dark0,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              "Thêm khách hàng đầu tiên vào danh sách khách hàng ngay nào",
                              textAlign: TextAlign.center,
                              style: AppFonts.bold(
                                16,
                                AppThemes.dark3,
                              ),
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            MepharButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.addCustomerScreen,
                                );
                              },
                              titleButton: "Tạo khách hàng",
                            )
                          ],
                        ),
                      ),
                    )
                  : MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView(
                        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                        shrinkWrap: true,
                        children: customer.listAllCustomer
                            .map((e) => ItemCustomer(
                                  name: e.fullName,
                                  phone: e.phone,
                                  onTap: () => Navigator.pop(context, e),
                                ))
                            .toList(),
                      ),
                    ),
        );
      },
    );
  }

  @override
  void dispose() {
    keywordController.dispose();
    super.dispose();
  }
}
