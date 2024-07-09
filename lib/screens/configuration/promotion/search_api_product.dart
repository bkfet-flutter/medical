import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/model/search_customer_model.dart';
import 'package:mephar_app/model/search_product_model.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mephar_app/model/search_supplier_model.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';

class SearchProduct extends StatelessWidget {
  final void Function(SearchProductModel? suggest) select;

  const SearchProduct({super.key, required this.select});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TypeAheadFormField(
        textFieldConfiguration: TextFieldConfiguration(
          autofocus: false,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                width: 1,
                color: AppThemes.red0,
                style: BorderStyle.solid,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                width: 1,
                color: Color(0xffC7C9D9),
                style: BorderStyle.solid,
              ),
            ),
            fillColor: Colors.white,
            filled: true,
            hintText: 'Tìm kiếm hàng hóa',
            hintStyle: AppFonts.normalBold(12, AppThemes.dark3),
          ),
        ),
        itemBuilder: (BuildContext context, SearchProductModel? suggest) {
          return ListTile(
            title: Text(suggest?.name ?? ""),
          );
        },
        onSuggestionSelected: select,
        suggestionsCallback: (String keyword) async {
          List<SearchProductModel?> products = await ApiRequest.searchProductByKeyword(keyword);
          return products;
        },
      ),
    );
  }
}

class SearchCustomer extends StatelessWidget {
  final void Function(SearchCustomerModel) onSelected;

  const SearchCustomer({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
        autofocus: false,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              width: 1,
              color: AppThemes.red0,
              style: BorderStyle.solid,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              width: 1,
              color: Color(0xffC7C9D9),
              style: BorderStyle.solid,
            ),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: 'Chọn nhóm khách hàng',
          hintStyle: AppFonts.regular(14, const Color(0xffC7C9D9)),
        ),
      ),
      itemBuilder: (BuildContext context, SearchCustomerModel suggest) {
        return ListTile(
          title: Text(suggest.name ?? ""),
        );
      },
      onSuggestionSelected: onSelected,
      suggestionsCallback: (String keyword) async {
        List<SearchCustomerModel> products = await ApiRequest.searchCustomerPromotion(keyword);
        return products;
      },
    );
  }
}

class SearchSupplier extends StatelessWidget {
  final void Function(SearchSupplierModel) onSelected;
  final String? branchID;

  const SearchSupplier({super.key, required this.onSelected, this.branchID});

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
        autofocus: false,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              width: 1,
              color: AppThemes.red0,
              style: BorderStyle.solid,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              width: 1,
              color: Color(0xffC7C9D9),
              style: BorderStyle.solid,
            ),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: 'Chọn người bán áp dụng',
          hintStyle: AppFonts.regular(14, const Color(0xffC7C9D9)),
        ),
      ),
      itemBuilder: (BuildContext context, SearchSupplierModel suggest) {
        return ListTile(
          title: Text(suggest.name ?? ""),
        );
      },
      onSuggestionSelected: onSelected,
      suggestionsCallback: (String keyword) async {
        List<SearchSupplierModel> products = await ApiRequest.searchSupplierPromotion(keyword, branchID);
        return products;
      },
    );
  }
}
