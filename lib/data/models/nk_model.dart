
import 'package:equatable/equatable.dart';
import 'package:rapor_lc/data/models/santri_model.dart';
import 'package:rapor_lc/domain/entities/nk.dart';

class NKModel extends Equatable {
  const NKModel({
    required this.id,
    required this.santri,
    required this.bulan,
    required this.semester,
    required this.tahunAjaran,
    required this.variable,
    required this.nilaiMesjid,
    required this.nilaiKelas,
    required this.nilaiAsrama,
    required this.akumulatif,
    required this.predikat,
  });

  final int id;
  final SantriModel santri;
  final int bulan;
  final int semester;
  final String tahunAjaran;
  final String variable;
  final int nilaiMesjid;
  final int nilaiKelas;
  final int nilaiAsrama;
  final int akumulatif;
  final String predikat;

  factory NKModel.fromJson(Map<String, dynamic> json) => NKModel(
    id: json['id'],
    santri: SantriModel.fromJson(json['santri']),
    bulan: json['bulan'],
    semester: json['semester'],
    tahunAjaran: json['tahunAjaran'],
    variable: json['variable'],
    nilaiMesjid: json['nilaiMesjid'],
    nilaiKelas: json['nilaiKelas'],
    nilaiAsrama: json['nilaiAsrama'],
    akumulatif: json['akumulatif'],
    predikat: json['predikat'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'santri': santri.toJson(),
    'bulan': bulan,
    'semester': semester,
    'tahunAjaran': tahunAjaran,
    'variable': variable,
    'nilaiMesjid': nilaiMesjid,
    'nilaiKelas': nilaiKelas,
    'nilaiAsrama': nilaiAsrama,
    'akumulatif': akumulatif,
    'predikat': predikat,
  };

  NK toEntity() => NK(
    id,
    santri.toEntity(),
    semester,
    tahunAjaran,
    bulan,
    variable,
    nilaiMesjid,
    nilaiKelas,
    nilaiAsrama,
    akumulatif,
    predikat,
  );

  @override
  List<Object?> get props => [
    id,
    santri,
    bulan,
    semester,
    tahunAjaran,
    variable,
    nilaiMesjid,
    nilaiKelas,
    nilaiAsrama,
    akumulatif,
    predikat,
  ];
}