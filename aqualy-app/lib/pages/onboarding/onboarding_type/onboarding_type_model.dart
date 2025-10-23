import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/custom_app_bar/custom_app_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/profile_type/profile_type_widget.dart';
import '/index.dart';
import 'onboarding_type_widget.dart' show OnboardingTypeWidget;
import 'package:flutter/material.dart';

class OnboardingTypeModel extends FlutterFlowModel<OnboardingTypeWidget> {
  ///  Local state fields for this page.

  ProfileTypeStruct? selectedProfile;
  void updateSelectedProfileStruct(Function(ProfileTypeStruct) updateFn) {
    updateFn(selectedProfile ??= ProfileTypeStruct());
  }

  ///  State fields for stateful widgets in this page.

  // Model for customAppBar component.
  late CustomAppBarModel customAppBarModel;
  // Models for profileType dynamic component.
  late FlutterFlowDynamicModels<ProfileTypeModel> profileTypeModels;

  @override
  void initState(BuildContext context) {
    customAppBarModel = createModel(context, () => CustomAppBarModel());
    profileTypeModels = FlutterFlowDynamicModels(() => ProfileTypeModel());
  }

  @override
  void dispose() {
    customAppBarModel.dispose();
    profileTypeModels.dispose();
  }
}
