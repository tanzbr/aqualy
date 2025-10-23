import '/backend/api_requests/api_calls.dart';
import '/components/header/header_widget.dart';
import '/components/interval_item_widget.dart';
import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:custom_date_range_picker_wcsgof/app_state.dart'
    as custom_date_range_picker_wcsgof_app_state;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'stats_page_model.dart';
export 'stats_page_model.dart';

class StatsPageWidget extends StatefulWidget {
  const StatsPageWidget({super.key});

  static String routeName = 'StatsPage';
  static String routePath = '/statsPage';

  @override
  State<StatsPageWidget> createState() => _StatsPageWidgetState();
}

class _StatsPageWidgetState extends State<StatsPageWidget> {
  late StatsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StatsPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (custom_date_range_picker_wcsgof_app_state.FFAppState()
                      .startDate ==
                  ''
          ? true
          : false) {
        _model.startDate = getCurrentTimestamp;
        _model.endDate = getCurrentTimestamp;
      }
      safeSetState(() {});
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    context.watch<custom_date_range_picker_wcsgof_app_state.FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                wrapWithModel(
                  model: _model.headerModel,
                  updateCallback: () => safeSetState(() {}),
                  child: HeaderWidget(),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                  child: Container(
                    height: 30.0,
                    decoration: BoxDecoration(),
                    child: Builder(
                      builder: (context) {
                        final intervaloItem = FFAppState().intervalos.toList();

                        return ListView.separated(
                          padding: EdgeInsets.fromLTRB(
                            16.0,
                            0,
                            16.0,
                            0,
                          ),
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: intervaloItem.length,
                          separatorBuilder: (_, __) => SizedBox(width: 16.0),
                          itemBuilder: (context, intervaloItemIndex) {
                            final intervaloItemItem =
                                intervaloItem[intervaloItemIndex];
                            return InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                FFAppState().selectedInterval =
                                    intervaloItemItem;
                                safeSetState(() {});
                              },
                              child: wrapWithModel(
                                model: _model.intervalItemModels.getModel(
                                  intervaloItemItem,
                                  intervaloItemIndex,
                                ),
                                updateCallback: () => safeSetState(() {}),
                                child: IntervalItemWidget(
                                  key: Key(
                                    'Key4v6_${intervaloItemItem}',
                                  ),
                                  name: intervaloItemItem,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10.0, 15.0, 10.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 15.0, 0.0, 0.0),
                              child: Text(
                                'Consumo',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      fontSize: 20.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 20.0, 0.0, 0.0),
                              child: FutureBuilder<ApiCallResponse>(
                                future:
                                    BackendGroup.getGraficoByUsuarioCall.call(
                                  id: FFAppState().loggedUser.id,
                                  metric: 'consumo',
                                  dataInicio: functions
                                      .getDateIntervals(
                                          FFAppState().selectedInterval)
                                      .firstOrNull,
                                  dataFim: functions
                                      .getDateIntervals(
                                          FFAppState().selectedInterval)
                                      .lastOrNull,
                                ),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 50.0,
                                        height: 50.0,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  final chartGetGraficoByUsuarioResponse =
                                      snapshot.data!;

                                  return Container(
                                    width: 370.0,
                                    height: 230.0,
                                    child: FlutterFlowLineChart(
                                      data: [
                                        FFLineChartData(
                                          xData: GraficoStruct.maybeFromMap(
                                                  chartGetGraficoByUsuarioResponse
                                                      .jsonBody)!
                                              .intervalos,
                                          yData: GraficoStruct.maybeFromMap(
                                                  chartGetGraficoByUsuarioResponse
                                                      .jsonBody)!
                                              .valores,
                                          settings: LineChartBarData(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            barWidth: 2.0,
                                            belowBarData: BarAreaData(
                                              show: true,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .accent1,
                                            ),
                                          ),
                                        )
                                      ],
                                      chartStylingInfo: ChartStylingInfo(
                                        enableTooltip: true,
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                        showBorder: false,
                                      ),
                                      axisBounds: AxisBounds(),
                                      xAxisLabelInfo: AxisLabelInfo(
                                        title: 'Dia',
                                        titleTextStyle: TextStyle(
                                          fontSize: 14.0,
                                        ),
                                        reservedSize: 32.0,
                                      ),
                                      yAxisLabelInfo: AxisLabelInfo(
                                        title: 'Litros',
                                        titleTextStyle: TextStyle(
                                          fontSize: 14.0,
                                        ),
                                        showLabels: true,
                                        labelTextStyle: TextStyle(),
                                        labelInterval: 10.0,
                                        labelFormatter: LabelFormatter(
                                          numberFormat: (val) => val.toString(),
                                        ),
                                        reservedSize: 40.0,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10.0, 0.0, 10.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 20.0, 0.0, 0.0),
                              child: Text(
                                'Total de gastos',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      fontSize: 20.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 20.0, 0.0, 0.0),
                              child: FutureBuilder<ApiCallResponse>(
                                future:
                                    BackendGroup.getGraficoByUsuarioCall.call(
                                  id: FFAppState().loggedUser.id,
                                  metric: 'gasto',
                                  dataInicio: functions
                                      .getDateIntervals(
                                          FFAppState().selectedInterval)
                                      .firstOrNull,
                                  dataFim: functions
                                      .getDateIntervals(
                                          FFAppState().selectedInterval)
                                      .lastOrNull,
                                ),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 50.0,
                                        height: 50.0,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  final chartGetGraficoByUsuarioResponse =
                                      snapshot.data!;

                                  return Container(
                                    width: 370.0,
                                    height: 230.0,
                                    child: FlutterFlowBarChart(
                                      barData: [
                                        FFBarChartData(
                                          yData: List.generate(
                                              random_data.randomInteger(10, 10),
                                              (index) => random_data
                                                  .randomInteger(0, 10)),
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                        )
                                      ],
                                      xLabels: List.generate(
                                          random_data.randomInteger(10, 10),
                                          (index) => random_data.randomString(
                                                3,
                                                6,
                                                true,
                                                false,
                                                false,
                                              )),
                                      barWidth: 16.0,
                                      barBorderRadius:
                                          BorderRadius.circular(8.0),
                                      groupSpace: 8.0,
                                      alignment: BarChartAlignment.spaceAround,
                                      chartStylingInfo: ChartStylingInfo(
                                        enableTooltip: true,
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                        showBorder: false,
                                      ),
                                      axisBounds: AxisBounds(),
                                      xAxisLabelInfo: AxisLabelInfo(
                                        title: 'Dia',
                                        titleTextStyle: TextStyle(
                                          fontSize: 14.0,
                                        ),
                                        reservedSize: 28.0,
                                      ),
                                      yAxisLabelInfo: AxisLabelInfo(
                                        title: 'R\$',
                                        titleTextStyle: TextStyle(
                                          fontSize: 14.0,
                                        ),
                                        showLabels: true,
                                        labelInterval: 10.0,
                                        labelFormatter: LabelFormatter(
                                          numberFormat: (val) => val.toString(),
                                        ),
                                        reservedSize: 42.0,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10.0, 0.0, 10.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 20.0, 0.0, 0.0),
                              child: Text(
                                'Média de vazão',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      fontSize: 20.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 20.0, 0.0, 0.0),
                              child: FutureBuilder<ApiCallResponse>(
                                future:
                                    BackendGroup.getGraficoByUsuarioCall.call(
                                  id: FFAppState().loggedUser.id,
                                  metric: 'vazao',
                                  dataInicio: functions
                                      .getDateIntervals(
                                          FFAppState().selectedInterval)
                                      .firstOrNull,
                                  dataFim: functions
                                      .getDateIntervals(
                                          FFAppState().selectedInterval)
                                      .lastOrNull,
                                ),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 50.0,
                                        height: 50.0,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  final chartGetGraficoByUsuarioResponse =
                                      snapshot.data!;

                                  return Container(
                                    width: 370.0,
                                    height: 230.0,
                                    child: FlutterFlowLineChart(
                                      data: [
                                        FFLineChartData(
                                          xData: GraficoStruct.maybeFromMap(
                                                  chartGetGraficoByUsuarioResponse
                                                      .jsonBody)!
                                              .intervalos,
                                          yData: GraficoStruct.maybeFromMap(
                                                  chartGetGraficoByUsuarioResponse
                                                      .jsonBody)!
                                              .valores,
                                          settings: LineChartBarData(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            barWidth: 2.0,
                                            belowBarData: BarAreaData(
                                              show: true,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .accent1,
                                            ),
                                          ),
                                        )
                                      ],
                                      chartStylingInfo: ChartStylingInfo(
                                        enableTooltip: true,
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                        showBorder: false,
                                      ),
                                      axisBounds: AxisBounds(),
                                      xAxisLabelInfo: AxisLabelInfo(
                                        title: 'Dia',
                                        titleTextStyle: TextStyle(
                                          fontSize: 14.0,
                                        ),
                                        reservedSize: 32.0,
                                      ),
                                      yAxisLabelInfo: AxisLabelInfo(
                                        title: 'L/min',
                                        titleTextStyle: TextStyle(
                                          fontSize: 14.0,
                                        ),
                                        showLabels: true,
                                        labelTextStyle: TextStyle(),
                                        labelInterval: 10.0,
                                        reservedSize: 40.0,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
