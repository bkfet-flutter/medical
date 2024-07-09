import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';

class ItemProduct extends StatelessWidget {
  const ItemProduct({
    super.key,
    this.image,
    this.name,
    this.code,
    this.price,
    this.inventory,
    this.isSelected = false,
    this.onTap,
    this.unitName,
  });

  final String? image;
  final String? unitName;
  final String? name;
  final String? code;
  final int? price;
  final int? inventory;
  final Function()? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: const Color.fromRGBO(204, 223, 242, 0.2),
      splashColor: const Color.fromRGBO(204, 223, 242, 0.4),
      onTap: onTap,
      child: Container(
        color: isSelected ? AppThemes.blue4 : Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20, top: 16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: image != null && image != ""
                          ? Image.network(
                              "${ApiRequest.domain}$image",
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              AppImages.avatarFakeProduct,
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: RichText(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: name ?? '',
                                        style: AppFonts.normalBold(
                                          16,
                                          AppThemes.dark0,
                                        )),
                                    TextSpan(
                                        text: unitName == null ? "" : " [$unitName] ",
                                        style: AppFonts.normalBold(
                                          14,
                                          AppThemes.red0,
                                        ))
                                  ]),
                                )),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    (price ?? "---").toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: AppFonts.regular(16, AppThemes.dark2).copyWith(height: 20 / 16),
                                  ),
                                  Text(
                                    (inventory ?? "---").toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: AppFonts.regular(16, AppThemes.dark3).copyWith(height: 20 / 16),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Text(
                          "SKU: $code",
                          style: AppFonts.regular(16, AppThemes.dark3).copyWith(height: 20 / 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                height: 1,
                color: AppThemes.light1,
                width: MediaQuery.of(context).size.width,
              )
            ],
          ),
        ),
      ),
    );
  }
}
