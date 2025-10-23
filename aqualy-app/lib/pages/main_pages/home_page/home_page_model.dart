import '/backend/api_requests/api_calls.dart';
import '/components/cards/cards_widget.dart';
import '/components/header/header_widget.dart';
import '/components/medidor_card/medidor_card_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'dart:async';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (medidoresByUser)] action in HomePage widget.
  ApiCallResponse? medidoresResult;
  // Model for header component.
  late HeaderModel headerModel;
  // Model for cards component.
  late CardsModel cardsModel;
  Completer<ApiCallResponse>? apiRequestCompleter;
  // Models for medidorCard dynamic component.
  late FlutterFlowDynamicModels<MedidorCardModel> medidorCardModels;

  @override
  void initState(BuildContext context) {
    headerModel = createModel(context, () => HeaderModel());
    cardsModel = createModel(context, () => CardsModel());
    medidorCardModels = FlutterFlowDynamicModels(() => MedidorCardModel());
  }

  @override
  void dispose() {
    headerModel.dispose();
    cardsModel.dispose();
    medidorCardModels.dispose();
  }

  /// Additional helper methods.
  Future waitForApiRequestCompleted({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
