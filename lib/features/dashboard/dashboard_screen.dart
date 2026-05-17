import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/theme.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Reception Dashboard', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 32),
          Row(
            children: [
              _metricCard('Today\'s Visits', '12', Icons.people, Colors.blue),
              _metricCard('Active Now', '3', Icons.timer, Colors.green),
              _metricCard('Upcoming', '5', Icons.event, Colors.orange),
              _metricCard('Avg Duration', '45m', Icons.schedule, Colors.purple),
            ],
          ),
          const SizedBox(height: 48),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _chartContainer('Visits per Day', const VisitsBarChart()),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: _chartContainer('Purpose Breakdown', const PurposeDonutChart()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _metricCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        margin: const EdgeInsets.only(right: 16),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(height: 16),
              Text(value, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              Text(title, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chartContainer(String title, Widget chart) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          Expanded(child: chart),
        ],
      ),
    );
  }
}

class VisitsBarChart extends StatelessWidget {
  const VisitsBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 20,
        barGroups: [
          BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 8, color: AppColors.primary)]),
          BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 12, color: AppColors.primary)]),
          BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 15, color: AppColors.primary)]),
          BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 10, color: AppColors.primary)]),
          BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 18, color: AppColors.primary)]),
        ],
      ),
    );
  }
}

class PurposeDonutChart extends StatelessWidget {
  const PurposeDonutChart({super.key});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(value: 40, title: 'Meeting', color: AppColors.primary, radius: 50),
          PieChartSectionData(value: 30, title: 'Delivery', color: AppColors.tertiary, radius: 50),
          PieChartSectionData(value: 20, title: 'Interview', color: Colors.blue, radius: 50),
          PieChartSectionData(value: 10, title: 'Other', color: Colors.grey, radius: 50),
        ],
      ),
    );
  }
}
