
import 'dart:io';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/domain/repositories/excel_repo.dart';

class ImportNilaiUseCase extends UseCase<String, List<File>> {
  ExcelRepository repository;

  ImportNilaiUseCase(this.repository);

  @override
  Future<Stream<String?>> buildUseCaseStream(List<File>? params) async =>
      repository.importNilai(params ?? []);
}