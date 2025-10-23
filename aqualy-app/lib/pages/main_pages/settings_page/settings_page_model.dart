import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/custom_app_bar/custom_app_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'settings_page_widget.dart' show SettingsPageWidget;
import 'package:flutter/material.dart';

class SettingsPageModel extends FlutterFlowModel<SettingsPageWidget> {
  ///  Local state fields for this page.

  ProfileTypeStruct? selectedProfile;
  void updateSelectedProfileStruct(Function(ProfileTypeStruct) updateFn) {
    updateFn(selectedProfile ??= ProfileTypeStruct());
  }

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for customAppBar component.
  late CustomAppBarModel customAppBarModel;
  // State field(s) for fullName widget.
  FocusNode? fullNameFocusNode1;
  TextEditingController? fullNameTextController1;
  String? Function(BuildContext, String?)? fullNameTextController1Validator;
  String? _fullNameTextController1Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Por favor, digite seu nome.';
    }

    return null;
  }

  // State field(s) for fullName widget.
  FocusNode? fullNameFocusNode2;
  TextEditingController? fullNameTextController2;
  String? Function(BuildContext, String?)? fullNameTextController2Validator;
  // State field(s) for password widget.
  FocusNode? passwordFocusNode1;
  TextEditingController? passwordTextController1;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordTextController1Validator;
  String? _passwordTextController1Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Por favor, digite sua senha.';
    }

    return null;
  }

  // State field(s) for password widget.
  FocusNode? passwordFocusNode2;
  TextEditingController? passwordTextController2;
  String? Function(BuildContext, String?)? passwordTextController2Validator;
  // Stores action output result for [Backend Call - API (updateUser)] action in Button widget.
  ApiCallResponse? updateResult;

  @override
  void initState(BuildContext context) {
    customAppBarModel = createModel(context, () => CustomAppBarModel());
    fullNameTextController1Validator = _fullNameTextController1Validator;
    passwordVisibility = false;
    passwordTextController1Validator = _passwordTextController1Validator;
  }

  @override
  void dispose() {
    customAppBarModel.dispose();
    fullNameFocusNode1?.dispose();
    fullNameTextController1?.dispose();

    fullNameFocusNode2?.dispose();
    fullNameTextController2?.dispose();

    passwordFocusNode1?.dispose();
    passwordTextController1?.dispose();

    passwordFocusNode2?.dispose();
    passwordTextController2?.dispose();
  }
}
