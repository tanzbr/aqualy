import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/custom_app_bar/custom_app_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'medidor_settings_page_widget.dart' show MedidorSettingsPageWidget;
import 'package:flutter/material.dart';

class MedidorSettingsPageModel
    extends FlutterFlowModel<MedidorSettingsPageWidget> {
  ///  Local state fields for this page.

  ProfileTypeStruct? selectedProfile;
  void updateSelectedProfileStruct(Function(ProfileTypeStruct) updateFn) {
    updateFn(selectedProfile ??= ProfileTypeStruct());
  }

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for customAppBar component.
  late CustomAppBarModel customAppBarModel;
  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  String? _nameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Por favor, digite seu nome.';
    }

    return null;
  }

  // State field(s) for localizacao widget.
  FocusNode? localizacaoFocusNode;
  TextEditingController? localizacaoTextController;
  String? Function(BuildContext, String?)? localizacaoTextControllerValidator;
  // State field(s) for limite widget.
  FocusNode? limiteFocusNode;
  TextEditingController? limiteTextController;
  String? Function(BuildContext, String?)? limiteTextControllerValidator;
  // State field(s) for interromper widget.
  bool? interromperValue;
  // Stores action output result for [Backend Call - API (updateMedidor)] action in Button widget.
  ApiCallResponse? updateResult;

  @override
  void initState(BuildContext context) {
    customAppBarModel = createModel(context, () => CustomAppBarModel());
    nameTextControllerValidator = _nameTextControllerValidator;
  }

  @override
  void dispose() {
    customAppBarModel.dispose();
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    localizacaoFocusNode?.dispose();
    localizacaoTextController?.dispose();

    limiteFocusNode?.dispose();
    limiteTextController?.dispose();
  }
}
