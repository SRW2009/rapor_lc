
class NilaiCalculation {
  static double accumulate(List<int> grades) {
    int skipped = 0;
    num total = (grades.fold<int>(0, (x, y) {
      if (y==-1) skipped++;
      return (y==-1) ? x : x+y;
    })/(grades.length-skipped));
    return total.isNaN ? 0 : (double.tryParse(total.toStringAsFixed(2)) ?? 0);
  }

  static String toPredicate(double accumulation) {
    if (accumulation > 91.5) return 'A';
    if (accumulation > 83.25) return 'A-';
    if (accumulation > 75) return 'B+';
    if (accumulation > 66.5) return 'B';
    if (accumulation > 58.25) return 'B-';
    if (accumulation > 50) return 'C+';
    if (accumulation > 41.5) return 'C';
    if (accumulation > 33.25) return 'C-';
    if (accumulation > 25) return 'D+';
    if (accumulation > 0) return 'D';
    return 'D-';
  }
}