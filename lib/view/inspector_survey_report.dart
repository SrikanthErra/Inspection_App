import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:inspection_app_flutter/res/components/base_scaffold.dart';
import 'package:inspection_app_flutter/utils/loader.dart';
import 'package:inspection_app_flutter/viewmodel/inspector_survey_report_view_model.dart';
import 'package:inspection_app_flutter/viewmodel/survey_report_view_model.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

enum LegendShape { circle, rectangle }

class InspectorSurveyReport extends StatefulWidget {
  const InspectorSurveyReport({Key? key}) : super(key: key);

  @override
  InspectorSurveyReportState createState() => InspectorSurveyReportState();
}

class InspectorSurveyReportState extends State<InspectorSurveyReport> {
  /* final legendLabels = <String, String>{
    "Poor": "Flutter legend",
    "Average": "React legend",
    "Good": "Xamarin legend",
    "Excellent": "Ionic legend",
  }; */

  final colorList = <Color>[
    const Color(0xfffdcb6e),
    const Color(0xff0984e3),
    const Color(0xfffd79a8),
    const Color(0xffe17055),
    const Color(0xff6c5ce7),
  ];

  final gradientList = <List<Color>>[
    [
      const Color.fromRGBO(223, 250, 92, 1),
      const Color.fromRGBO(129, 250, 112, 1),
    ],
    [
      const Color.fromRGBO(129, 182, 205, 1),
      const Color.fromRGBO(91, 253, 199, 1),
    ],
    [
      const Color.fromRGBO(175, 63, 62, 1.0),
      const Color.fromRGBO(254, 154, 92, 1),
    ]
  ];
  ChartType? _chartType = ChartType.disc;
  bool _showCenterText = false;
  double? _ringStrokeWidth = 32;
  double? _chartLegendSpacing = 32;

  bool _showLegendsInRow = true;
  bool _showLegends = true;
  bool _showLegendLabel = false;

  bool _showChartValueBackground = true;
  bool _showChartValues = true;
  bool _showChartValuesInPercentage = false;
  bool _showChartValuesOutside = false;

  bool _showGradientColors = false;

  LegendShape? _legendShape = LegendShape.circle;
  LegendPosition? _legendPosition = LegendPosition.bottom;

  int key = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final inspectorSurveyReportViewModel =
          Provider.of<InspectorSurveyReportViewModel>(context, listen: false);
      await inspectorSurveyReportViewModel.getMemberSurveyReport(context);
      setState(() {
        
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final inspectorSurveyReportViewModel =
        Provider.of<InspectorSurveyReportViewModel>(context, listen: false);
    final chart = PieChart(
      /* centerTextStyle: TextStyle(
        fontSize: 30,
        color: Colors.black,
      ), */
      key: ValueKey(key),
      dataMap: inspectorSurveyReportViewModel.dataMap,
      animationDuration: const Duration(milliseconds: 800),
      chartLegendSpacing: _chartLegendSpacing!,
      chartRadius: math.min(MediaQuery.of(context).size.width / 1, 300),
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: _chartType!,
      centerText: _showCenterText ? "Report" : null,
      //legendLabels: _showLegendLabel ? legendLabels : {},
      legendOptions: LegendOptions(
        
        showLegendsInRow: _showLegendsInRow,
        legendPosition: _legendPosition!,
        showLegends: _showLegends,
        legendShape: _legendShape == LegendShape.circle
            ? BoxShape.circle
            : BoxShape.rectangle,
        legendTextStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 30
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        
        showChartValueBackground: _showChartValueBackground,
        showChartValues: _showChartValues,
        chartValueStyle: TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
        showChartValuesInPercentage: _showChartValuesInPercentage,
        showChartValuesOutside: _showChartValuesOutside,
      ),
      //totalValue: 100,
      ringStrokeWidth: _ringStrokeWidth!,
      emptyColor: Colors.grey,
      gradientList: _showGradientColors ? gradientList : null,
      emptyColorGradient: const [
        Color(0xff6c5ce7),
        Colors.blue,
      ],
      baseChartColor: Colors.transparent,
    );
    return Stack(
      children: [
        BaseScaffold(
          /* appBar: AppBar(
            title: const Text("Pie Chart @apgapg"),
            actions: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    key = key + 1;
                  });
                },
                child: Text("Reload".toUpperCase()),
              ),
            ],
          ), */
          AppBarvis: true,
          titleName: "Survey Report",
          child: Center(
            child: LayoutBuilder(
              builder: (_, constraints) {
                if (constraints.maxWidth >= 600) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 3,
                        fit: FlexFit.tight,
                        child: chart,
                      ),
                      /* Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: settings,
                      ) */
                    ],
                  );
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 32,
                          ),
                          child: chart,
                        ),
                        //settings,
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ),
        if (inspectorSurveyReportViewModel.getIsLoadingStatus) LoaderComponent()
      ],
    );
  }
}

class HomePage2 extends StatelessWidget {
  HomePage2({Key? key}) : super(key: key);

  final dataMap = <String, double>{
    "Flutter": 5,
  };

  final colorList = <Color>[
    Colors.greenAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pie Chart 1"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: PieChart(
          dataMap: dataMap,
          chartType: ChartType.ring,
          baseChartColor: Colors.grey[50]!.withOpacity(0.15),
          colorList: colorList,
          chartValuesOptions: const ChartValuesOptions(
            showChartValuesInPercentage: true,
          ),
          totalValue: 20,
        ),
      ),
    );
  }
}
