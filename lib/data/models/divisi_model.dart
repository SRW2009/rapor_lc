
import 'package:equatable/equatable.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';

class DivisiModel extends Equatable {
  DivisiModel({
    required this.id,
    required this.nama,
    required this.kadiv,
  });

  final int id;
  final String nama;
  final String kadiv;

  factory DivisiModel.fromJson(Map<String, dynamic> json) => DivisiModel(
    id: json['id'],
    nama: json['nama'],
    kadiv: json['kadiv'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nama': nama,
    'kadiv': kadiv,
  };

  Divisi toEntity() => Divisi(
    id, nama, kadiv
  );

  @override
  List<Object?> get props => [id, nama, kadiv];
}