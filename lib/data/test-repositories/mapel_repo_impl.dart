
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/data/helpers/constant.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/repositories/mapel_repo.dart';
import 'package:rapor_lc/dummy_data/dummies.dart' as d;

class MataPelajaranRepositoryImplTest extends MataPelajaranRepository {
  final List<MataPelajaran> mapelList;

  // singleton
  MataPelajaranRepositoryImplTest._internal()
      : mapelList = [...d.mapelList, ...d.mapelList_observation];
  static final MataPelajaranRepositoryImplTest _instance = MataPelajaranRepositoryImplTest._internal();
  factory MataPelajaranRepositoryImplTest() => _instance;

  @override
  Future<RequestStatus> createMataPelajaran(MataPelajaran mapel) =>
      Future.delayed(DataConstant.test_duration, () async {
        final item = MataPelajaran.fromJson(mapel.toJson()..['id']=mapelList.length);
        mapelList.add(item);
        return RequestStatus.success;
        //failed
        return RequestStatus.failed;
      });

  @override
  Future<RequestStatus> deleteMataPelajaran(List<String> ids) async =>
      Future.delayed(DataConstant.test_duration, () async {
        mapelList.removeWhere((element) => ids.contains(element.id.toString()));
        return RequestStatus.success;
        //failed
        return RequestStatus.failed;
      });

  @override
  Future<List<MataPelajaran>> getMataPelajaranList() async =>
      Future.delayed(DataConstant.test_duration, () async {
        return mapelList;
        //failed
        throw Exception();
      });

  @override
  Future<RequestStatus> updateMataPelajaran(MataPelajaran mapel) async =>
      Future.delayed(DataConstant.test_duration, () async {
        final index = mapelList.indexOf(mapel);
        mapelList.replaceRange(
          index, index+1, [mapel]
        );
        return RequestStatus.success;
        //failed
        return RequestStatus.failed;
      });

  @override
  Future<List<MataPelajaran>> getNKVariables() async =>
      Future.delayed(DataConstant.test_duration, () async =>
          mapelList.where((element) => element.divisi?.id == 4).toList());

  @override
  String get url => throw UnimplementedError();
}