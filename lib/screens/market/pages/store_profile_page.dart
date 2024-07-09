import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/market/base/box_product.dart';
import 'package:mephar_app/screens/market/base/box_selling_products.dart';
import 'package:mephar_app/widgets/custom_tab_indicator.dart';
import 'package:mephar_app/widgets/header_button.dart';

class StoreProfilePage extends StatefulWidget {
  const StoreProfilePage({super.key});

  @override
  State<StoreProfilePage> createState() => _StoreProfilePageState();
}

class _StoreProfilePageState extends State<StoreProfilePage> with TickerProviderStateMixin {
  late TabController tabController;
  late ScrollController _scrollController;
  Color _textColor = const Color(0xffEE0033);
  static const kExpandedHeight = 200.0;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 4, vsync: this);

    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _textColor = _isSliverAppBarExpanded ? const Color(0xff333333) : const Color(0xffEE0033);
        });
      });
  }

  bool get _isSliverAppBarExpanded {
    return _scrollController.hasClients && _scrollController.offset > kExpandedHeight - kToolbarHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemes.white,
      body: NestedScrollView(
          controller: _scrollController,
          body: _buildTabView(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Colors.white,
                leading: Padding(
                  padding: const EdgeInsets.all(8),
                  child: HeaderButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    mini: true,
                    backgroundColor: Colors.white,
                    iconHeight: 24,
                    iconWidth: 24,
                    icon: AppImages.iconArrowBack,
                    iconColor: _textColor,
                  ),
                ),
                title: _isSliverAppBarExpanded
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "TIM Care Diamond",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: _textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily: AppFonts.laTo),
                          ),
                          const Text(
                            "Hanoi",
                            style: TextStyle(
                                color: Color(0xff9F9F9F),
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                fontFamily: AppFonts.laTo),
                          ),
                        ],
                      )
                    : null,
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: _isSliverAppBarExpanded ? 0 : 16),
                    child: HeaderButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      mini: true,
                      backgroundColor: Colors.white,
                      iconHeight: 24,
                      iconWidth: 24,
                      icon: AppImages.iconSearch,
                      iconColor: _textColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: HeaderButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      mini: true,
                      backgroundColor: Colors.white,
                      iconHeight: 24,
                      iconWidth: 24,
                      icon: AppImages.iconCart,
                      iconColor: _textColor,
                    ),
                  ),
                ],
                floating: false,
                pinned: true,
                expandedHeight: kExpandedHeight,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color: const Color(0xffABABAB),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "TIM Care Diamond",
                        style: TextStyle(
                            fontFamily: AppFonts.laTo,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff333333)),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Thuốc tốt - Giá tốt",
                        style: TextStyle(
                            fontFamily: AppFonts.laTo,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff9F9F9F)),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "50 Mễ Trì Thượng, Nam Từ Liêm,...",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontFamily: AppFonts.laTo,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff757575)),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Xem trên bản đồ",
                            style: TextStyle(
                                fontFamily: AppFonts.laTo,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffEE0033)),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "4.8",
                                      style: TextStyle(
                                          fontFamily: AppFonts.laTo,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff333333)),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "99+ Đánh giá",
                                      style: TextStyle(
                                          fontFamily: AppFonts.laTo,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff333333)),
                                    ),
                                  ],
                                ),
                              ),
                              VerticalDivider(
                                color: Color(0xffEDEDED),
                                thickness: 1,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "100",
                                      style: TextStyle(
                                          fontFamily: AppFonts.laTo,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff333333)),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "Sản phẩm",
                                      style: TextStyle(
                                          fontFamily: AppFonts.laTo,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff333333)),
                                    ),
                                  ],
                                ),
                              ),
                              VerticalDivider(
                                color: Color(0xffEDEDED),
                                thickness: 1,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "\$\$\$",
                                      style: TextStyle(
                                          fontFamily: AppFonts.laTo,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff333333)),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "Mức giá",
                                      style: TextStyle(
                                          fontFamily: AppFonts.laTo,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff333333)),
                                    ),
                                  ],
                                ),
                              ),
                              VerticalDivider(
                                color: Color(0xffEDEDED),
                                thickness: 1,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "8AM-8PM",
                                      style: TextStyle(
                                          fontFamily: AppFonts.laTo,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff333333)),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "Giờ mở cửa",
                                      style: TextStyle(
                                          fontFamily: AppFonts.laTo,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff333333)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  margin: const EdgeInsets.only(bottom: 28),
                  decoration:
                      BoxDecoration(color: const Color(0xffFAFAFA), border: Border.all(color: const Color(0xffE9E9E9))),
                  child: const Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '4.6Km khoảng cách',
                              style: TextStyle(
                                  fontFamily: AppFonts.laTo,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff333333)),
                            ),
                          ),
                          Text(
                            'Thay đổi vị trí',
                            style: TextStyle(
                                fontFamily: AppFonts.laTo,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffEE0033)),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            'Phí giao hàng dự kiến: 15.000đ',
                            style: TextStyle(
                                fontFamily: AppFonts.laTo,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff757575)),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: CircleAvatar(
                              radius: 2,
                              backgroundColor: Color(0xffC4C4C4),
                            ),
                          ),
                          Text(
                            'Giao hàng trong 15 phút',
                            style: TextStyle(
                                fontFamily: AppFonts.laTo,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff757575)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    TabBar(
                        controller: tabController,
                        isScrollable: true,
                        indicatorColor: const Color(0xffEE0033),
                        labelColor: const Color(0xffEE0033),
                        unselectedLabelColor: AppThemes.dark1,
                        labelStyle: const TextStyle(
                            fontFamily: AppFonts.laTo,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xffEE0033)),
                        unselectedLabelStyle: const TextStyle(
                            fontFamily: AppFonts.laTo,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppThemes.dark1),
                        indicator: const CustomTabIndicator(color: Color(0xffEE0033)),
                        tabs: const [
                          Tab(
                            text: 'Sản phẩm mới',
                          ),
                          Tab(
                            text: 'Bán chạy',
                          ),
                          Tab(
                            text: 'Thuốc',
                          ),
                          Tab(
                            text: 'Thực phẩm',
                          ),
                        ]),
                    Container(
                      height: 0.5,
                      color: const Color(0xff333333),
                    ),
                  ],
                ),
              )
            ];
          }),
    );
  }

  Widget _buildTabView() {
    return TabBarView(controller: tabController, children: [
      SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 16),
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Sản phẩm mới',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xff333333)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Wrap(
                runSpacing: 16,
                children: List.generate(5, (index) => const BoxProduct()),
              ),
            )
          ],
        ),
      ),
      SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Bán chạy',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xff333333)),
                ),
              ),
              ...List.generate(
                5,
                (index) => const BoxSellingProducts(),
              )
            ],
          )),
      SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Bán chạy',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xff333333)),
                ),
              ),
              ...List.generate(
                5,
                (index) => const BoxSellingProducts(),
              )
            ],
          )),
      SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Bán chạy',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xff333333)),
                ),
              ),
              ...List.generate(
                5,
                (index) => const BoxSellingProducts(),
              )
            ],
          )),
    ]);
  }
}
