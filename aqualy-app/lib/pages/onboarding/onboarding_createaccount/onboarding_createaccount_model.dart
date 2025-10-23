import '/backend/api_requests/api_calls.dart';
import '/components/custom_app_bar/custom_app_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'onboarding_createaccount_widget.dart'
    show OnboardingCreateaccountWidget;
import 'package:flutter/material.dart';

class OnboardingCreateaccountModel
    extends FlutterFlowModel<OnboardingCreateaccountWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for customAppBar component.
  late CustomAppBarModel customAppBarModel;
  // State field(s) for fullName widget.
  FocusNode? fullNameFocusNode;
  TextEditingController? fullNameTextController;
  String? Function(BuildContext, String?)? fullNameTextControllerValidator;
  String? _fullNameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Por favor, digite seu nome.';
    }

    return null;
  }

  // State field(s) for emailAddress widget.
  FocusNode? emailAddressFocusNode;
  TextEditingController? emailAddressTextController;
  String? Function(BuildContext, String?)? emailAddressTextControllerValidator;
  String? _emailAddressTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Por favor, digite seu email.';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Has to be a valid email address.';
    }
    return null;
  }

  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordTextController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordTextControllerValidator;
  String? _passwordTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Por favor, digite sua senha.';
    }

    return null;
  }

  // Stores action output result for [Backend Call - API (register)] action in Button widget.
  ApiCallResponse? cadastroResult;

  @override
  void initState(BuildContext context) {
    customAppBarModel = createModel(context, () => CustomAppBarModel());
    fullNameTextControllerValidator = _fullNameTextControllerValidator;
    emailAddressTextControllerValidator = _emailAddressTextControllerValidator;
    passwordVisibility = false;
    passwordTextControllerValidator = _passwordTextControllerValidator;
  }

  @override
  void dispose() {
    customAppBarModel.dispose();
    fullNameFocusNode?.dispose();
    fullNameTextController?.dispose();

    emailAddressFocusNode?.dispose();
    emailAddressTextController?.dispose();

    passwordFocusNode?.dispose();
    passwordTextController?.dispose();
  }
}
