
import 'package:rapor_lc/common/nk_advice_factory.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('NK Advice format test', () {
    final s = 'Nilai ananda dinilai {Inisiatif:pred}.';
    final sf = s.replaceAll('{Inisiatif:pred}', 'REPLACED');
    print(sf);
    expect(sf, 'Nilai ananda dinilai REPLACED.');
  });
}