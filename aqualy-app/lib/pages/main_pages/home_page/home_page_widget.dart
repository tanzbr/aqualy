import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/cards/cards_widget.dart';
import '/components/empty_list/empty_list_widget.dart';
import '/components/header/header_widget.dart';
import '/components/medidor_card/medidor_card_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'dart:async';
import 'package:custom_date_range_picker_wcsgof/app_state.dart'
    as custom_date_range_picker_wcsgof_app_state;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  static String routeName = 'HomePage';
  static String routePath = '/homePage';

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (FFAppState().loggedUser.id != 0) {
        _model.medidoresResult = await BackendGroup.medidoresByUserCall.call(
          id: FFAppState().loggedUser.id,
        );

        if ((_model.medidoresResult?.succeeded ?? true)) {
          FFAppState().medidores = ((_model.medidoresResult?.jsonBody ?? '')
                  .toList()
                  .map<MedidorStruct?>(MedidorStruct.maybeFromMap)
                  .toList() as Iterable<MedidorStruct?>)
              .withoutNulls
              .toList()
              .cast<MedidorStruct>();
          FFAppState().insightSelectedMedidor =
              FFAppState().medidores.firstOrNull!;
        }
      } else {
        context.pushNamed(SignInWidget.routeName);

        return;
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              wrapWithModel(
                model: _model.headerModel,
                updateCallback: () => safeSetState(() {}),
                child: HeaderWidget(),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 0.0, 0.0),
                child: Text(
                  'Bem vindo, ${functions.getFirstName(FFAppState().loggedUser.nome)}',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        fontSize: 20.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
              ),
              Flexible(
                child: FutureBuilder<ApiCallResponse>(
                  future: BackendGroup.getEstatisticaMensalCall.call(
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
                    final cardsGetEstatisticaMensalResponse = snapshot.data!;

                    return wrapWithModel(
                      model: _model.cardsModel,
                      updateCallback: () => safeSetState(() {}),
                      child: CardsWidget(
                        monthlyUsage: BackendGroup.getEstatisticaMensalCall
                            .litrosAcumulados(
                          cardsGetEstatisticaMensalResponse.jsonBody,
                        )!,
                        totalCost:
                            BackendGroup.getEstatisticaMensalCall.gastoMes(
                          cardsGetEstatisticaMensalResponse.jsonBody,
                        )!,
                        economy:
                            BackendGroup.getEstatisticaMensalCall.economiaMes(
                          cardsGetEstatisticaMensalResponse.jsonBody,
                        )!,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 30.0, 0.0, 0.0),
                child: Text(
                  'Seus medidores',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        fontSize: 20.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
              ),
              FutureBuilder<ApiCallResponse>(
                future:
                    (_model.apiRequestCompleter ??= Completer<ApiCallResponse>()
                          ..complete(BackendGroup.medidoresByUserCall.call(
                            id: FFAppState().loggedUser.id,
                          )))
                        .future,
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
                  final listViewMedidoresByUserResponse = snapshot.data!;

                  return Builder(
                    builder: (context) {
                      final medidor = (listViewMedidoresByUserResponse.jsonBody
                                  .toList()
                                  .map<MedidorStruct?>(
                                      MedidorStruct.maybeFromMap)
                                  .toList() as Iterable<MedidorStruct?>)
                              .withoutNulls
                              .toList() ??
                          [];
                      if (medidor.isEmpty) {
                        return EmptyListWidget();
                      }

                      return RefreshIndicator(
                        onRefresh: () async {
                          safeSetState(() => _model.apiRequestCompleter = null);
                          await _model.waitForApiRequestCompleted();
                        },
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: medidor.length,
                          itemBuilder: (context, medidorIndex) {
                            final medidorItem = medidor[medidorIndex];
                            return wrapWithModel(
                              model: _model.medidorCardModels.getModel(
                                medidorIndex.toString(),
                                medidorIndex,
                              ),
                              updateCallback: () => safeSetState(() {}),
                              child: MedidorCardWidget(
                                key: Key(
                                  'Keyryq_${medidorIndex.toString()}',
                                ),
                                medidor: medidorItem,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
