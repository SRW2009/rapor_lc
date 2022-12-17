
import 'package:json_annotation/json_annotation.dart';
import 'package:rapor_lc/data/models/nilai_model.dart';
import 'package:rapor_lc/domain/entities/nhb_block.dart';
import 'package:rapor_lc/domain/entities/nhb_semester.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/entities/npb.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/entities/timeline.dart';

part 'nilai.g.dart';

@JsonSerializable(createToJson: false)
@NKConverter()
class Nilai implements Comparable {
  final int id;

  @TimelineConverter()
  @JsonKey(name: 'semester')
  Timeline timeline;

  @JsonKey(name: 'year')
  String tahunAjaran;

  @JsonKey(name: 'student')
  Santri santri;

  @JsonKey(name: 'is_observation')
  bool isObservation;

  @JsonKey(readValue: _readJsonNHBSemester)
  List<NHBSemester> nhbSemester;
  static _readJsonNHBSemester(Map<dynamic, dynamic> val, k) => val['nhb']['semester'];
  @JsonKey(readValue: _readJsonNHBBlock)
  List<NHBBlock> nhbBlock;
  static _readJsonNHBBlock(Map<dynamic, dynamic> val, k) => val['nhb']['block'];
  List<NK> nk;
  List<NPB> npb;

  Nilai(this.id, this.timeline, this.tahunAjaran, this.santri,
      {this.nhbSemester=const [], this.nhbBlock=const [], this.nk=const [], this.npb=const [], this.isObservation=false});

  Nilai.empty() : id = -1, timeline = Timeline(0,0,0,0), tahunAjaran = '2021/2022',
        santri = Santri(0, ''), nhbSemester=const [], nhbBlock=const [], nk=const [], npb=const [], isObservation=false {
    nhbSemester = [];
    nhbBlock = [];
    nk = [];
    npb = [];
  }

  factory Nilai.fromJson(Map<String, dynamic> json) => _$NilaiFromJson(json);
  Map<String, dynamic> toJson() => NilaiModel.toJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Nilai &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          timeline == other.timeline &&
          tahunAjaran == other.tahunAjaran &&
          santri == other.santri &&
          isObservation == other.isObservation;

  @override
  int get hashCode =>
      id.hashCode ^ timeline.hashCode ^ tahunAjaran.hashCode ^ santri.hashCode ^ isObservation.hashCode;

  Nilai cloneWithoutData() => Nilai(
    this.id.toInt(),
    Timeline.fromInt(this.timeline.toInt()),
    this.tahunAjaran.toString(),
    Santri.fromJson(this.santri.toJson()),
    isObservation: bool.fromEnvironment('$isObservation'),
    nhbSemester: [],
    nhbBlock: [],
    nk: [],
    npb: []
  );

  @override
  int compareTo(other) {
    if (other is! Nilai) throw TypeError();
    final thisVal = double.tryParse('${tahunAjaran.split('/')[0]}.${timeline.level}${timeline.kelas}${timeline.bulanFormatted()}') ?? 0;
    final otherVal = double.tryParse('${other.tahunAjaran.split('/')[0]}.${other.timeline.level}${other.timeline.kelas}${other.timeline.bulanFormatted()}') ?? 0;
    return thisVal.compareTo(otherVal);
  }
}