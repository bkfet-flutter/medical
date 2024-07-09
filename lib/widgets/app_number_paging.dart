import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/utils/extension.dart';

class AppNumberPaging extends StatelessWidget {
  final int currentPage;
  final int totalPage;
  final void Function(int) onTap;

  const AppNumberPaging({
    super.key,
    required this.currentPage,
    required this.totalPage,
    required this.onTap,
  });

  List<Widget> _buildListPage() => [
        for (int i = 1; i <= totalPage; i++)
          ItemPage(
              text: (i).toString(),
              value: currentPage == i,
              onTap: () => onTap(i))
      ];

  Widget space(BuildContext context) =>
      SizedBox(width: MediaQuery.of(context).size.width / 40);

  Widget _baseRow(BuildContext context, List<Widget> numberPages) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ButtonArrow(
                icon: Icons.arrow_back_ios,
                value: currentPage != 1,
                onTap: () => onTap(currentPage - 1)),
            ...numberPages.addBetween(space(context), bound: true),
            ButtonArrow(
                icon: Icons.arrow_forward_ios,
                value: currentPage != totalPage,
                onTap: () => onTap(currentPage + 1))
          ]);

  List<Widget> _morePage(BuildContext context) {
    return [
      ItemPage(text: "1", value: currentPage == 1, onTap: () => onTap(1)),
      currentPage == 1 || currentPage == 2
          ? ItemPage(text: "2", value: currentPage == 2, onTap: () => onTap(2))
          : ItemPage(
              icon: Icon(
              Icons.more_horiz,
              color: const Color(0xff232325),
              size: MediaQuery.of(context).size.width / 27,
            )),
      currentPage == 1 || currentPage == 2
          ? ItemPage(text: '3', onTap: () => onTap(3), value: currentPage == 3)
          : currentPage == totalPage || currentPage == totalPage - 1
              ? ItemPage(
                  text: (totalPage - 2).toString(),
                  value: currentPage == (totalPage - 2),
                  onTap: () => onTap(totalPage - 2),
                )
              : ItemPage(
                  text: currentPage.toString(),
                  value: currentPage == totalPage ? false : true,
                  onTap: () => onTap(currentPage)),
      currentPage == totalPage || currentPage == totalPage - 1
          ? ItemPage(
              text: (totalPage - 1).toString(),
              value: currentPage == totalPage - 1,
              onTap: () => onTap(totalPage - 1),
            )
          : ItemPage(
              icon: Icon(
                Icons.more_horiz,
                color: const Color(0xff232325),
                size: MediaQuery.of(context).size.width / 27,
              ),
            ),
      ItemPage(
          text: totalPage.toString(),
          value: currentPage == totalPage,
          onTap: () => onTap(totalPage)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (totalPage < 2) {
      return ItemPage(
        text: '1',
        value: true,
        onTap: () => onTap,
      );
    }
    if (totalPage <= 5) {
      return _baseRow(context, _buildListPage());
    }
    if (totalPage > 5) {
      return _baseRow(context, _morePage(context));
    } else {
      return const SizedBox.shrink();
    }
  }
}

class ItemPage extends StatelessWidget {
  final String? text;
  final bool? value;
  final Widget? icon;
  final void Function()? onTap;
  final ConfigBoxNumber? configBoxNumber;

  const ItemPage(
      {super.key,
      this.text,
      this.value,
      this.onTap,
      this.icon,
      this.configBoxNumber});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width / 12,
        height: MediaQuery.of(context).size.width / 12,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: configBoxNumber?.activeBox ?? Colors.transparent,
          border: Border.all(color: const Color(0xffE0E2E7)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: icon ??
            Text(
              text ?? "",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 27,
                  color:
                      value == true ? AppThemes.red0 : const Color(0xff232325)),
            ),
      ),
    );
  }
}

class ButtonArrow extends StatelessWidget {
  final IconData icon;
  final bool value;
  final void Function() onTap;

  const ButtonArrow(
      {super.key,
      required this.icon,
      required this.value,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    if (value == true) {
      return InkWell(
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width / 12,
          height: MediaQuery.of(context).size.width / 12,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppThemes.transparent,
            border: Border.all(color: const Color(0xffE0E2E7)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon,
              color: const Color(0xff6F727A),
              size: MediaQuery.of(context).size.width / 27),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

class ConfigBoxNumber {
  Color? activeBox;
  Color? activeText;

  ConfigBoxNumber({this.activeBox, this.activeText});
}
