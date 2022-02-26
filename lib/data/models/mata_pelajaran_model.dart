
import 'package:equatable/equatable.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';

import 'divisi_model.dart';

class MataPelajaranModel extends Equatable {
  MataPelajaranModel({
    required this.id,
    required this.divisiModel,
    required this.namaMapel,
  });

  final int id;
  final DivisiModel divisiModel;
  final String namaMapel;

  factory MataPelajaranModel.fromJson(Map<String, dynamic> json) => MataPelajaranModel(
    id: json['id'],
    divisiModel: DivisiModel.fromJson(json['divisiModel']),
    namaMapel: json['namaMapel'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'divisiModel': divisiModel.toJson(),
    'namaMapel': namaMapel,
  };

  MataPelajaran toEntity() => MataPelajaran(
    id, divisiModel.toEntity(), namaMapel
  );

  @override
  List<Object?> get props => [id, divisiModel, namaMapel];
}