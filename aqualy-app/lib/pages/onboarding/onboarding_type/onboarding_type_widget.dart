import '/components/custom_app_bar/custom_app_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/profile_type/profile_type_widget.dart';
import '/index.dart';
import 'package:custom_date_range_picker_wcsgof/app_state.dart'
    as custom_date_range_picker_wcsgof_app_state;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'onboarding_type_model.dart';
export 'onboarding_type_model.dart';

class OnboardingTypeWidget extends StatefulWidget {
  const OnboardingTypeWidget({super.key});

  static String routeName = 'onboarding_type';
  static String routePath = '/onboardingType';

  @override
  State<OnboardingTypeWidget> createState() => _OnboardingTypeWidgetState();
}

class _OnboardingTypeWidgetState extends State<OnboardingTypeWidget> {
  late OnboardingTypeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OnboardingTypeModel());
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
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        wrapWithModel(
                          model: _model.customAppBarModel,
                          updateCallback: () => safeSetState(() {}),
                          child: CustomAppBarWidget(),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 24.0, 0.0, 0.0),
                              child: Text(
                                'Selecione seu perfil',
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
                                  0.0, 10.0, 0.0, 0.0),
                              child: Builder(
                                builder: (context) {
                                  final profile =
                                      FFAppState().profileTypes.toList();

                                  return Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: List.generate(profile.length,
                                        (profileIndex) {
                                      final profileItem = profile[profileIndex];
                                      return wrapWithModel(
                                        model:
                                            _model.profileTypeModels.getModel(
                                          profileIndex.toString(),
                                          profileIndex,
                                        ),
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: ProfileTypeWidget(
                                          key: Key(
                                            'Keymvd_${profileIndex.toString()}',
                                          ),
                                          selectedProfile:
                                              _model.selectedProfile != null
                                                  ? _model.selectedProfile!
                                                  : FFAppState()
                                                      .profileTypes
                                                      .firstOrNull!,
                                          profileType: profileItem,
                                          action: () async {
                                            _model.selectedProfile =
                                                profileItem;
                                            safeSetState(() {});
                                          },
                                        ),
                                      );
                                    }).divide(SizedBox(height: 8.0)),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 12.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    context.pushNamed(HomePageWidget.routeName);
                  },
                  text: 'Continuar',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 50.0,
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          font: GoogleFonts.interTight(
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).alternate,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleSmall
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                    elevation: 0.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
