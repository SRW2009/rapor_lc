
import 'package:equatable/equatable.dart';
import 'package:rapor_lc/data/models/nhb_model.dart';
import 'package:rapor_lc/data/models/nk_model.dart';
import 'package:rapor_lc/data/models/abstract/npb_model.dart';
import 'package:rapor_lc/data/models/user_model.dart';
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

class SantriModel extends Equatable {
  SantriModel({
    required this.nis,
    required this.nama,
    this.daftar_nhb,
    this.daftar_nk,
    this.daftar_npb,
    this.guru,
  });

  final String nis;
  final String nama;
  List<NHBModel>? daftar_nhb;
  List<NKModel>? daftar_nk;
  List<NPBModel>? daftar_npb;
  UserModel? guru;

  factory SantriModel.fromJson(Map<String, dynamic> json) => SantriModel(
    nis: json['nis'],
    nama: json['nama'],
    daftar_nhb: (json['nhbs'] as List)
        .map<NHBModel>((e) => NHBModel.fromJson(e)).toList(),
    daftar_nk: (json['nks'] as List)
        .map<NKModel>((e) => NKModel.fromJson(e)).toList(),
    daftar_npb: (json['npbs'] as List)
        .map<NPBModel>((e) => NPBModel.fromJson(e)).toList(),
    guru: UserModel.fromJson(json['guru']),
  );

  Map<String, dynamic> toJson() => {
    'nis': nis,
    'nama': nama,
    'nhbs': daftar_nhb?.map<dynamic>((e) => e.toJson()).toList(),
    'nks': daftar_nk?.map<dynamic>((e) => e.toJson()).toList(),
    'npbs': daftar_npb?.map<dynamic>((e) => e.toJson()).toList(),
    'guru': guru?.toJson(),
  };
  
  Santri toEntity() => Santri(
      nis, nama,
      daftar_nhb: daftar_nhb?.map<NHB>((e) => e.toEntity()).toList(),
      daftar_nk: daftar_nk?.map<NK>((e) => e.toEntity()).toList(),
      daftar_npb: daftar_npb?.map<NPB>((e) => e.toEntity()).toList(),
      guru: guru?.toEntity(),
  );

  @override
  List<Object?> get props => [nis, nama, daftar_nhb, daftar_nk, daftar_npb, guru];
}