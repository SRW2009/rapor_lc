
import 'package:rapor_lc/data/models/abstract/npb_model.dart';
import 'package:rapor_lc/data/models/mata_pelajaran_model.dart';
import 'package:rapor_lc/data/models/santri_model.dart';
import 'package:rapor_lc/domain/entities/npbpo.dart';

class NPBPOModel extends NPBModel {
  NPBPOModel({
    required this.id,
    required this.santri,
    required this.semester,
    required this.tahunAjaran,
    required this.pelajaran,
    required this.presensi,
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

  factory NPBPOModel.fromJson(Map<String, dynamic> json) => NPBPOModel(
    id: json['id'],
    santri: SantriModel.fromJson(json['santri']),
    semester: json['semester'],
    tahunAjaran: json['tahunAjaran'],
    pelajaran: MataPelajaranModel.fromJson(json['pelajaran']),
    presensi: json['presensi'],
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
  };

  @override
  NPBPO toEntity() => NPBPO(
    id,
    santri.toEntity(),
    semester,
    tahunAjaran,
    pelajaran.toEntity(),
    presensi,
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
  ];
}