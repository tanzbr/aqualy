import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/custom_app_bar/custom_app_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'add_device_widget.dart' show AddDeviceWidget;
import 'package:flutter/material.dart';

class AddDeviceModel extends FlutterFlowModel<AddDeviceWidget> {
  ///  Local state fields for this page.

  ProfileTypeStruct? selectedProfile;
  void updateSelectedProfileStruct(Function(ProfileTypeStruct) updateFn) {
    updateFn(selectedProfile ??= ProfileTypeStruct());
  }

  ///  State fields for stateful widgets in this page.

  // Model for customAppBar component.
  late CustomAppBarModel customAppBarModel;

  @override
  void initState(BuildContext context) {
    customAppBarModel = createModel(context, () => CustomAppBarModel());
  }

  @override
  void dispose() {
    customAppBarModel.dispose();
  }
}
