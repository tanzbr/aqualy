import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/custom_app_bar/custom_app_bar_widget.dart';
import '/components/interval_item_widget.dart';
import '/components/power_button_small/power_button_small_widget.dart';
import '/components/realtime_cards/realtime_cards_widget.dart';
import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:custom_date_range_picker_wcsgof/app_state.dart'
    as custom_date_range_picker_wcsgof_app_state;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'medidor_details_page_model.dart';
export 'medidor_details_page_model.dart';

class MedidorDetailsPageWidget extends StatefulWidget {
  const MedidorDetailsPageWidget({
    super.key,
    required this.medidorSelecionado,
  });

  final MedidorStruct? medidorSelecionado;

  static String routeName = 'MedidorDetailsPage';
  static String routePath = '/medidorDetailsPage';

  @override
  State<MedidorDetailsPageWidget> createState() =>
      _MedidorDetailsPageWidgetState();
}

class _MedidorDetailsPageWidgetState extends State<MedidorDetailsPageWidget> {
  late MedidorDetailsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MedidorDetailsPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (custom_date_range_picker_wcsgof_app_state.FFAppState()
                      .startDate ==
                  ''
          ? true
          : false) {
        _model.startDate = getCurrentTimestamp;
        _model.endDate = getCurrentTimestamp;
        safeSetState(() {});
      }
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
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 24.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        wrapWithModel(
                          model: _model.customAppBarModel,
                          updateCallback: () => safeSetState(() {}),
                          child: CustomAppBarWidget(),
                        ),
                        wrapWithModel(
                          model: _model.powerButtonSmallModel,
                          updateCallback: () => safeSetState(() {}),
                          child: PowerButtonSmallWidget(
                            isOnline: false,
                            action: () async {},
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 24.0, 0.0, 0.0),
                              child: Text(
                                valueOrDefault<String>(
                                  widget.medidorSelecionado?.nome,
                                  'Nome medidor',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .displaySmall
                                    .override(
                                      font: GoogleFonts.interTight(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .displaySmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .displaySmall
                                            .fontStyle,
                                      ),
                                      fontSize: 32.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .displaySmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .displaySmall
                                          .fontStyle,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 5.0, 0.0, 0.0),
                              child: Text(
                                valueOrDefault<String>(
                                  widget.medidorSelecionado?.localizacao,
                                  'Localização',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .displaySmall
                                    .override(
                                      font: GoogleFonts.interTight(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .displaySmall
                                            .fontStyle,
                                      ),
                                      fontSize: 18.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .displaySmall
                                          .fontStyle,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        FlutterFlowIconButton(
                          borderRadius: 8.0,
                          icon: Icon(
                            Icons.settings_sharp,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                          onPressed: () async {
                            context.pushNamed(
                              MedidorSettingsPageWidget.routeName,
                              queryParameters: {
                                'medidor': serializeParam(
                                  widget.medidorSelecionado,
                                  ParamType.DataStruct,
                                ),
                              }.withoutNulls,
                            );
                          },
                        ),
                      ].divide(SizedBox(width: 5.0)),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                      child: wrapWithModel(
                        model: _model.realtimeCardsModel,
                        updateCallback: () => safeSetState(() {}),
                        child: RealtimeCardsWidget(
                          medidorId: widget.medidorSelecionado!.id,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 25.0, 0.0, 0.0),
                      child: Container(
                        height: 30.0,
                        decoration: BoxDecoration(),
                        child: Builder(
                          builder: (context) {
                            final intervaloItem =
                                FFAppState().intervalos.toList();

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
                              separatorBuilder: (_, __) =>
                                  SizedBox(width: 16.0),
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
                                        'Keyqcm_${intervaloItemItem}',
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
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
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
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          fontSize: 20.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 20.0, 0.0, 0.0),
                                  child: FutureBuilder<ApiCallResponse>(
                                    future: BackendGroup.getGraficoByMedidorCall
                                        .call(
                                      id: widget.medidorSelecionado?.id,
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
                                      final chartGetGraficoByMedidorResponse =
                                          snapshot.data!;

                                      return Container(
                                        width: 370.0,
                                        height: 230.0,
                                        child: FlutterFlowLineChart(
                                          data: [
                                            FFLineChartData(
                                              xData: GraficoStruct.maybeFromMap(
                                                      chartGetGraficoByMedidorResponse
                                                          .jsonBody)!
                                                  .intervalos,
                                              yData: GraficoStruct.maybeFromMap(
                                                      chartGetGraficoByMedidorResponse
                                                          .jsonBody)!
                                                  .valores,
                                              settings: LineChartBarData(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                barWidth: 2.0,
                                                belowBarData: BarAreaData(
                                                  show: true,
                                                  color: FlutterFlowTheme.of(
                                                          context)
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
                                              numberFormat: (val) =>
                                                  val.toString(),
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
                                    'Média de vazão',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          fontSize: 20.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 20.0, 0.0, 0.0),
                                  child: FutureBuilder<ApiCallResponse>(
                                    future: BackendGroup.getGraficoByMedidorCall
                                        .call(
                                      id: widget.medidorSelecionado?.id,
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
                                      final chartGetGraficoByMedidorResponse =
                                          snapshot.data!;

                                      return Container(
                                        width: 370.0,
                                        height: 230.0,
                                        child: FlutterFlowLineChart(
                                          data: [
                                            FFLineChartData(
                                              xData: GraficoStruct.maybeFromMap(
                                                      chartGetGraficoByMedidorResponse
                                                          .jsonBody)!
                                                  .intervalos,
                                              yData: GraficoStruct.maybeFromMap(
                                                      chartGetGraficoByMedidorResponse
                                                          .jsonBody)!
                                                  .valores,
                                              settings: LineChartBarData(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                barWidth: 2.0,
                                                belowBarData: BarAreaData(
                                                  show: true,
                                                  color: FlutterFlowTheme.of(
                                                          context)
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
        ),
      ),
    );
  }
}
