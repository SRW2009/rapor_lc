
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/domain/repositories/divisi_repo.dart';
import 'package:rapor_lc/dummy_data/divisi.dart';

class DivisiRepositoryImpl extends DivisiRepository {
  @override
  Future<RequestStatus> createDivisi(Divisi divisi) {
    // TODO: implement createDivisi
    throw UnimplementedError();
  }

  @override
  Future<RequestStatus> deleteDivisi(List<String> ids) {
    // TODO: implement deleteDivisi
    throw UnimplementedError();
  }

  @override
  Future<Divisi> getDivisi(int id) {
    // TODO: implement getDivisi
    throw UnimplementedError();
  }

  @override
  Future<List<Divisi>> getDivisiList() async {
    // TODO: implement getDivisiList
    await Future.delayed(const Duration(seconds: 3));
    return divisiMap.values.toList();
  }

  @override
  Future<RequestStatus> updateDivisi(Divisi divisi) {
    // TODO: implement updateDivisi
    throw UnimplementedError();
  }
}