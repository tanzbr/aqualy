// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class SugestaoIaItemStruct extends FFFirebaseStruct {
  SugestaoIaItemStruct({
    String? titulo,
    String? descricao,
    double? economiaReais,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _titulo = titulo,
        _descricao = descricao,
        _economiaReais = economiaReais,
        super(firestoreUtilData);

  // "titulo" field.
  String? _titulo;
  String get titulo => _titulo ?? '';
  set titulo(String? val) => _titulo = val;

  bool hasTitulo() => _titulo != null;

  // "descricao" field.
  String? _descricao;
  String get descricao => _descricao ?? '';
  set descricao(String? val) => _descricao = val;

  bool hasDescricao() => _descricao != null;

  // "economiaReais" field.
  double? _economiaReais;
  double get economiaReais => _economiaReais ?? 0.0;
  set economiaReais(double? val) => _economiaReais = val;

  void incrementEconomiaReais(double amount) =>
      economiaReais = economiaReais + amount;

  bool hasEconomiaReais() => _economiaReais != null;

  static SugestaoIaItemStruct fromMap(Map<String, dynamic> data) =>
      SugestaoIaItemStruct(
        titulo: data['titulo'] as String?,
        descricao: data['descricao'] as String?,
        economiaReais: castToType<double>(data['economiaReais']),
      );

  static SugestaoIaItemStruct? maybeFromMap(dynamic data) => data is Map
      ? SugestaoIaItemStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'titulo': _titulo,
        'descricao': _descricao,
        'economiaReais': _economiaReais,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'titulo': serializeParam(
          _titulo,
          ParamType.String,
        ),
        'descricao': serializeParam(
          _descricao,
          ParamType.String,
        ),
        'economiaReais': serializeParam(
          _economiaReais,
          ParamType.double,
        ),
      }.withoutNulls;

  static SugestaoIaItemStruct fromSerializableMap(Map<String, dynamic> data) =>
      SugestaoIaItemStruct(
        titulo: deserializeParam(
          data['titulo'],
          ParamType.String,
          false,
        ),
        descricao: deserializeParam(
          data['descricao'],
          ParamType.String,
          false,
        ),
        economiaReais: deserializeParam(
          data['economiaReais'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'SugestaoIaItemStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SugestaoIaItemStruct &&
        titulo == other.titulo &&
        descricao == other.descricao &&
        economiaReais == other.economiaReais;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([titulo, descricao, economiaReais]);
}

SugestaoIaItemStruct createSugestaoIaItemStruct({
  String? titulo,
  String? descricao,
  double? economiaReais,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SugestaoIaItemStruct(
      titulo: titulo,
      descricao: descricao,
      economiaReais: economiaReais,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SugestaoIaItemStruct? updateSugestaoIaItemStruct(
  SugestaoIaItemStruct? sugestaoIaItem, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    sugestaoIaItem
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSugestaoIaItemStructData(
  Map<String, dynamic> firestoreData,
  SugestaoIaItemStruct? sugestaoIaItem,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (sugestaoIaItem == null) {
    return;
  }
  if (sugestaoIaItem.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && sugestaoIaItem.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final sugestaoIaItemData =
      getSugestaoIaItemFirestoreData(sugestaoIaItem, forFieldValue);
  final nestedData =
      sugestaoIaItemData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = sugestaoIaItem.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSugestaoIaItemFirestoreData(
  SugestaoIaItemStruct? sugestaoIaItem, [
  bool forFieldValue = false,
]) {
  if (sugestaoIaItem == null) {
    return {};
  }
  final firestoreData = mapToFirestore(sugestaoIaItem.toMap());

  // Add any Firestore field values
  sugestaoIaItem.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSugestaoIaItemListFirestoreData(
  List<SugestaoIaItemStruct>? sugestaoIaItems,
) =>
    sugestaoIaItems
        ?.map((e) => getSugestaoIaItemFirestoreData(e, true))
        .toList() ??
    [];
