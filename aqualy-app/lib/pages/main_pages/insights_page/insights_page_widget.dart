import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/header/header_widget.dart';
import '/components/medidor_item_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/sugestao_card/sugestao_card_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:custom_date_range_picker_wcsgof/app_state.dart'
    as custom_date_range_picker_wcsgof_app_state;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'insights_page_model.dart';
export 'insights_page_model.dart';

class InsightsPageWidget extends StatefulWidget {
  const InsightsPageWidget({super.key});

  static String routeName = 'InsightsPage';
  static String routePath = '/insightsPage';

  @override
  State<InsightsPageWidget> createState() => _InsightsPageWidgetState();
}

class _InsightsPageWidgetState extends State<InsightsPageWidget> {
  late InsightsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InsightsPageModel());
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
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                        child: Text(
                          'Escolha um medidor',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                        child: Container(
                          height: 30.0,
                          decoration: BoxDecoration(),
                          child: FutureBuilder<ApiCallResponse>(
                            future: BackendGroup.medidoresByUserCall.call(
                              id: FFAppState().loggedUser.id,
                            ),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 50.0,
                                    height: 50.0,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        FlutterFlowTheme.of(context).primary,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              final listViewMedidoresByUserResponse =
                                  snapshot.data!;

                              return Builder(
                                builder: (context) {
                                  final medidorItem =
                                      (listViewMedidoresByUserResponse.jsonBody
                                                      .toList()
                                                      .map<MedidorStruct?>(
                                                          MedidorStruct
                                                              .maybeFromMap)
                                                      .toList()
                                                  as Iterable<MedidorStruct?>)
                                              .withoutNulls
                                              .toList() ??
                                          [];

                                  return ListView.separated(
                                    padding: EdgeInsets.fromLTRB(
                                      20.0,
                                      0,
                                      0,
                                      0,
                                    ),
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: medidorItem.length,
                                    separatorBuilder: (_, __) =>
                                        SizedBox(width: 10.0),
                                    itemBuilder: (context, medidorItemIndex) {
                                      final medidorItemItem =
                                          medidorItem[medidorItemIndex];
                                      return InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          FFAppState().insightSelectedMedidor =
                                              medidorItemItem;
                                          safeSetState(() {});
                                        },
                                        child: wrapWithModel(
                                          model:
                                              _model.medidorItemModels.getModel(
                                            medidorItemIndex.toString(),
                                            medidorItemIndex,
                                          ),
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: MedidorItemWidget(
                                            key: Key(
                                              'Keyh7c_${medidorItemIndex.toString()}',
                                            ),
                                            medidorItem: medidorItemItem,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                        child: FutureBuilder<ApiCallResponse>(
                          future: BackendGroup.getRecommendationsCall.call(
                            id: FFAppState().insightSelectedMedidor.id,
                            dataInicio: functions
                                .getDateIntervals('30 dias')
                                .firstOrNull,
                            dataFim: functions
                                .getDateIntervals('30 dias')
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
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      FlutterFlowTheme.of(context).primary,
                                    ),
                                  ),
                                ),
                              );
                            }
                            final listViewGetRecommendationsResponse =
                                snapshot.data!;

                            return Builder(
                              builder: (context) {
                                final sugestaoItem =
                                    SugestaoIAStruct.maybeFromMap(
                                                listViewGetRecommendationsResponse
                                                    .jsonBody)
                                            ?.sugestoes
                                            .toList() ??
                                        [];

                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: sugestaoItem.length,
                                  itemBuilder: (context, sugestaoItemIndex) {
                                    final sugestaoItemItem =
                                        sugestaoItem[sugestaoItemIndex];
                                    return wrapWithModel(
                                      model: _model.sugestaoCardModels.getModel(
                                        sugestaoItemIndex.toString(),
                                        sugestaoItemIndex,
                                      ),
                                      updateCallback: () => safeSetState(() {}),
                                      child: SugestaoCardWidget(
                                        key: Key(
                                          'Key25y_${sugestaoItemIndex.toString()}',
                                        ),
                                        sugestaoItem: sugestaoItemItem,
                                      ),
                                    );
                                  },
                                );
                              },
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
        ),
      ),
    );
  }
}
