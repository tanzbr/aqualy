import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'realtime_cards_widget.dart' show RealtimeCardsWidget;
import 'package:flutter/material.dart';

class RealtimeCardsModel extends FlutterFlowModel<RealtimeCardsWidget> {
  ///  Local state fields for this component.

  double? consumo = 0.0;

  double? vazao = 0.0;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (getRealTime)] action in realtimeCards widget.
  ApiCallResponse? dataResult;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
