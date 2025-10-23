import '/flutter_flow/flutter_flow_util.dart';
import 'package:custom_date_range_picker_wcsgof/app_state.dart'
    as custom_date_range_picker_wcsgof_app_state;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'interval_item_model.dart';
export 'interval_item_model.dart';

class IntervalItemWidget extends StatefulWidget {
  const IntervalItemWidget({
    super.key,
    required this.name,
  });

  final String? name;

  @override
  State<IntervalItemWidget> createState() => _IntervalItemWidgetState();
}

class _IntervalItemWidgetState extends State<IntervalItemWidget> {
  late IntervalItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => IntervalItemModel());
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

    return Container(
      height: 30.0,
      decoration: BoxDecoration(
        color: FFAppState().selectedInterval == widget.name
            ? FlutterFlowTheme.of(context).secondaryBackground
            : FlutterFlowTheme.of(context).alternate,
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
                widget.name,
                'name',
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(
                      fontWeight:
                          FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
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
    );
  }
}
