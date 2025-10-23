// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SugestaoIAStruct extends FFFirebaseStruct {
  SugestaoIAStruct({
    int? medidorId,
    String? observacoes,
    List<SugestaoIaItemStruct>? sugestoes,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _medidorId = medidorId,
        _observacoes = observacoes,
        _sugestoes = sugestoes,
        super(firestoreUtilData);

  // "medidorId" field.
  int? _medidorId;
  int get medidorId => _medidorId ?? 0;
  set medidorId(int? val) => _medidorId = val;

  void incrementMedidorId(int amount) => medidorId = medidorId + amount;

  bool hasMedidorId() => _medidorId != null;

  // "observacoes" field.
  String? _observacoes;
  String get observacoes => _observacoes ?? '';
  set observacoes(String? val) => _observacoes = val;

  bool hasObservacoes() => _observacoes != null;

  // "sugestoes" field.
  List<SugestaoIaItemStruct>? _sugestoes;
  List<SugestaoIaItemStruct> get sugestoes => _sugestoes ?? const [];
  set sugestoes(List<SugestaoIaItemStruct>? val) => _sugestoes = val;

  void updateSugestoes(Function(List<SugestaoIaItemStruct>) updateFn) {
    updateFn(_sugestoes ??= []);
  }

  bool hasSugestoes() => _sugestoes != null;

  static SugestaoIAStruct fromMap(Map<String, dynamic> data) =>
      SugestaoIAStruct(
        medidorId: castToType<int>(data['medidorId']),
        observacoes: data['observacoes'] as String?,
        sugestoes: getStructList(
          data['sugestoes'],
          SugestaoIaItemStruct.fromMap,
        ),
      );

  static SugestaoIAStruct? maybeFromMap(dynamic data) => data is Map
      ? SugestaoIAStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'medidorId': _medidorId,
        'observacoes': _observacoes,
        'sugestoes': _sugestoes?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'medidorId': serializeParam(
          _medidorId,
          ParamType.int,
        ),
        'observacoes': serializeParam(
          _observacoes,
          ParamType.String,
        ),
        'sugestoes': serializeParam(
          _sugestoes,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static SugestaoIAStruct fromSerializableMap(Map<String, dynamic> data) =>
      SugestaoIAStruct(
        medidorId: deserializeParam(
          data['medidorId'],
          ParamType.int,
          false,
        ),
        observacoes: deserializeParam(
          data['observacoes'],
          ParamType.String,
          false,
        ),
        sugestoes: deserializeStructParam<SugestaoIaItemStruct>(
          data['sugestoes'],
          ParamType.DataStruct,
          true,
          structBuilder: SugestaoIaItemStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'SugestaoIAStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is SugestaoIAStruct &&
        medidorId == other.medidorId &&
        observacoes == other.observacoes &&
        listEquality.equals(sugestoes, other.sugestoes);
  }

  @override
  int get hashCode =>
      const ListEquality().hash([medidorId, observacoes, sugestoes]);
}

SugestaoIAStruct createSugestaoIAStruct({
  int? medidorId,
  String? observacoes,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SugestaoIAStruct(
      medidorId: medidorId,
      observacoes: observacoes,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SugestaoIAStruct? updateSugestaoIAStruct(
  SugestaoIAStruct? sugestaoIA, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    sugestaoIA
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSugestaoIAStructData(
  Map<String, dynamic> firestoreData,
  SugestaoIAStruct? sugestaoIA,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (sugestaoIA == null) {
    return;
  }
  if (sugestaoIA.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && sugestaoIA.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final sugestaoIAData = getSugestaoIAFirestoreData(sugestaoIA, forFieldValue);
  final nestedData = sugestaoIAData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = sugestaoIA.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSugestaoIAFirestoreData(
  SugestaoIAStruct? sugestaoIA, [
  bool forFieldValue = false,
]) {
  if (sugestaoIA == null) {
    return {};
  }
  final firestoreData = mapToFirestore(sugestaoIA.toMap());

  // Add any Firestore field values
  sugestaoIA.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSugestaoIAListFirestoreData(
  List<SugestaoIAStruct>? sugestaoIAs,
) =>
    sugestaoIAs?.map((e) => getSugestaoIAFirestoreData(e, true)).toList() ?? [];
