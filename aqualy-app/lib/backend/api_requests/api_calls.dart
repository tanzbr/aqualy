import 'dart:convert';
import '../schema/structs/index.dart';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_commons/api_requests/api_manager.dart';


export 'package:ff_commons/api_requests/api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start backend Group Code

class BackendGroup {
  static String getBaseUrl() => 'https://aqualy.tanz.dev';
  static Map<String, String> headers = {};
  static RegisterCall registerCall = RegisterCall();
  static LoginCall loginCall = LoginCall();
  static UpdateUserCall updateUserCall = UpdateUserCall();
  static MedidoresByUserCall medidoresByUserCall = MedidoresByUserCall();
  static MedidorByIdCall medidorByIdCall = MedidorByIdCall();
  static UpdateMedidorCall updateMedidorCall = UpdateMedidorCall();
  static GetEstatisticaMensalCall getEstatisticaMensalCall =
      GetEstatisticaMensalCall();
  static GetRealTimeCall getRealTimeCall = GetRealTimeCall();
  static GetGraficoByUsuarioCall getGraficoByUsuarioCall =
      GetGraficoByUsuarioCall();
  static ToggleMedidorCall toggleMedidorCall = ToggleMedidorCall();
  static GetGraficoByMedidorCall getGraficoByMedidorCall =
      GetGraficoByMedidorCall();
  static GetRecommendationsCall getRecommendationsCall =
      GetRecommendationsCall();
}

class RegisterCall {
  Future<ApiCallResponse> call({
    String? nome = '',
    String? email = '',
    String? senha = '',
  }) async {
    final baseUrl = BackendGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "nome": "${escapeStringForJson(nome)}",
  "email": "${escapeStringForJson(email)}",
  "senha": "${escapeStringForJson(senha)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'register',
      apiUrl: '${baseUrl}/auth/registro',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class LoginCall {
  Future<ApiCallResponse> call({
    String? email = '',
    String? password = '',
  }) async {
    final baseUrl = BackendGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "email": "${escapeStringForJson(email)}",
  "senha": "${escapeStringForJson(password)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'login',
      apiUrl: '${baseUrl}/auth/login',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  UserStruct? usuario(dynamic response) => UserStruct.maybeFromMap(getJsonField(
        response,
        r'''$.usuario''',
      ));
}

class UpdateUserCall {
  Future<ApiCallResponse> call({
    int? id,
    String? nome = '',
    String? senha = '',
    double? valorM,
    String? email = '',
  }) async {
    final baseUrl = BackendGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "nome": "${escapeStringForJson(nome)}",
  "senha": "${escapeStringForJson(senha)}",
  "valorM": ${valorM},
  "email": "${escapeStringForJson(email)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'updateUser',
      apiUrl: '${baseUrl}/usuarios/${id}',
      callType: ApiCallType.PUT,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class MedidoresByUserCall {
  Future<ApiCallResponse> call({
    int? id,
  }) async {
    final baseUrl = BackendGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'medidoresByUser',
      apiUrl: '${baseUrl}/medidores/usuario/${id}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class MedidorByIdCall {
  Future<ApiCallResponse> call({
    int? id,
  }) async {
    final baseUrl = BackendGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'medidorById',
      apiUrl: '${baseUrl}/medidores/${id}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateMedidorCall {
  Future<ApiCallResponse> call({
    int? id,
    String? nome = '',
    String? localizacao = '',
    double? limite,
    int? usuarioId,
    bool? interromper,
  }) async {
    final baseUrl = BackendGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "nome": "${escapeStringForJson(nome)}",
  "localizacao": "${escapeStringForJson(localizacao)}",
  "limite": ${limite},
  "usuarioId": ${usuarioId},
  "interromper": ${interromper}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'updateMedidor',
      apiUrl: '${baseUrl}/medidores/${id}',
      callType: ApiCallType.PUT,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetEstatisticaMensalCall {
  Future<ApiCallResponse> call({
    int? id,
  }) async {
    final baseUrl = BackendGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getEstatisticaMensal',
      apiUrl: '${baseUrl}/estatisticas/usuario/${id}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  double? litrosAcumulados(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$.litrosAcumulado''',
      ));
  double? gastoMes(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$.gastoMes''',
      ));
  double? economiaMes(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$.economiaMes''',
      ));
}

class GetRealTimeCall {
  Future<ApiCallResponse> call({
    int? id,
  }) async {
    final baseUrl = BackendGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getRealTime',
      apiUrl: '${baseUrl}/leituras/tempo-real/medidor/${id}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  double? consumoLitros(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$.consumoLitros''',
      ));
  double? vazaoLMin(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$.vazaoLMin''',
      ));
  bool? ligado(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.ligado''',
      ));
}

class GetGraficoByUsuarioCall {
  Future<ApiCallResponse> call({
    int? id,
    String? metric = '',
    String? dataInicio = '',
    String? dataFim = '',
  }) async {
    final baseUrl = BackendGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getGraficoByUsuario',
      apiUrl: '${baseUrl}/estatisticas/grafico/usuario/${id}',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'metric': metric,
        'dataInicio': dataInicio,
        'dataFim': dataFim,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ToggleMedidorCall {
  Future<ApiCallResponse> call({
    int? id,
  }) async {
    final baseUrl = BackendGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'toggleMedidor',
      apiUrl: '${baseUrl}/medidores/${id}/power/toggle',
      callType: ApiCallType.PUT,
      headers: {},
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetGraficoByMedidorCall {
  Future<ApiCallResponse> call({
    int? id,
    String? metric = '',
    String? dataInicio = '',
    String? dataFim = '',
  }) async {
    final baseUrl = BackendGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getGraficoByMedidor',
      apiUrl: '${baseUrl}/estatisticas/grafico/medidor/${id}',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'metric': metric,
        'dataInicio': dataInicio,
        'dataFim': dataFim,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetRecommendationsCall {
  Future<ApiCallResponse> call({
    int? id,
    String? dataInicio = '',
    String? dataFim = '',
  }) async {
    final baseUrl = BackendGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getRecommendations',
      apiUrl: '${baseUrl}/sugestoes/medidor/${id}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End backend Group Code

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
