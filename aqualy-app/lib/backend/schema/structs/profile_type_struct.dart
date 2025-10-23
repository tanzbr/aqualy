// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ProfileTypeStruct extends FFFirebaseStruct {
  ProfileTypeStruct({
    int? id,
    String? name,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _name = name,
        super(firestoreUtilData);

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  static ProfileTypeStruct fromMap(Map<String, dynamic> data) =>
      ProfileTypeStruct(
        id: castToType<int>(data['id']),
        name: data['name'] as String?,
      );

  static ProfileTypeStruct? maybeFromMap(dynamic data) => data is Map
      ? ProfileTypeStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'name': _name,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
      }.withoutNulls;

  static ProfileTypeStruct fromSerializableMap(Map<String, dynamic> data) =>
      ProfileTypeStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ProfileTypeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ProfileTypeStruct && id == other.id && name == other.name;
  }

  @override
  int get hashCode => const ListEquality().hash([id, name]);
}

ProfileTypeStruct createProfileTypeStruct({
  int? id,
  String? name,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ProfileTypeStruct(
      id: id,
      name: name,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ProfileTypeStruct? updateProfileTypeStruct(
  ProfileTypeStruct? profileType, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    profileType
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addProfileTypeStructData(
  Map<String, dynamic> firestoreData,
  ProfileTypeStruct? profileType,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (profileType == null) {
    return;
  }
  if (profileType.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && profileType.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final profileTypeData =
      getProfileTypeFirestoreData(profileType, forFieldValue);
  final nestedData =
      profileTypeData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = profileType.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getProfileTypeFirestoreData(
  ProfileTypeStruct? profileType, [
  bool forFieldValue = false,
]) {
  if (profileType == null) {
    return {};
  }
  final firestoreData = mapToFirestore(profileType.toMap());

  // Add any Firestore field values
  profileType.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getProfileTypeListFirestoreData(
  List<ProfileTypeStruct>? profileTypes,
) =>
    profileTypes?.map((e) => getProfileTypeFirestoreData(e, true)).toList() ??
    [];
