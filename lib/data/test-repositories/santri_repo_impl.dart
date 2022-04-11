
import 'package:rapor_lc/app/utils/temp_data.dart';
import 'package:rapor_lc/common/enum.dart';
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
        //failed
        return RequestStatus.failed;
      });

  @override
  Future<RequestStatus> deleteSantri(List<String> ids) async =>
      Future.delayed(DataConstant.test_duration, () async {
        santriList.removeWhere((element) => ids.contains(element.id.toString()));
        return RequestStatus.success;
        //failed
        return RequestStatus.failed;
      });

  @override
  Future<List<Santri>> getSantriList() async =>
      Future.delayed(DataConstant.test_duration, () async {
        return santriList;
        //failed
        throw Exception();
      });

  @override
  Future<RequestStatus> updateSantri(Santri santri) async =>
      Future.delayed(DataConstant.test_duration, () async {
        final index = santriList.indexOf(santri);
        santriList.replaceRange(
          index, index+1, [santri]
        );
        return RequestStatus.success;
        //failed
        return RequestStatus.failed;
      });
}