
import 'package:rapor_lc/data/models/abstract/npb_model.dart';
import 'package:rapor_lc/data/models/mata_pelajaran_model.dart';
import 'package:rapor_lc/data/models/santri_model.dart';
import 'package:rapor_lc/domain/entities/npbmo.dart';

class NPBMOModel extends NPBModel {
  NPBMOModel({
    required this.id,
    required this.santri,
    required this.semester,
    required this.tahunAjaran,
    required this.pelajaran,
    required this.presensi,
    required this.n,
  });

  @override
  final int id;
  @override
  final SantriModel santri;
  @override
  final int semester;
  @override
  final String tahunAjaran;
  @override
  final MataPelajaranModel pelajaran;
  @override
  final String presensi;
  @override
  String note = '';
  final int n;

  factory NPBMOModel.fromJson(Map<String, dynamic> json) => NPBMOModel(
    id: json['id'],
    santri: SantriModel.fromJson(json['santri']),
    semester: json['semester'],
    tahunAjaran: json['tahunAjaran'],
    pelajaran: MataPelajaranModel.fromJson(json['pelajaran']),
    presensi: json['presensi'],
    n: json['n'],
  )..note=json['note'];

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'santri': santri.toJson(),
    'semester': semester,
    'tahunAjaran': tahunAjaran,
    'pelajaran': pelajaran.toJson(),
    'presensi': presensi,
    'note': note,
    'n': n,
  };

  @override
  NPBMO toEntity() => NPBMO(
    id,
    santri.toEntity(),
    semester,
    tahunAjaran,
    pelajaran.toEntity(),
    presensi,
    n,
  )..note=note;

  @override
  List<Object?> get props => [
    id,
    santri,
    semester,
    tahunAjaran,
    pelajaran,
    presensi,
    note,
    n,
  ];
}