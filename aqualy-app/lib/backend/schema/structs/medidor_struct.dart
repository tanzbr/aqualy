// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class MedidorStruct extends FFFirebaseStruct {
  MedidorStruct({
    int? id,
    String? nome,
    String? localizacao,
    double? limite,
    int? usuarioId,
    String? usuarioNome,
    bool? ligado,
    bool? interromper,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _nome = nome,
        _localizacao = localizacao,
        _limite = limite,
        _usuarioId = usuarioId,
        _usuarioNome = usuarioNome,
        _ligado = ligado,
        _interromper = interromper,
        super(firestoreUtilData);

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "nome" field.
  String? _nome;
  String get nome => _nome ?? '';
  set nome(String? val) => _nome = val;

  bool hasNome() => _nome != null;

  // "localizacao" field.
  String? _localizacao;
  String get localizacao => _localizacao ?? '';
  set localizacao(String? val) => _localizacao = val;

  bool hasLocalizacao() => _localizacao != null;

  // "limite" field.
  double? _limite;
  double get limite => _limite ?? 0.0;
  set limite(double? val) => _limite = val;

  void incrementLimite(double amount) => limite = limite + amount;

  bool hasLimite() => _limite != null;

  // "usuarioId" field.
  int? _usuarioId;
  int get usuarioId => _usuarioId ?? 0;
  set usuarioId(int? val) => _usuarioId = val;

  void incrementUsuarioId(int amount) => usuarioId = usuarioId + amount;

  bool hasUsuarioId() => _usuarioId != null;

  // "usuarioNome" field.
  String? _usuarioNome;
  String get usuarioNome => _usuarioNome ?? '';
  set usuarioNome(String? val) => _usuarioNome = val;

  bool hasUsuarioNome() => _usuarioNome != null;

  // "ligado" field.
  bool? _ligado;
  bool get ligado => _ligado ?? false;
  set ligado(bool? val) => _ligado = val;

  bool hasLigado() => _ligado != null;

  // "interromper" field.
  bool? _interromper;
  bool get interromper => _interromper ?? false;
  set interromper(bool? val) => _interromper = val;

  bool hasInterromper() => _interromper != null;

  static MedidorStruct fromMap(Map<String, dynamic> data) => MedidorStruct(
        id: castToType<int>(data['id']),
        nome: data['nome'] as String?,
        localizacao: data['localizacao'] as String?,
        limite: castToType<double>(data['limite']),
        usuarioId: castToType<int>(data['usuarioId']),
        usuarioNome: data['usuarioNome'] as String?,
        ligado: data['ligado'] as bool?,
        interromper: data['interromper'] as bool?,
      );

  static MedidorStruct? maybeFromMap(dynamic data) =>
      data is Map ? MedidorStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'nome': _nome,
        'localizacao': _localizacao,
        'limite': _limite,
        'usuarioId': _usuarioId,
        'usuarioNome': _usuarioNome,
        'ligado': _ligado,
        'interromper': _interromper,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'nome': serializeParam(
          _nome,
          ParamType.String,
        ),
        'localizacao': serializeParam(
          _localizacao,
          ParamType.String,
        ),
        'limite': serializeParam(
          _limite,
          ParamType.double,
        ),
        'usuarioId': serializeParam(
          _usuarioId,
          ParamType.int,
        ),
        'usuarioNome': serializeParam(
          _usuarioNome,
          ParamType.String,
        ),
        'ligado': serializeParam(
          _ligado,
          ParamType.bool,
        ),
        'interromper': serializeParam(
          _interromper,
          ParamType.bool,
        ),
      }.withoutNulls;

  static MedidorStruct fromSerializableMap(Map<String, dynamic> data) =>
      MedidorStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        nome: deserializeParam(
          data['nome'],
          ParamType.String,
          false,
        ),
        localizacao: deserializeParam(
          data['localizacao'],
          ParamType.String,
          false,
        ),
        limite: deserializeParam(
          data['limite'],
          ParamType.double,
          false,
        ),
        usuarioId: deserializeParam(
          data['usuarioId'],
          ParamType.int,
          false,
        ),
        usuarioNome: deserializeParam(
          data['usuarioNome'],
          ParamType.String,
          false,
        ),
        ligado: deserializeParam(
          data['ligado'],
          ParamType.bool,
          false,
        ),
        interromper: deserializeParam(
          data['interromper'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'MedidorStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MedidorStruct &&
        id == other.id &&
        nome == other.nome &&
        localizacao == other.localizacao &&
        limite == other.limite &&
        usuarioId == other.usuarioId &&
        usuarioNome == other.usuarioNome &&
        ligado == other.ligado &&
        interromper == other.interromper;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        nome,
        localizacao,
        limite,
        usuarioId,
        usuarioNome,
        ligado,
        interromper
      ]);
}

MedidorStruct createMedidorStruct({
  int? id,
  String? nome,
  String? localizacao,
  double? limite,
  int? usuarioId,
  String? usuarioNome,
  bool? ligado,
  bool? interromper,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    MedidorStruct(
      id: id,
      nome: nome,
      localizacao: localizacao,
      limite: limite,
      usuarioId: usuarioId,
      usuarioNome: usuarioNome,
      ligado: ligado,
      interromper: interromper,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

MedidorStruct? updateMedidorStruct(
  MedidorStruct? medidor, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    medidor
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addMedidorStructData(
  Map<String, dynamic> firestoreData,
  MedidorStruct? medidor,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (medidor == null) {
    return;
  }
  if (medidor.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && medidor.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final medidorData = getMedidorFirestoreData(medidor, forFieldValue);
  final nestedData = medidorData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = medidor.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getMedidorFirestoreData(
  MedidorStruct? medidor, [
  bool forFieldValue = false,
]) {
  if (medidor == null) {
    return {};
  }
  final firestoreData = mapToFirestore(medidor.toMap());

  // Add any Firestore field values
  medidor.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getMedidorListFirestoreData(
  List<MedidorStruct>? medidors,
) =>
    medidors?.map((e) => getMedidorFirestoreData(e, true)).toList() ?? [];
