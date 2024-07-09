// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class BatchWidget extends StatelessWidget {
//   const BatchWidget({Key? key, required this.list, required this.passedIndex}) : super(key: key);
//   // final Set<BatchProductModel> list;
//   final int passedIndex;
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ProductProvider>(builder: (context, search, child) {
//       return Wrap(
//         spacing: 10,
//         runSpacing: 5,
//         children: List.generate(list.length, (index) {
//           return Container(
//             padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//             decoration: BoxDecoration(
//               color: Colors.blue,
//               border: Border.all(color: Colors.grey, width: 1),
//             ),
//             child: Row(
//               children: [
//                 Text(
//                   '${list.toList()[passedIndex].name ?? '-'}-${list.toList()[passedIndex].expirationDate?.substring(0, 10) ?? '-'}-${list.toList()[index].cList.text}',
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 IconButton(
//                   onPressed: () {},
//                   icon: const Icon(
//                     Icons.close,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }),
//       );
//     });
//   }
// }
