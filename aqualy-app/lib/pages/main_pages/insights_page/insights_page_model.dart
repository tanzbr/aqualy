import '/components/header/header_widget.dart';
import '/components/medidor_item_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/sugestao_card/sugestao_card_widget.dart';
import 'insights_page_widget.dart' show InsightsPageWidget;
import 'package:flutter/material.dart';

class InsightsPageModel extends FlutterFlowModel<InsightsPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for header component.
  late HeaderModel headerModel;
  // Models for medidorItem dynamic component.
  late FlutterFlowDynamicModels<MedidorItemModel> medidorItemModels;
  // Models for sugestaoCard dynamic component.
  late FlutterFlowDynamicModels<SugestaoCardModel> sugestaoCardModels;

  @override
  void initState(BuildContext context) {
    headerModel = createModel(context, () => HeaderModel());
    medidorItemModels = FlutterFlowDynamicModels(() => MedidorItemModel());
    sugestaoCardModels = FlutterFlowDynamicModels(() => SugestaoCardModel());
  }

  @override
  void dispose() {
    headerModel.dispose();
    medidorItemModels.dispose();
    sugestaoCardModels.dispose();
  }
}
