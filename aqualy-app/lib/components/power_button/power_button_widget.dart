import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'power_button_model.dart';
export 'power_button_model.dart';

class PowerButtonWidget extends StatefulWidget {
  const PowerButtonWidget({
    super.key,
    bool? isOnline,
    this.action,
  }) : this.isOnline = isOnline ?? false;

  final bool isOnline;
  final Future Function()? action;

  @override
  State<PowerButtonWidget> createState() => _PowerButtonWidgetState();
}

class _PowerButtonWidgetState extends State<PowerButtonWidget> {
  late PowerButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PowerButtonModel());
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
      child: Container(
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: widget.isOnline
              ? FlutterFlowTheme.of(context).primary
              : Color(0x00000000),
          borderRadius: BorderRadius.circular(40.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).primary,
          ),
        ),
        child: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 40.0,
          borderWidth: 0.0,
          buttonSize: 40.0,
          fillColor: Colors.transparent,
          icon: Icon(
            Icons.power_settings_new,
            color: widget.isOnline
                ? FlutterFlowTheme.of(context).secondaryBackground
                : FlutterFlowTheme.of(context).primary,
            size: 28.0,
          ),
          onPressed: () async {
            HapticFeedback.lightImpact();
            await widget.action?.call();
          },
        ),
      ),
    );
  }
}
