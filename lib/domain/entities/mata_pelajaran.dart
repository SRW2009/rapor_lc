
import 'package:json_annotation/json_annotation.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';

part 'mata_pelajaran.g.dart';

@JsonSerializable()
class MataPelajaran {
  final int id;
  final String name;
  final String? abbreviation;
  @JsonKey(name: 'divisi_detail')
  Divisi divisi;

  MataPelajaran(this.id, this.name, {this.abbreviation, required this.divisi});

  factory MataPelajaran.fromJson(Map<String, dynamic> json) => _$MataPelajaranFromJson(json);
  Map<String, dynamic> toJson() => _$MataPelajaranToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MataPelajaran &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}