import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'realtime_cards_model.dart';
export 'realtime_cards_model.dart';

/// Create two small cards for real time monitoring: 1.
///
/// Consumo 2. Vazão 3.
class RealtimeCardsWidget extends StatefulWidget {
  const RealtimeCardsWidget({
    super.key,
    required this.medidorId,
  });

  final int? medidorId;

  @override
  State<RealtimeCardsWidget> createState() => _RealtimeCardsWidgetState();
}

class _RealtimeCardsWidgetState extends State<RealtimeCardsWidget> {
  late RealtimeCardsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RealtimeCardsModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      while (true) {
        _model.dataResult = await BackendGroup.getRealTimeCall.call(
          id: widget.medidorId,
        );

        if ((_model.dataResult?.succeeded ?? true)) {
          _model.consumo = BackendGroup.getRealTimeCall.consumoLitros(
            (_model.dataResult?.jsonBody ?? ''),
          );
          _model.vazao = BackendGroup.getRealTimeCall.vazaoLMin(
            (_model.dataResult?.jsonBody ?? ''),
          );
          safeSetState(() {});
        }
        await Future.delayed(
          Duration(
            milliseconds: 3000,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Consumo',
                          style: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                font: GoogleFonts.inter(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                        ),
                        Icon(
                          Icons.water_drop,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 20.0,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          valueOrDefault<String>(
                            formatNumber(
                              _model.consumo,
                              formatType: FormatType.decimal,
                              decimalType: DecimalType.periodDecimal,
                            ),
                            '0',
                          ),
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                font: GoogleFonts.interTight(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .fontStyle,
                              ),
                        ),
                        Text(
                          'Litros',
                          style: FlutterFlowTheme.of(context)
                              .bodySmall
                              .override(
                                font: GoogleFonts.inter(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .fontStyle,
                                ),
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .fontStyle,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Vazão',
                          style: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                font: GoogleFonts.inter(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                        ),
                        Icon(
                          Icons.speed,
                          color: FlutterFlowTheme.of(context).secondary,
                          size: 20.0,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          valueOrDefault<String>(
                            _model.vazao?.toString(),
                            '0',
                          ),
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                font: GoogleFonts.interTight(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .fontStyle,
                              ),
                        ),
                        Text(
                          'L/min',
                          style: FlutterFlowTheme.of(context)
                              .bodySmall
                              .override(
                                font: GoogleFonts.inter(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .fontStyle,
                                ),
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .fontStyle,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ].divide(SizedBox(width: 12.0)),
      ),
    );
  }
}
