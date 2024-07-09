import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/model/product_report_revenue_model.dart';
import 'indicator.dart';

class PieChartSample2 extends StatefulWidget {
  final List<ProductReportRevenueModel> listDataReport;

  const PieChartSample2({super.key, required this.listDataReport});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  final List<Color> _colors = [
    AppThemes.blueNeon,
    AppThemes.blueSky,
    AppThemes.blueOcean,
    AppThemes.bluePurple,
    AppThemes.blueWhite
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: AspectRatio(
            aspectRatio: 1,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    // setState(() {
                    //   if (!event.isInterestedForInteractions ||
                    //       pieTouchResponse == null ||
                    //       pieTouchResponse.touchedSection == null) {
                    //     touchedIndex = -1;
                    //     return;
                    //   }
                    //   touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                    // });
                  },
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                sections: showingSections(),
              ),
              swapAnimationDuration: const Duration(milliseconds: 500),
            ),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          flex: 1,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                widget.listDataReport.length,
                (index) => Indicator(
                  text: widget.listDataReport[index].name ?? "",
                  isSquare: true,
                  color: _colors[index],
                ),
              )),
        )
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

    int total = widget.listDataReport.fold(0, (previousValue, element) => previousValue + (element.revenue ?? 0));

    return List.generate(
        widget.listDataReport.length,
        (index) => PieChartSectionData(
              color: _colors[index],
              value: (widget.listDataReport[index].revenue ?? 0) / total * 100,
              title: "${((widget.listDataReport[index].revenue ?? 0) / total * 100).toStringAsFixed(2)}%",
              radius: 50,
              titleStyle: const TextStyle(
                fontSize: AppDimens.textSizeSmall,
                fontWeight: FontWeight.normal,
                color: AppThemes.black,
                shadows: shadows,
              ),
            ));
  }
}
