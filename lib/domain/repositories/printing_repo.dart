
import 'package:rapor_lc/common/print_settings.dart';
import 'package:rapor_lc/common/repository.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

abstract class PrintingRepository extends Repository {
  Stream<String> print(List<Santri> santriList, List<Nilai> nilaiList, PrintSettings printSettings);
  Future<void> printDummy();
}