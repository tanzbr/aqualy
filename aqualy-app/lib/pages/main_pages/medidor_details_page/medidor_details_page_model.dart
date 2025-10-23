import '/components/custom_app_bar/custom_app_bar_widget.dart';
import '/components/interval_item_widget.dart';
import '/components/power_button_small/power_button_small_widget.dart';
import '/components/realtime_cards/realtime_cards_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'medidor_details_page_widget.dart' show MedidorDetailsPageWidget;
import 'package:flutter/material.dart';

class MedidorDetailsPageModel
    extends FlutterFlowModel<MedidorDetailsPageWidget> {
  ///  Local state fields for this page.

  DateTime? startDate;

  DateTime? endDate;

  ///  State fields for stateful widgets in this page.

  // Model for customAppBar component.
  late CustomAppBarModel customAppBarModel;
  // Model for powerButtonSmall component.
  late PowerButtonSmallModel powerButtonSmallModel;
  // Model for realtimeCards component.
  late RealtimeCardsModel realtimeCardsModel;
  // Models for intervalItem dynamic component.
  late FlutterFlowDynamicModels<IntervalItemModel> intervalItemModels;

  @override
  void initState(BuildContext context) {
    customAppBarModel = createModel(context, () => CustomAppBarModel());
    powerButtonSmallModel = createModel(context, () => PowerButtonSmallModel());
    realtimeCardsModel = createModel(context, () => RealtimeCardsModel());
    intervalItemModels = FlutterFlowDynamicModels(() => IntervalItemModel());
  }

  @override
  void dispose() {
    customAppBarModel.dispose();
    powerButtonSmallModel.dispose();
    realtimeCardsModel.dispose();
    intervalItemModels.dispose();
  }
}
