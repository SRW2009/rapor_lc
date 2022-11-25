
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/common/print_settings.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/repositories/printing_repo.dart';

class PrintUseCase extends UseCase<String, PrintUseCaseParams> {
  final PrintingRepository repository;

  PrintUseCase(this.repository);

  @override
  Future<Stream<String?>> buildUseCaseStream(PrintUseCaseParams? e) async =>
      repository.print(e!.santriList, e.nilaiList, e.printSettings);
}

class PrintUseCaseParams {
  final List<Santri> santriList;
  final List<Nilai> nilaiList;
  final PrintSettings printSettings;

  PrintUseCaseParams(this.santriList, this.nilaiList, this.printSettings);
}