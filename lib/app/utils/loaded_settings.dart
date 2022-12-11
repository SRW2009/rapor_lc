
import 'package:rapor_lc/app/utils/constants.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/setting.dart';

// Define aliases
typedef NKEnabledGradeType = Map<_VariableName, Map<_GradeType, _IsEnabled>>;
typedef NKEnabledGradeTypeEntry = MapEntry<_VariableName, Map<_GradeType, _IsEnabled>>;
typedef _VariableName = String;
typedef _GradeType = String;
typedef _IsEnabled = bool;

class LoadedSettings {
  static Divisi? divisiKesantrian;
  static List<MataPelajaran>? nkVariables;

  static int _nhbMinValToPassId = -1;
  static int get nhbMinValToPassId => _nhbMinValToPassId;
  static int? _nhbMinValToPass;
  static int get nhbMinValToPass => _nhbMinValToPass ?? 60;

  static int _nkEnabledGradeId = -1;
  static int get nkEnabledGradeId => _nkEnabledGradeId;
  static NKEnabledGradeType? _nkEnabledGrade;

  static int _nkAdviceId = -1;
  static int get nkAdviceId => _nkAdviceId;
  static String? _nkAdvice;
  static String get nkAdvice => _nkAdvice ?? '';

  LoadedSettings.load(List<Setting> settings) {
    for (var s in settings) {
      switch (s.variable) {
        case SettingVariables.nhbMinValToPass:
          _nhbMinValToPassId = s.id;
          _nhbMinValToPass = s.value;
          break;
        case SettingVariables.nkEnabledGrade:
          _nkEnabledGradeId = s.id;
          _nkEnabledGrade = (s.value as Map<String, dynamic>)
              .map<_VariableName, Map<_GradeType, _IsEnabled>>((key, value) =>
              MapEntry(key, (value as Map<String, dynamic>).map<_GradeType, _IsEnabled>((key, value) =>
                  MapEntry(key, value)),
          ));
          break;
        case SettingVariables.nkAdvice:
          _nkAdviceId = s.id;
          _nkAdvice = s.value;
          break;
      }
    }
  }

  static bool isNKGradeEnabled(String variableName, String gradeType) =>
      (_nkEnabledGrade?[variableName]?[gradeType] ?? true);

  static List<NKEnabledGradeTypeEntry> getNkEnabledGradeEntries() {
    if (_nkEnabledGrade?.isEmpty ?? true) return [];

    final list = List.of(nkEnabledGradeConvertToEntries(_nkEnabledGrade!));
    final allVariables = list.map<String>((e) => e.key).toList();

    final unattendedVariables = <String>[];
    for (var o in (nkVariables ?? <MataPelajaran>[])) {
      if (allVariables.contains(o.name)) continue;
      unattendedVariables.add(o.name);
    }
    for (var e in unattendedVariables) {
      list.add(MapEntry(
        e, {'mesjid':true, 'asrama':true, 'kelas':true},
      ));
    }
    return list;
  }

  static List<NKEnabledGradeTypeEntry> nkEnabledGradeConvertToEntries(NKEnabledGradeType map) {
    return map.entries.map<NKEnabledGradeTypeEntry>((e) =>
          MapEntry(e.key.toString(), e.value.map<String, bool>((key, value) =>
              MapEntry(key.toString(), value)))).toList();
  }

  static NKEnabledGradeType nkEnabledGradeConvertToMap(List<NKEnabledGradeTypeEntry> entries) => {
    for (var o in entries) o.key: {
      for (var o2 in o.value.entries) o2.key: o2.value,
    }
  };
}