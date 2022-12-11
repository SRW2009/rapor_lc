
import 'package:rapor_lc/app/utils/loaded_settings.dart';
import 'package:rapor_lc/domain/entities/nk.dart';

class NKAdviceFactory {
  Map<String, NK> contents;

  NKAdviceFactory(this.contents);

  String generate() {
    var s = LoadedSettings.nkAdvice;
    if (s.isEmpty) return s;

    for (var nk in contents.values) {
      s = s.replaceAll('{${nk.nama_variabel}:val}', nk.akumulatif.toString())
        .replaceAll('{${nk.nama_variabel}:inpred}', nk.predikat)
        .replaceAll('{${nk.nama_variabel}:pred}', _parser(nk.predikat));
    }
    return s;
  }

  String _parser(String predicate) {
    if (predicate == 'BA') return 'belum ada';
    if (predicate == 'MB') return 'mulai berkembang';
    if (predicate == 'BB') return 'berkembang baik';
    if (predicate == 'BSB') return 'berkembang sangat baik';
    return '';
  }
}