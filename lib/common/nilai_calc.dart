
class NilaiCalculation {
  static int accumulate(List<int> grades) {
    num total = (grades.fold<int>(0, (x, y) => x+y)/grades.length);
    return total.isNaN ? 0 : total.round();
  }

  static String toPredicate(int accumulation) {
    if (accumulation >= 90) return 'A';
    if (accumulation >= 75) return 'B';
    if (accumulation >= 60) return 'C';
    if (accumulation >= 40) return 'D';
    if (accumulation >= 20) return 'E';
    return 'F';
  }
}