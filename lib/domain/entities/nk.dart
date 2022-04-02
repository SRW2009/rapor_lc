
import 'package:json_annotation/json_annotation.dart';

part 'nk.g.dart';

@JsonSerializable()
class NK {
  final int no;
  final String nama_variabel;
  final int nilai_mesjid;
  final int nilai_kelas;
  final int nilai_asrama;
  final int akumulatif;
  final String predikat;
  String note;

  NK(
      this.no,
      this.nama_variabel,
      this.nilai_mesjid,
      this.nilai_kelas,
      this.nilai_asrama,
      this.akumulatif,
      this.predikat,
      {this.note = ''}
  );

  factory NK.fromJson(Map<String, dynamic> json) => _$NKFromJson(json);
  Map<String, dynamic> toJson() => _$NKToJson(this);
}

class NKConverter implements JsonConverter<NK, Map<String, dynamic>> {
  const NKConverter();

  @override
  NK fromJson(Map<String, dynamic> json) => NK.fromJson(json);

  @override
  Map<String, dynamic> toJson(NK object) => object.toJson();
}

class NullableNKConverter implements JsonConverter<NK?, Map<String, dynamic>?> {
  const NullableNKConverter();

  @override
  NK? fromJson(Map<String, dynamic>? json) => json != null ? NK.fromJson(json) : null;

  @override
  Map<String, dynamic>? toJson(NK? object) => object?.toJson();
}