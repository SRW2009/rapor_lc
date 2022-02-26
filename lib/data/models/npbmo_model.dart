
import 'package:equatable/equatable.dart';
import 'package:rapor_lc/data/models/mata_pelajaran_model.dart';
import 'package:rapor_lc/data/models/santri_model.dart';
import 'package:rapor_lc/domain/entities/npbmo.dart';

class NPBMOModel extends Equatable {
  const NPBMOModel({
    required this.id,
    required this.santri,
    required this.semester,
    required this.tahunAjaran,
    required this.pelajaran,
    required this.presensi,
    required this.n,
  });

  final int id;
  final SantriModel santri;
  final int semester;
  final String tahunAjaran;
  final MataPelajaranModel pelajaran;
  final String presensi;
  final int n;

  factory NPBMOModel.fromJson(Map<String, dynamic> json) => NPBMOModel(
    id: json['id'],
    santri: SantriModel.fromJson(json['santri']),
    semester: json['semester'],
    tahunAjaran: json['tahunAjaran'],
    pelajaran: MataPelajaranModel.fromJson(json['pelajaran']),
    presensi: json['presensi'],
    n: json['n'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'santri': santri.toJson(),
    'semester': semester,
    'tahunAjaran': tahunAjaran,
    'pelajaran': pelajaran.toJson(),
    'presensi': presensi,
    'n': n,
  };

  NPBMO toEntity() => NPBMO(
    id,
    santri.toEntity(),
    semester,
    tahunAjaran,
    pelajaran.toEntity(),
    presensi,
    n,
  );

  @override
  List<Object?> get props => [
    id,
    santri,
    semester,
    tahunAjaran,
    pelajaran,
    presensi,
    n,
  ];
}