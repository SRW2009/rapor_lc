
class Semester {
  final int n;

  Semester(this.n);

  @override
  String toString() {
    switch (n) {
      case 1: return 'Satu';
      case 2: return 'Dua';
      case 3: return 'Tiga';
      case 4: return 'Empat';
      case 5: return 'Lima';
      case 6: return 'Enam';
      default: return '';
    }
  }
}