import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _profileTypes = prefs
              .getStringList('ff_profileTypes')
              ?.map((x) {
                try {
                  return ProfileTypeStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _profileTypes;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_loggedUser')) {
        try {
          final serializedData = prefs.getString('ff_loggedUser') ?? '{}';
          _loggedUser =
              UserStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  List<ProfileTypeStruct> _profileTypes = [
    ProfileTypeStruct.fromSerializableMap(
        jsonDecode('{\"id\":\"1\",\"name\":\"Doméstico\"}')),
    ProfileTypeStruct.fromSerializableMap(
        jsonDecode('{\"id\":\"2\",\"name\":\"Empresarial\"}')),
    ProfileTypeStruct.fromSerializableMap(
        jsonDecode('{\"id\":\"3\",\"name\":\"Indústria\"}')),
    ProfileTypeStruct.fromSerializableMap(
        jsonDecode('{\"id\":\"4\",\"name\":\"Agrícola\"}')),
    ProfileTypeStruct.fromSerializableMap(
        jsonDecode('{\"id\":\"99\",\"name\":\"Outros\"}'))
  ];
  List<ProfileTypeStruct> get profileTypes => _profileTypes;
  set profileTypes(List<ProfileTypeStruct> value) {
    _profileTypes = value;
    prefs.setStringList(
        'ff_profileTypes', value.map((x) => x.serialize()).toList());
  }

  void addToProfileTypes(ProfileTypeStruct value) {
    profileTypes.add(value);
    prefs.setStringList(
        'ff_profileTypes', _profileTypes.map((x) => x.serialize()).toList());
  }

  void removeFromProfileTypes(ProfileTypeStruct value) {
    profileTypes.remove(value);
    prefs.setStringList(
        'ff_profileTypes', _profileTypes.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromProfileTypes(int index) {
    profileTypes.removeAt(index);
    prefs.setStringList(
        'ff_profileTypes', _profileTypes.map((x) => x.serialize()).toList());
  }

  void updateProfileTypesAtIndex(
    int index,
    ProfileTypeStruct Function(ProfileTypeStruct) updateFn,
  ) {
    profileTypes[index] = updateFn(_profileTypes[index]);
    prefs.setStringList(
        'ff_profileTypes', _profileTypes.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInProfileTypes(int index, ProfileTypeStruct value) {
    profileTypes.insert(index, value);
    prefs.setStringList(
        'ff_profileTypes', _profileTypes.map((x) => x.serialize()).toList());
  }

  UserStruct _loggedUser = UserStruct();
  UserStruct get loggedUser => _loggedUser;
  set loggedUser(UserStruct value) {
    _loggedUser = value;
    prefs.setString('ff_loggedUser', value.serialize());
  }

  void updateLoggedUserStruct(Function(UserStruct) updateFn) {
    updateFn(_loggedUser);
    prefs.setString('ff_loggedUser', _loggedUser.serialize());
  }

  List<String> _intervalos = ['7 dias', '14 dias', '30 dias', '90 dias'];
  List<String> get intervalos => _intervalos;
  set intervalos(List<String> value) {
    _intervalos = value;
  }

  void addToIntervalos(String value) {
    intervalos.add(value);
  }

  void removeFromIntervalos(String value) {
    intervalos.remove(value);
  }

  void removeAtIndexFromIntervalos(int index) {
    intervalos.removeAt(index);
  }

  void updateIntervalosAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    intervalos[index] = updateFn(_intervalos[index]);
  }

  void insertAtIndexInIntervalos(int index, String value) {
    intervalos.insert(index, value);
  }

  String _selectedInterval = '7 dias';
  String get selectedInterval => _selectedInterval;
  set selectedInterval(String value) {
    _selectedInterval = value;
  }

  MedidorStruct _insightSelectedMedidor = MedidorStruct();
  MedidorStruct get insightSelectedMedidor => _insightSelectedMedidor;
  set insightSelectedMedidor(MedidorStruct value) {
    _insightSelectedMedidor = value;
  }

  void updateInsightSelectedMedidorStruct(Function(MedidorStruct) updateFn) {
    updateFn(_insightSelectedMedidor);
  }

  List<MedidorStruct> _medidores = [];
  List<MedidorStruct> get medidores => _medidores;
  set medidores(List<MedidorStruct> value) {
    _medidores = value;
  }

  void addToMedidores(MedidorStruct value) {
    medidores.add(value);
  }

  void removeFromMedidores(MedidorStruct value) {
    medidores.remove(value);
  }

  void removeAtIndexFromMedidores(int index) {
    medidores.removeAt(index);
  }

  void updateMedidoresAtIndex(
    int index,
    MedidorStruct Function(MedidorStruct) updateFn,
  ) {
    medidores[index] = updateFn(_medidores[index]);
  }

  void insertAtIndexInMedidores(int index, MedidorStruct value) {
    medidores.insert(index, value);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
