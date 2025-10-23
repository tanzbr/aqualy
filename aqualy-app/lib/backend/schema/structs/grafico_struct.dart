// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GraficoStruct extends FFFirebaseStruct {
  GraficoStruct({
    List<String>? intervalos,
    List<double>? valores,
    String? metric,
    String? unidade,
    String? granularidade,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _intervalos = intervalos,
        _valores = valores,
        _metric = metric,
        _unidade = unidade,
        _granularidade = granularidade,
        super(firestoreUtilData);

  // "intervalos" field.
  List<String>? _intervalos;
  List<String> get intervalos => _intervalos ?? const [];
  set intervalos(List<String>? val) => _intervalos = val;

  void updateIntervalos(Function(List<String>) updateFn) {
    updateFn(_intervalos ??= []);
  }

  bool hasIntervalos() => _intervalos != null;

  // "valores" field.
  List<double>? _valores;
  List<double> get valores => _valores ?? const [];
  set valores(List<double>? val) => _valores = val;

  void updateValores(Function(List<double>) updateFn) {
    updateFn(_valores ??= []);
  }

  bool hasValores() => _valores != null;

  // "metric" field.
  String? _metric;
  String get metric => _metric ?? '';
  set metric(String? val) => _metric = val;

  bool hasMetric() => _metric != null;

  // "unidade" field.
  String? _unidade;
  String get unidade => _unidade ?? '';
  set unidade(String? val) => _unidade = val;

  bool hasUnidade() => _unidade != null;

  // "granularidade" field.
  String? _granularidade;
  String get granularidade => _granularidade ?? '';
  set granularidade(String? val) => _granularidade = val;

  bool hasGranularidade() => _granularidade != null;

  static GraficoStruct fromMap(Map<String, dynamic> data) => GraficoStruct(
        intervalos: getDataList(data['intervalos']),
        valores: getDataList(data['valores']),
        metric: data['metric'] as String?,
        unidade: data['unidade'] as String?,
        granularidade: data['granularidade'] as String?,
      );

  static GraficoStruct? maybeFromMap(dynamic data) =>
      data is Map ? GraficoStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'intervalos': _intervalos,
        'valores': _valores,
        'metric': _metric,
        'unidade': _unidade,
        'granularidade': _granularidade,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'intervalos': serializeParam(
          _intervalos,
          ParamType.String,
          isList: true,
        ),
        'valores': serializeParam(
          _valores,
          ParamType.double,
          isList: true,
        ),
        'metric': serializeParam(
          _metric,
          ParamType.String,
        ),
        'unidade': serializeParam(
          _unidade,
          ParamType.String,
        ),
        'granularidade': serializeParam(
          _granularidade,
          ParamType.String,
        ),
      }.withoutNulls;

  static GraficoStruct fromSerializableMap(Map<String, dynamic> data) =>
      GraficoStruct(
        intervalos: deserializeParam<String>(
          data['intervalos'],
          ParamType.String,
          true,
        ),
        valores: deserializeParam<double>(
          data['valores'],
          ParamType.double,
          true,
        ),
        metric: deserializeParam(
          data['metric'],
          ParamType.String,
          false,
        ),
        unidade: deserializeParam(
          data['unidade'],
          ParamType.String,
          false,
        ),
        granularidade: deserializeParam(
          data['granularidade'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'GraficoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is GraficoStruct &&
        listEquality.equals(intervalos, other.intervalos) &&
        listEquality.equals(valores, other.valores) &&
        metric == other.metric &&
        unidade == other.unidade &&
        granularidade == other.granularidade;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([intervalos, valores, metric, unidade, granularidade]);
}

GraficoStruct createGraficoStruct({
  String? metric,
  String? unidade,
  String? granularidade,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    GraficoStruct(
      metric: metric,
      unidade: unidade,
      granularidade: granularidade,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

GraficoStruct? updateGraficoStruct(
  GraficoStruct? grafico, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    grafico
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addGraficoStructData(
  Map<String, dynamic> firestoreData,
  GraficoStruct? grafico,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (grafico == null) {
    return;
  }
  if (grafico.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && grafico.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final graficoData = getGraficoFirestoreData(grafico, forFieldValue);
  final nestedData = graficoData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = grafico.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getGraficoFirestoreData(
  GraficoStruct? grafico, [
  bool forFieldValue = false,
]) {
  if (grafico == null) {
    return {};
  }
  final firestoreData = mapToFirestore(grafico.toMap());

  // Add any Firestore field values
  grafico.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getGraficoListFirestoreData(
  List<GraficoStruct>? graficos,
) =>
    graficos?.map((e) => getGraficoFirestoreData(e, true)).toList() ?? [];
