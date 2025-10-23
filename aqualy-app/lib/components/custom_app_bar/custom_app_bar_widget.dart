import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'custom_app_bar_model.dart';
export 'custom_app_bar_model.dart';

class CustomAppBarWidget extends StatefulWidget {
  const CustomAppBarWidget({super.key});

  @override
  State<CustomAppBarWidget> createState() => _CustomAppBarWidgetState();
}

class _CustomAppBarWidgetState extends State<CustomAppBarWidget> {
  late CustomAppBarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustomAppBarModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FlutterFlowIconButton(
          borderColor: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: 24.0,
          borderWidth: 1.0,
          buttonSize: 44.0,
          fillColor: FlutterFlowTheme.of(context).secondaryBackground,
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: FlutterFlowTheme.of(context).primaryText,
            size: 18.0,
          ),
          onPressed: () async {
            context.safePop();
          },
        ),
      ],
    );
  }
}
