import '/backend/schema/structs/index.dart';
import '/components/sugestao_details_bottom/sugestao_details_bottom_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sugestao_card_model.dart';
export 'sugestao_card_model.dart';

class SugestaoCardWidget extends StatefulWidget {
  const SugestaoCardWidget({
    super.key,
    required this.sugestaoItem,
  });

  final SugestaoIaItemStruct? sugestaoItem;

  @override
  State<SugestaoCardWidget> createState() => _SugestaoCardWidgetState();
}

class _SugestaoCardWidgetState extends State<SugestaoCardWidget> {
  late SugestaoCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SugestaoCardModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20.0, 15.0, 20.0, 0.0),
      child: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          Container(
            height: 90.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              boxShadow: [
                BoxShadow(
                  blurRadius: 2.0,
                  color: Color(0xC1C400B5),
                  offset: Offset(
                    0.0,
                    2.0,
                  ),
                )
              ],
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 20.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.auto_awesome_sharp,
                    color: Color(0xFFDC00BC),
                    size: 24.0,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.55,
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 10.0, 0.0),
                                child: Text(
                                  valueOrDefault<String>(
                                    widget.sugestaoItem?.titulo,
                                    'Titulooooooooooooooooooooooooooooooooooooooooooo',
                                  ),
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
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ].divide(SizedBox(width: 10.0)),
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        useSafeArea: true,
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: MediaQuery.viewInsetsOf(context),
                            child: Container(
                              height: MediaQuery.sizeOf(context).height * 0.6,
                              child: SugestaoDetailsBottomWidget(
                                sugestaoItem: widget.sugestaoItem!,
                              ),
                            ),
                          );
                        },
                      ).then((value) => safeSetState(() {}));
                    },
                    text: 'Ver',
                    options: FFButtonOptions(
                      height: 40.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: Color(0xFFEA1CFF),
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                font: GoogleFonts.interTight(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                                color: Colors.white,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
