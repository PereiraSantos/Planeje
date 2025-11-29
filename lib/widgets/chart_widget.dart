import 'package:flutter/material.dart';
import 'package:planeje/dashboard/entities/revision_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({super.key, required this.data, required this.title, this.otherData});

  final List<GraphicData> data;
  final List<GraphicData>? otherData;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      margin: const EdgeInsets.all(8),
      child: Center(
        child: SfCartesianChart(
          title: ChartTitle(text: title, textStyle: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w700, fontSize: 13)),
          margin: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
          primaryXAxis: const CategoryAxis(),
          series: <CartesianSeries>[
            LineSeries<GraphicData, String>(
              dataSource: otherData ?? [],
              xValueMapper: (GraphicData otherData, _) => otherData.revision,
              yValueMapper: (GraphicData otherData, _) => otherData.quantiy,
              markerSettings: const MarkerSettings(isVisible: false),
              color: Colors.red,
            ),
            LineSeries<GraphicData, String>(
              dataSource: data,
              xValueMapper: (GraphicData data, _) => data.revision,
              yValueMapper: (GraphicData data, _) => data.quantiy,
              markerSettings: const MarkerSettings(isVisible: false),
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
