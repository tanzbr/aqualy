import '/components/header/header_widget.dart';
import '/components/interval_item_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'stats_page_widget.dart' show StatsPageWidget;
import 'package:flutter/material.dart';

class StatsPageModel extends FlutterFlowModel<StatsPageWidget> {
  ///  Local state fields for this page.

  DateTime? startDate;

  DateTime? endDate;

  ///  State fields for stateful widgets in this page.

  // Model for header component.
  late HeaderModel headerModel;
  // Models for intervalItem dynamic component.
  late FlutterFlowDynamicModels<IntervalItemModel> intervalItemModels;

  @override
  void initState(BuildContext context) {
    headerModel = createModel(context, () => HeaderModel());
    intervalItemModels = FlutterFlowDynamicModels(() => IntervalItemModel());
  }

  @override
  void dispose() {
    headerModel.dispose();
    intervalItemModels.dispose();
  }
}
