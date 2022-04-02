
import 'package:rapor_lc/common/enum.dart';
import 'package:rapor_lc/data/helpers/constant.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/domain/repositories/divisi_repo.dart';
import 'package:rapor_lc/dummy_data/dummies.dart' as d;

class DivisiRepositoryImplTest extends DivisiRepository {
  final List<Divisi> divisiList;

  // singleton
  DivisiRepositoryImplTest._internal()
      : divisiList = [...d.divisiList];
  static final DivisiRepositoryImplTest _instance = DivisiRepositoryImplTest._internal();
  factory DivisiRepositoryImplTest() => _instance;
  
  @override
  Future<RequestStatus> createDivisi(Divisi divisi) =>
      Future.delayed(DataConstant.test_duration, () async {
        divisiList.add(divisi);
        return RequestStatus.success;
        //failed
        return RequestStatus.failed;
      });

  @override
  Future<RequestStatus> deleteDivisi(List<String> ids) async =>
      Future.delayed(DataConstant.test_duration, () async {
        divisiList.removeWhere((element) => ids.contains(element.id.toString()));
        return RequestStatus.success;
        //failed
        return RequestStatus.failed;
      });

  @override
  Future<List<Divisi>> getDivisiList() async =>
      Future.delayed(DataConstant.test_duration, () async {
        return divisiList;
        //failed
        throw Exception();
      });

  @override
  Future<RequestStatus> updateDivisi(Divisi divisi) async =>
      Future.delayed(DataConstant.test_duration, () async {
        final index = divisiList.indexOf(divisi);
        divisiList.replaceRange(
          index, index+1, [divisi]
        );
        return RequestStatus.success;
        //failed
        return RequestStatus.failed;
      });
}