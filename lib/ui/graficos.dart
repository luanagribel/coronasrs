import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GraficosPage extends StatefulWidget {
  final Widget child;

  GraficosPage({Key key, this.child}) : super(key: key);

  _GraficosState createState() => _GraficosState();
}

class _GraficosState extends State<GraficosPage> {
  List<charts.Series<Data, String>> _seriesData;
  List<charts.Series<Line, num>> _seriesLineData;

  _generateData() {
    var data1 = [
      Data('Casos', 547, Colors.lightBlue[200]),
      Data('Recuperados', 412, Color(0xFF03A688)),
      Data('Mortes', 9, Colors.red[200]),
    ];

    var linedata = [
      Line(0, 1.44),
      Line(1, 1.45),
      Line(2, 1.43), //alterar
      Line(3, 2.35),
      Line(4, 1.64)
    ];

    _seriesData.add(
      charts.Series(
        domainFn: (Data data, _) => data.variavel,
        measureFn: (Data data, _) => data.quantidade,
        colorFn: (Data data, _) => data.color,
        id: 'Comparacao',
        data: data1,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,

        /*fillColorFn: (Data data, _) =>
            charts.ColorUtil.fromDartColor(Colors.blue[700]), */
      ),
    );

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Colors.red[200]),
        id: 'Taxa',
        data: linedata,
        domainFn: (Line line, _) => line.mes,
        measureFn: (Line line, _) => line.taxamort,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesData = List<charts.Series<Data, String>>();
    _seriesLineData = List<charts.Series<Line, num>>();
    _generateData();
  }

  final customTickFormatter = charts.BasicNumericTickFormatterSpec((num value) {
    if (value == 0) {
      return "Jan";
    } else if (value == 1) {
      return "Fev";
    } else if (value == 2) {
      return "Mar";
    } else if (value == 3) {
      return "Abr";
    } else if (value == 4) {
      return "Maio";
    }
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Color(0xFF121212),
          appBar: AppBar(
            backgroundColor: Color(0xFF121212),
            title: TabBar(
              indicatorColor: Color(0xFF03A688),
              tabs: [
                Tab(
                  icon: Icon(
                    FontAwesomeIcons.solidChartBar,
                    color: Colors.white,
                  ),
                ),
                Tab(
                    icon:
                        Icon(FontAwesomeIcons.chartLine, color: Colors.white)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Color(
                      0xFF252525,
                    ),
                    border: Border.all(
                        width: 1.0,
                        color: Color(
                          0xFF252525,
                        )),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'COMPARAÇÃO',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '(Dados referentes ao último mês)',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF03A688),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Expanded(
                          child: charts.BarChart(
                            _seriesData,
                            animate: true,

                            domainAxis: new charts.OrdinalAxisSpec(
                                renderSpec: new charts.SmallTickRendererSpec(

                                    // Tick and Label styling here.
                                    labelStyle: new charts.TextStyleSpec(
                                        fontSize: 18, // size in Pts.
                                        color: charts.MaterialPalette.white),

                                    // Change the line colors to match text color.
                                    lineStyle: new charts.LineStyleSpec(
                                        color: charts.MaterialPalette.white))),

                            primaryMeasureAxis: new charts.NumericAxisSpec(
                                renderSpec: new charts.GridlineRendererSpec(

                                    // Tick and Label styling here.
                                    labelStyle: new charts.TextStyleSpec(
                                        fontSize: 18, // size in Pts.
                                        color: charts.MaterialPalette.white),

                                    // Change the line colors to match text color.
                                    lineStyle: new charts.LineStyleSpec(
                                        color: charts.MaterialPalette.white))),

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
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Color(
                      0xFF252525,
                    ),
                    border: Border.all(
                        width: 1.0,
                        color: Color(
                          0xFF252525,
                        )),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'TAXA DE MORTALIDADE',
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '2021',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF03A688),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Expanded(
                          child: charts.LineChart(_seriesLineData,
                              defaultRenderer: charts.LineRendererConfig(
                                  includeArea: true, stacked: true),
                              animate: true,
                              animationDuration: Duration(seconds: 3),
                              domainAxis: new charts.NumericAxisSpec(
                                renderSpec: new charts.GridlineRendererSpec(
                                  // Tick and Label styling here.
                                  labelStyle: new charts.TextStyleSpec(
                                      fontSize: 18, // size in Pts.
                                      color: charts.MaterialPalette.white),
                                ),
                                tickProviderSpec:
                                    charts.BasicNumericTickProviderSpec(
                                  desiredTickCount: 5,
                                ),
                                tickFormatterSpec: customTickFormatter,
                              ),
                              primaryMeasureAxis: new charts.NumericAxisSpec(
                                  renderSpec: new charts.GridlineRendererSpec(
                                // Tick and Label styling here.
                                labelStyle: new charts.TextStyleSpec(
                                    fontSize: 18, // size in Pts.
                                    color: charts.MaterialPalette.white),

                                // Change the line colors to match text color.
                                /*  lineStyle: new charts.LineStyleSpec(
                                        color: charts.MaterialPalette.white) */
                              )),
                              behaviors: [
                                charts.ChartTitle(
                                  '',
                                  titleStyleSpec: charts.TextStyleSpec(
                                      color: charts.ColorUtil.fromDartColor(
                                          Colors.white)),
                                  behaviorPosition:
                                      charts.BehaviorPosition.bottom,
                                  titleOutsideJustification: charts
                                      .OutsideJustification.middleDrawArea,
                                ),
                                charts.ChartTitle('%',
                                    titleStyleSpec: charts.TextStyleSpec(
                                        color: charts.ColorUtil.fromDartColor(
                                            Colors.white)),
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
  final charts.Color color;

  Data(this.variavel, this.quantidade, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class Line {
  int mes;
  double taxamort;

  Line(this.mes, this.taxamort);
}
