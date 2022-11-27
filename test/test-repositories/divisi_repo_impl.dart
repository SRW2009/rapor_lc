
import 'package:rapor_lc/common/enum/request_status.dart';
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
        final item = Divisi.fromJson(divisi.toJson()..['id']=divisiList.length);
        divisiList.add(item);
        return RequestStatus.success;
      });

  @override
  Future<RequestStatus> deleteDivisi(List<String> ids) async =>
      Future.delayed(DataConstant.test_duration, () async {
        divisiList.removeWhere((element) => ids.contains(element.id.toString()));
        return RequestStatus.success;
      });

  @override
  Future<List<Divisi>> getDivisiList() async =>
      Future.delayed(DataConstant.test_duration, () async {
        return divisiList;
      });

  @override
  Future<RequestStatus> updateDivisi(Divisi divisi) async =>
      Future.delayed(DataConstant.test_duration, () async {
        final index = divisiList.indexOf(divisi);
        divisiList.replaceRange(
          index, index+1, [divisi]
        );
        return RequestStatus.success;
      });

  @override
  String url = '';
}