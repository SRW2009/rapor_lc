
import 'dart:convert';

import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/entities/user.dart';
import 'package:rapor_lc/domain/entities/abstract/npb.dart';

import 'package:json_annotation/json_annotation.dart';

part 'santri.g.dart';

@JsonSerializable()
@UserConverter()
@NHBConverter()
@NKConverter()
@NPBConverter()
class Santri {
  final String nis;
  final String nama;
  final User? guru;
  final List<NHB>? daftar_nhb;
  final List<NK>? daftar_nk;
  final List<NPB>? daftar_npb;

  Santri(this.nis, this.nama, {
    this.guru, this.daftar_nhb,
    this.daftar_nk, this.daftar_npb,
  });

  factory Santri.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return _$SantriFromJson(json);
    } else if (json is String) {
      Map<String, dynamic> newJson = jsonDecode(json);
      return _$SantriFromJson(newJson);
    }
    throw Exception('Parsing error');
  }
  Map<String, dynamic> toJson() => _$SantriToJson(this);
}

class SantriConverter implements JsonConverter<Santri, Map<String, dynamic>> {
  const SantriConverter();

  @override
  Santri fromJson(Map<String, dynamic> json) => Santri.fromJson(json);

  @override
  Map<String, dynamic> toJson(Santri object) => object.toJson();
}