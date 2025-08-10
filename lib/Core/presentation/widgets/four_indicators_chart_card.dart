import 'package:dmms/Core/extensions/context_extenstions.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class FourIndicatorsChartCard extends StatelessWidget {
  final int total;
  final int active;
  final int pending;
  final int completed;
  final int canceled;
  final String title;
  final IconData icon;
  const FourIndicatorsChartCard(
      {required this.total,
      required this.active,
      required this.pending,
      required this.completed,
      required this.canceled,
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
                    '${AppStrings.total.tr()}: $total',
                  ),
                  SizedBox(height: AppSize.s8),
                  Column(
                    children: [
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
                              label: AppStrings.pending.tr(),
                              count: pending),
                          SizedBox(width: AppSize.s16),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _legendItem(
                              color: context.completedColor,
                              label: AppStrings.completed.tr(),
                              count: completed),
                          SizedBox(width: AppSize.s16),
                          _legendItem(
                              color: context.appColors.primary,
                              label: AppStrings.canceled.tr(),
                              count: canceled),
                        ],
                      ),
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
                      _barGroup(1, pending.toDouble(), context.pendingColor),
                      _barGroup(
                          2, completed.toDouble(), context.completedColor),
                      _barGroup(
                          3, canceled.toDouble(), context.appColors.primary),
                    ],
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            switch (value.toInt()) {
                              case 0:
                                return Text(
                                  AppStrings.active.tr(),
                                  style: context.textTheme.labelSmall,
                                );
                              case 1:
                                return Text(
                                  AppStrings.pending.tr(),
                                  style: context.textTheme.labelSmall,
                                );
                              case 2:
                                return Text(
                                  AppStrings.completed.tr(),
                                  style: context.textTheme.labelSmall,
                                );
                              case 3:
                                return Text(
                                  AppStrings.canceled.tr(),
                                  style: context.textTheme.labelSmall,
                                );
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
        SizedBox(width: AppSize.s4),
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
        width: AppSize.s50,
        color: color.withAlpha(100),
        borderRadius: BorderRadius.circular(AppSize.s4),
        borderSide: BorderSide(color: color),
      ),
    ]);
  }
}
