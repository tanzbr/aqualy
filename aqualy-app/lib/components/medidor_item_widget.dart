import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:custom_date_range_picker_wcsgof/app_state.dart'
    as custom_date_range_picker_wcsgof_app_state;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'medidor_item_model.dart';
export 'medidor_item_model.dart';

class MedidorItemWidget extends StatefulWidget {
  const MedidorItemWidget({
    super.key,
    required this.medidorItem,
  });

  final MedidorStruct? medidorItem;

  @override
  State<MedidorItemWidget> createState() => _MedidorItemWidgetState();
}

class _MedidorItemWidgetState extends State<MedidorItemWidget> {
  late MedidorItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MedidorItemModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    context.watch<custom_date_range_picker_wcsgof_app_state.FFAppState>();

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 3.0),
      child: Container(
        height: 60.0,
        decoration: BoxDecoration(
          color: FFAppState().insightSelectedMedidor == widget.medidorItem
              ? FlutterFlowTheme.of(context).secondaryBackground
              : FlutterFlowTheme.of(context).alternate,
          boxShadow: [
            BoxShadow(
              blurRadius: 1.0,
              color: Color(0x33000000),
              offset: Offset(
                0.0,
                1.0,
              ),
            )
          ],
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
              child: Text(
                valueOrDefault<String>(
                  widget.medidorItem?.nome,
                  'Nome Medidor',
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
