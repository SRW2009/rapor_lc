
import 'package:equatable/equatable.dart';
import 'package:rapor_lc/data/models/mata_pelajaran_model.dart';
import 'package:rapor_lc/data/models/santri_model.dart';
import 'package:rapor_lc/domain/entities/npbpo.dart';

class NPBPOModel extends Equatable {
  NPBPOModel({
    required this.id,
    required this.santri,
    required this.semester,
    required this.tahunAjaran,
    required this.pelajaran,
    required this.presensi,
  });

  final int id;
  final SantriModel santri;
  final int semester;
  final String tahunAjaran;
  final MataPelajaranModel pelajaran;
  final String presensi;

  factory NPBPOModel.fromJson(Map<String, dynamic> json) => NPBPOModel(
    id: json['id'],
    santri: SantriModel.fromJson(json['santri']),
    semester: json['semester'],
    tahunAjaran: json['tahunAjaran'],
    pelajaran: MataPelajaranModel.fromJson(json['pelajaran']),
    presensi: json['presensi'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'santri': santri.toJson(),
    'semester': semester,
    'tahunAjaran': tahunAjaran,
    'pelajaran': pelajaran.toJson(),
    'presensi': presensi,
  };

  NPBPO toEntity() => NPBPO(
    id,
    santri.toEntity(),
    semester,
    tahunAjaran,
    pelajaran.toEntity(),
    presensi,
  );

  @override
  List<Object?> get props => [
    id,
    santri,
    semester,
    tahunAjaran,
    pelajaran,
    presensi,
  ];
}