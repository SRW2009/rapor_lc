
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/data/helpers/constant.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/repositories/santri_repo.dart';
import 'package:rapor_lc/dummy_data/dummies.dart' as d;

class SantriRepositoryImplTest extends SantriRepository {
  final List<Santri> santriList;

  // singleton
  SantriRepositoryImplTest._internal()
      : santriList = [...d.santriList];
  static final SantriRepositoryImplTest _instance = SantriRepositoryImplTest._internal();
  factory SantriRepositoryImplTest() => _instance;

  @override
  Future<RequestStatus> createSantri(Santri santri) =>
      Future.delayed(DataConstant.test_duration, () async {
        final item = Santri.fromJson(santri.toJson()..['id']=santriList.length);
        santriList.add(item);
        return RequestStatus.success;
      });

  @override
  Future<RequestStatus> deleteSantri(List<String> ids) async =>
      Future.delayed(DataConstant.test_duration, () async {
        santriList.removeWhere((element) => ids.contains(element.id.toString()));
        return RequestStatus.success;
      });

  @override
  Future<List<Santri>> getSantriList() async =>
      Future.delayed(DataConstant.test_duration, () async {
        return santriList;
      });

  @override
  Future<RequestStatus> updateSantri(Santri santri) async =>
      Future.delayed(DataConstant.test_duration, () async {
        final index = santriList.indexOf(santri);
        santriList.replaceRange(
          index, index+1, [santri]
        );
        return RequestStatus.success;
      });

  @override
  String url = '';
}