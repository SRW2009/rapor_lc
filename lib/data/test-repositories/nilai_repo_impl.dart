
import 'package:rapor_lc/common/enum.dart';
import 'package:rapor_lc/data/helpers/constant.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/repositories/nilai_repo.dart';
import 'package:rapor_lc/dummy_data/dummies.dart' as d;

class NilaiRepositoryImplTest extends NilaiRepository {
  final List<Nilai> nilaiList;

  // singleton
  NilaiRepositoryImplTest._internal()
      : nilaiList = [d.nilai, d.nilai_observation];
  static final NilaiRepositoryImplTest _instance = NilaiRepositoryImplTest._internal();
  factory NilaiRepositoryImplTest() => _instance;

  @override
  Future<RequestStatus> createNilai(Nilai nilai) =>
      Future.delayed(DataConstant.test_duration, () async {
        final item = Nilai.fromJson(nilai.toJson()..['id']=nilaiList.length);
        nilaiList.add(item);
        return RequestStatus.success;
        //failed
        return RequestStatus.failed;
      });

  @override
  Future<RequestStatus> deleteNilai(List<String> ids) async =>
      Future.delayed(DataConstant.test_duration, () async {
        nilaiList.removeWhere((element) => ids.contains(element.id.toString()));
        return RequestStatus.success;
        //failed
        return RequestStatus.failed;
      });

  @override
  Future<List<Nilai>> getNilaiList() async =>
      Future.delayed(DataConstant.test_duration, () async {
        return nilaiList.toList();
        //failed
        throw Exception();
      });

  @override
  Future<RequestStatus> updateNilai(Nilai nilai) async =>
      Future.delayed(DataConstant.test_duration, () async {
        final index = nilaiList.indexOf(nilai);
        nilaiList.replaceRange(
          index, index+1, [nilai]
        );
        return RequestStatus.success;
        //failed
        return RequestStatus.failed;
      });
}