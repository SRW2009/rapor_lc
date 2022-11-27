
import 'package:flutter_test/flutter_test.dart';
import 'package:rapor_lc/domain/entities/timeline.dart';

void main() {
  group('Timeline factory from int test', () {
    test('Range error test', () {
      expect(() => Timeline.fromInt(Timeline.INT_MIN-1), throwsA(isRangeError));
      expect(() => Timeline.fromInt(Timeline.INT_MAX+1), throwsA(isRangeError));
    });
    test('Min value test', () => expect(Timeline.fromInt(Timeline.INT_MIN), Timeline(1, 1, 1, 1)));
    test('Max value test', () => expect(Timeline.fromInt(Timeline.INT_MAX), Timeline(12, 2, 3, 2)));
    test('Random value test', () {
      expect(Timeline.fromInt(7), Timeline(7, 2, 1, 1));
      expect(Timeline.fromInt(13), Timeline(1, 1, 2, 1));
      expect(Timeline.fromInt(20), Timeline(8, 2, 2, 1));
      expect(Timeline.fromInt(52), Timeline(4, 1, 2, 2));
    });
  });
  group('Timeline to int test', () {
    test('Min value test', () => expect(Timeline(1, 1, 1, 1).toInt(), Timeline.INT_MIN));
    test('Max value test', () => expect(Timeline(12, 2, 3, 2).toInt(), Timeline.INT_MAX));
    test('Random value test', () {
      expect(Timeline(7, 2, 1, 1).toInt(), 7);
      expect(Timeline(1, 1, 2, 1).toInt(), 13);
      expect(Timeline(8, 2, 2, 1).toInt(), 20);
      expect(Timeline(4, 1, 2, 2).toInt(), 52);
    });
  });
}
