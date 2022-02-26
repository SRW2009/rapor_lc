
import 'package:equatable/equatable.dart';
import 'package:rapor_lc/data/models/mata_pelajaran_model.dart';
import 'package:rapor_lc/data/models/santri_model.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';

class NHBModel extends Equatable {
  NHBModel({
    required this.id,
    required this.santriModel,
    required this.mataPelajaranModel,
    required this.semester,
    required this.tahunAjaran,
    required this.nilaiHarian,
    required this.nilaiBulanan,
    required this.nilaiProject,
    required this.nilaiAkhir,
    required this.akumulasi,
    required this.predikat,
  });

  final int id;
  final SantriModel santriModel;
  final MataPelajaranModel mataPelajaranModel;
  final int semester;
  final String tahunAjaran;
  final int nilaiHarian;
  final int nilaiBulanan;
  final int nilaiProject;
  final int nilaiAkhir;
  final int akumulasi;
  final String predikat;

  factory NHBModel.fromJson(Map<String, dynamic> json) => NHBModel(
    id: json['id'],
    santriModel: SantriModel.fromJson(json['santriModel']),
    mataPelajaranModel: MataPelajaranModel.fromJson(json['mataPelajaranModel']),
    semester: json['semester'],
    tahunAjaran: json['tahunAjaran'],
    nilaiHarian: json['nilaiHarian'],
    nilaiBulanan: json['nilaiBulanan'],
    nilaiProject: json['nilaiProject'],
    nilaiAkhir: json['nilaiAkhir'],
    akumulasi: json['akumulasi'],
    predikat: json['predikat'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'santriModel': santriModel.toJson(),
    'mataPelajaranModel': mataPelajaranModel.toJson(),
    'semester': semester,
    'tahunAjaran': tahunAjaran,
    'nilaiHarian': nilaiHarian,
    'nilaiBulanan': nilaiBulanan,
    'nilaiProject': nilaiProject,
    'nilaiAkhir': nilaiAkhir,
    'akumulasi': akumulasi,
    'predikat': predikat,
  };

  NHB toEntity() => NHB(
    id,
    santriModel.toEntity(),
    mataPelajaranModel.toEntity(),
    semester,
    tahunAjaran,
    nilaiHarian,
    nilaiBulanan,
    nilaiProject,
    nilaiAkhir,
    akumulasi,
    predikat,
  );

  @override
  List<Object?> get props => [
    id,
    santriModel,
    mataPelajaranModel,
    semester,
    tahunAjaran,
    nilaiHarian,
    nilaiBulanan,
    nilaiProject,
    nilaiAkhir,
    akumulasi,
    predikat,
  ];
}