// import 'package:flutter/material.dart';
// import 'package:mephar_app/widgets/card_product_check_2.dart';
//
// class TestScreen extends StatefulWidget {
//   const TestScreen({super.key});
//
//   @override
//   State<TestScreen> createState() => _TestScreenState();
// }
//
// class _TestScreenState extends State<TestScreen> {
//   TextEditingController controller = TextEditingController();
//   TextEditingController priceController = TextEditingController();
//   TextEditingController disCount = TextEditingController();
//   int totalAmount = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Center(
//       child: Column(
//         children: [
//           InkWell(
//             onTap: () {
//               print(priceController.text);
//               print(disCount.text);
//               print(controller.text);
//               print(totalAmount);
//             },
//             child: Container(
//               width: 50,
//               height: 50,
//               color: Colors.red,
//             ),
//           ),
//           CardProductCheck2(
//             noClose: false,
//             listData: [],
//             onPressed: () {},
//             productId: '',
//             productName: '',
//             quantityController: controller,
//             priceController: priceController,
//             disCountController: disCount,
//             onTotalAmountChanged: (value) {
//               setState(() {
//                 totalAmount = value;
//               });
//             },
//           ),
//         ],
//       ),
//     ));
//   }
// }
