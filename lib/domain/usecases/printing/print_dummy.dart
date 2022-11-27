
import 'package:rapor_lc/domain/repositories/printing_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class PrintDummyUseCase extends BaseUseCase<void, void, PrintingRepository> {
  PrintingRepository repository;

  PrintDummyUseCase(this.repository) : super(repository, (repo, params) => repo.printDummy());
}