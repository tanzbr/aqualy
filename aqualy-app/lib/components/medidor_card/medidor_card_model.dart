import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/power_button/power_button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'medidor_card_widget.dart' show MedidorCardWidget;
import 'package:flutter/material.dart';

class MedidorCardModel extends FlutterFlowModel<MedidorCardWidget> {
  ///  Local state fields for this component.

  MedidorStruct? medidor;
  void updateMedidorStruct(Function(MedidorStruct) updateFn) {
    updateFn(medidor ??= MedidorStruct());
  }

  ///  State fields for stateful widgets in this component.

  // Model for powerButton component.
  late PowerButtonModel powerButtonModel;

  @override
  void initState(BuildContext context) {
    powerButtonModel = createModel(context, () => PowerButtonModel());
  }

  @override
  void dispose() {
    powerButtonModel.dispose();
  }
}
