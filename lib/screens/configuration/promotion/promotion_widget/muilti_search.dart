import 'package:flutter/material.dart';
import 'package:mephar_app/model/search_customer_model.dart';
import 'package:mephar_app/model/search_supplier_model.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/screens/configuration/promotion/search_api_product.dart';
import 'package:provider/provider.dart';

class MultiSearch extends StatefulWidget {
  final List<SearchCustomerModel> listSelected;
  final Function() getID;

  const MultiSearch({super.key, required this.listSelected, required this.getID});

  @override
  State<MultiSearch> createState() => _MultiSearchState();
}

class _MultiSearchState extends State<MultiSearch> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 4,
          children: List.generate(
              widget.listSelected.length,
              (index) => widget.listSelected.isNotEmpty
                  ? Chip(
                      label: Text(
                        widget.listSelected[index].name ?? "",
                        style: AppFonts.regular(),
                      ),
                      onDeleted: () {
                        widget.listSelected.removeAt(index);
                        setState(() {});
                      },
                    )
                  : const SizedBox.shrink()),
        ),
        SearchCustomer(
          onSelected: (value) {
            if (widget.listSelected.contains(value)) {
            } else {
              widget.listSelected.add(value);
              setState(() {});
              widget.getID.call();
            }
          },
        )
      ],
    );
  }
}

class SearchSupplierMulti extends StatefulWidget {
  final List<SearchSupplierModel> listSelectedSupplier;
  final Function() getID;

  const SearchSupplierMulti({super.key, required this.listSelectedSupplier, required this.getID});

  @override
  State<SearchSupplierMulti> createState() => _SearchSupplierMultiState();
}

class _SearchSupplierMultiState extends State<SearchSupplierMulti> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 4,
          children: List.generate(
              widget.listSelectedSupplier.length,
              (index) => widget.listSelectedSupplier.isNotEmpty
                  ? Chip(
                      label: Text(
                        widget.listSelectedSupplier[index].name ?? "",
                        style: AppFonts.regular(),
                      ),
                      onDeleted: () {
                        widget.listSelectedSupplier.removeAt(index);
                        setState(() {});
                      },
                    )
                  : const SizedBox.shrink()),
        ),
        SearchSupplier(
          branchID: context.watch<BranchProvider>().branchModel.id.toString(),
          onSelected: (value) {
            if (widget.listSelectedSupplier.contains(value)) {
            } else {
              widget.listSelectedSupplier.add(value);
              setState(() {});
              widget.getID.call();
            }
          },
        )
      ],
    );
  }
}
