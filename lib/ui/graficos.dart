import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Graficos extends StatefulWidget {
  final Widget child;

  Graficos({Key key, this.child}) : super(key: key);

  _GraficosState createState() => _GraficosState();
}

class _GraficosState extends State<Graficos> {
  List<charts.Series<Data, String>> _seriesData;
  List<charts.Series<Line, int>> _seriesLineData;

  _generateData() {
    var data1 = [
      new Data('Casos', 30),
      new Data('Mortes', 40),
      new Data('Recuperados', 10),
    ];

    var linedata = [
      new Line(0, 45),
      new Line(1, 56),
      new Line(2, 55),
      new Line(3, 60),
      new Line(4, 61),
      new Line(5, 70),
    ];

    _seriesData.add(
      charts.Series(
        domainFn: (Data data, _) => data.variavel,
        measureFn: (Data data, _) => data.quantidade,
        id: 'Comparacao',
        data: data1,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Data data, _) =>
            charts.ColorUtil.fromDartColor(Colors.blue[700]),
      ),
    );

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Colors.blue[700]),
        id: 'Taxa',
        data: linedata,
        domainFn: (Line line, _) => line.monthval,
        measureFn: (Line line, _) => line.lineval,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesData = List<charts.Series<Data, String>>();
    _seriesLineData = List<charts.Series<Line, int>>();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: TabBar(
              indicatorColor: Color(0xff1976d2),
              tabs: [
                Tab(
                  icon: Icon(
                    FontAwesomeIcons.solidChartBar,
                    color: Colors.green,
                  ),
                ),
                Tab(
                    icon: Icon(
                  FontAwesomeIcons.chartLine,
                  color: Colors.green,
                )),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Comparação \n\n',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: charts.BarChart(
                            _seriesData,
                            animate: true,
                            barGroupingType: charts.BarGroupingType.grouped,
                            //behaviors: [new charts.SeriesLegend()],
                            animationDuration: Duration(seconds: 3),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Mortalidade \n\n',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: charts.LineChart(_seriesLineData,
                              defaultRenderer: new charts.LineRendererConfig(
                                  includeArea: true, stacked: true),
                              animate: true,
                              animationDuration: Duration(seconds: 3),
                              behaviors: [
                                new charts.ChartTitle('Meses',
                                    behaviorPosition:
                                        charts.BehaviorPosition.bottom,
                                    titleOutsideJustification: charts
                                        .OutsideJustification.middleDrawArea),
                                new charts.ChartTitle('%',
                                    behaviorPosition:
                                        charts.BehaviorPosition.start,
                                    titleOutsideJustification: charts
                                        .OutsideJustification.middleDrawArea),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Data {
  String variavel;
  int quantidade;

  Data(this.variavel, this.quantidade);
}

class Line {
  int monthval;
  int lineval;

  Line(this.monthval, this.lineval);
}
