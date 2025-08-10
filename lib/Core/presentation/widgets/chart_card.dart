import 'package:dmms/Core/extensions/context_extenstions.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ChartCard extends StatelessWidget {
  final int total;
  final int active;
  final int inactive;
  final String title;
  final IconData icon;
  const ChartCard(
      {required this.total,
      required this.active,
      required this.inactive,
      required this.title,
      required this.icon,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: context.appColors.surface,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.r16)),
        elevation: AppSize.s0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(AppSize.s12),
              decoration: BoxDecoration(
                color: context.appColors.primary,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(AppRadius.r16)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: Colors.white, size: AppSize.s18),
                  SizedBox(width: AppSize.s8),
                  Text(title,
                      style: TextStyle(
                          color: Colors.white, fontSize: AppSize.s18)),
                ],
              ),
            ),

            // Total + Legends
            Padding(
              padding: const EdgeInsets.all(AppSize.s12),
              child: Column(
                children: [
                  Text(
                    ' ${AppStrings.total.tr()}: $total',
                  ),
                  SizedBox(height: AppSize.s8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _legendItem(
                          color: context.activeColor,
                          label: AppStrings.active.tr(),
                          count: active),
                      SizedBox(width: AppSize.s16),
                      _legendItem(
                          color: context.pendingColor,
                          label: AppStrings.inactive.tr(),
                          count: inactive),
                    ],
                  ),
                ],
              ),
            ),

            Divider(),

            // Chart
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p12, vertical: AppPadding.p8),
              child: AspectRatio(
                aspectRatio: 1.5,
                child: BarChart(
                  BarChartData(
                    maxY: total.toDouble(),
                    barGroups: [
                      _barGroup(0, active.toDouble(), context.activeColor),
                      _barGroup(1, inactive.toDouble(), context.pendingColor),
                    ],
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            switch (value.toInt()) {
                              case 0:
                                return Text(AppStrings.active.tr());
                              case 1:
                                return Text(AppStrings.inactive.tr());
                              default:
                                return Text('');
                            }
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                        showTitles: true,
                        interval: 10,
                        reservedSize: AppSize.s35,
                      )),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: 5,
                    ),
                    borderData: FlBorderData(show: false),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _legendItem(
      {required Color color, required String label, required int count}) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: color.withAlpha(100),
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(AppRadius.r2),
          ),
          width: AppSize.s12,
          height: AppSize.s12,
        ),
        SizedBox(width: 4),
        Text(
          '$label: $count',
          style: TextStyle(color: Colors.black),
        ),
      ],
    );
  }

  BarChartGroupData _barGroup(int x, double value, Color color) {
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(
        toY: value,
        width: AppSize.s100,
        color: color.withAlpha(100),
        borderRadius: BorderRadius.circular(AppSize.s4),
        borderSide: BorderSide(color: color),
      ),
    ]);
  }
}
