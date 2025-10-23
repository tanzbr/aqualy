import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_type_model.dart';
export 'profile_type_model.dart';

class ProfileTypeWidget extends StatefulWidget {
  const ProfileTypeWidget({
    super.key,
    required this.selectedProfile,
    required this.action,
    required this.profileType,
  });

  final ProfileTypeStruct? selectedProfile;
  final Future Function()? action;
  final ProfileTypeStruct? profileType;

  @override
  State<ProfileTypeWidget> createState() => _ProfileTypeWidgetState();
}

class _ProfileTypeWidgetState extends State<ProfileTypeWidget> {
  late ProfileTypeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileTypeModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        await widget.action?.call();
      },
      child: Container(
        width: double.infinity,
        height: 44.0,
        decoration: BoxDecoration(
          color: widget.selectedProfile?.id == widget.profileType?.id
              ? FlutterFlowTheme.of(context).primary
              : FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 24.0, 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                valueOrDefault<String>(
                  widget.profileType?.name,
                  'Perfil',
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      color:
                          widget.selectedProfile?.id == widget.profileType?.id
                              ? FlutterFlowTheme.of(context).primaryBackground
                              : FlutterFlowTheme.of(context).primaryText,
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
